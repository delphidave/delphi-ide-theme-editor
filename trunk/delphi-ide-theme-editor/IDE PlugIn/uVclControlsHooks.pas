{**************************************************************************************************}
{                                                                                                  }
{ Unit uVclControlsHooks                                                                           }
{ unit uVclControlsHooks  for the Delphi IDE Colorizer                                             }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is uVclControlsHooks.pas.                                                      }
{                                                                                                  }
{ The Initial Developer of the Original Code is Rodrigo Ruz V.                                     }
{ Portions created by Rodrigo Ruz V. are Copyright (C) 2011 Rodrigo Ruz V.                         }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{**************************************************************************************************}

unit uVclControlsHooks;

interface

uses
  Dialogs,
  Windows,
  Classes,
  SysUtils,
  Graphics,
  ImgList,
  CommCtrl,
  Themes,
  uHookLib;

implementation

type
  TCustomImageListHack = class(TCustomImageList);
  //TCustomActionBarHack  = class(TCustomActionBar);

var
  //BackupThemeControl                  : TXRedirCode;
  BackupCustomImage_DoDraw            : TXRedirCode;
  //BackupCustomActionBar_GetColorMap   : TXRedirCode;

{$IFDEF Hack_TPageControl}
  OrgTTabSheet_NewInstance            : Pointer;
  OrgTPageControl_NewInstance         : Pointer;
{$ENDIF}
  {
 OrgFoo            : procedure;
 FooBackUp         : TXRedirCode;
   }
//Const
  //FooMethod='@Editcolorpage@TEditorColor@SetColorSpeedSetting$qqr26Vedopts@TColorSpeedSetting';
  //FooMethod='@Editcolorpage@TEditorColor@ColorSpeedSettingClick$qqrp14System@TObject';


procedure Bitmap2GrayScale(const BitMap: TBitmap);
type
  TRGBArray = array[0..32767] of TRGBTriple;
  PRGBArray = ^TRGBArray;
var
  x, y, Gray: Integer;
  Row       : PRGBArray;
begin
  BitMap.PixelFormat := pf24Bit;
  for y := 0 to BitMap.Height - 1 do
  begin
    Row := BitMap.ScanLine[y];
    for x := 0 to BitMap.Width - 1 do
    begin
      Gray             := (Row[x].rgbtRed + Row[x].rgbtGreen + Row[x].rgbtBlue) div 3;
      Row[x].rgbtRed   := Gray;
      Row[x].rgbtGreen := Gray;
      Row[x].rgbtBlue  := Gray;
    end;
  end;
end;

//from ImgList.GetRGBColor
function GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone:
      Result := CLR_NONE;
    clDefault:
      Result := CLR_DEFAULT;
  end;
end;

procedure CustomImageListHack_DoDraw(Self: TObject; Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean);
var
  MaskBitMap : TBitmap;
  GrayBitMap : TBitmap;
begin
  with TCustomImageListHack(Self) do
  begin
    if not HandleAllocated then Exit;
    if Enabled then
      ImageList_DrawEx(Handle, Index, Canvas.Handle, X, Y, 0, 0, GetRGBColor(BkColor), GetRGBColor(BlendColor), Style)
    else
    begin
      GrayBitMap := TBitmap.Create;
      MaskBitMap := TBitmap.Create;
      try
        GrayBitMap.SetSize(Width, Height);
        MaskBitMap.SetSize(Width, Height);
        GetImages(Index, GrayBitMap, MaskBitMap);
        Bitmap2GrayScale(GrayBitMap);
        BitBlt(Canvas.Handle, X, Y, Width, Height, MaskBitMap.Canvas.Handle, 0, 0, SRCERASE);
        BitBlt(Canvas.Handle, X, Y, Width, Height, GrayBitMap.Canvas.Handle, 0, 0, SRCINVERT);
      finally
        GrayBitMap.Free;
        MaskBitMap.Free;
      end;
    end;
  end;
end;


//Let draws the TGroupBox,TRadioGroup,TPropRadioGroup Flat, unthemed
{
function Hack_ThemeControl(AControl: TControl): Boolean;
begin
  Result := False;
  if not (csDesigning in AControl.ComponentState)  then   exit;
  if AControl = nil then exit;
  Result := (not (csDesigning in AControl.ComponentState) and ThemeServices.ThemesEnabled) or
            ((csDesigning in AControl.ComponentState) and (AControl.Parent <> nil) and
             (ThemeServices.ThemesEnabled and not UnthemedDesigner(AControl.Parent)));
end;
}



procedure Test;
begin
  //OrgFoo;
  ShowMessage('Foo');
end;


procedure InstallHooks;
{$IFOPT W+}{$DEFINE WARN}{$ENDIF}{$WARNINGS OFF} // no compiler warning
const
  vmtNewInstance = System.vmtNewInstance;
{$IFDEF WARN}{$WARNINGS ON}{$ENDIF}
begin
  HookProc(@TCustomImageListHack.DoDraw, @CustomImageListHack_DoDraw, BackupCustomImage_DoDraw);
  //HookProc(@Themes.ThemeControl, @Hack_ThemeControl, BackupThemeControl);
  //HookProc(@TCustomActionBarHack.GetColorMap, @Hack_ThemeControl, BackupThemeControl);

{$IFDEF Hack_TPageControl}
  OrgTTabSheet_NewInstance := GetVirtualMethod(TTabSheet, vmtNewInstance);
  SetVirtualMethod(ComCtrls.TTabSheet, vmtNewInstance, @TTabSheet_NewInstance);

  OrgTPageControl_NewInstance := GetVirtualMethod(TPageControl, vmtNewInstance);
  SetVirtualMethod(ComCtrls.TPageControl, vmtNewInstance, @TPageControl_NewInstance);
{$ENDIF}


{
  OrgFoo := GetProcAddress(LoadPackage(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'coreide160.bpl'), FooMethod);
  if @OrgFoo <> nil then
    HookProc(@OrgFoo, @Test, FooBackUp);
}
end;

procedure RemoveHooks;
{$IFOPT W+}{$DEFINE WARN}{$ENDIF}{$WARNINGS OFF} // no compiler warning
const
  vmtNewInstance = System.vmtNewInstance;
{$IFDEF WARN}{$WARNINGS ON}{$ENDIF}
begin
  UnhookProc(@TCustomImageListHack.DoDraw, BackupCustomImage_DoDraw);
  //UnhookProc(@Themes.ThemeControl, BackupThemeControl);

{$IFDEF Hack_TPageControl}
  SetVirtualMethod(ComCtrls.TTabSheet, vmtNewInstance, OrgTTabSheet_NewInstance);
  SetVirtualMethod(ComCtrls.TPageControl, vmtNewInstance, OrgTPageControl_NewInstance);
{$ENDIF}

      {
  if @OrgFoo <> nil then
    UnhookProc(@OrgFoo, FooBackUp);
     }
end;

{

    004228A4 17391 1F38 __fastcall Editcolorpage::Finalization()
    00420B94 17411 1F39 Editcolorpage::TEditorColor::
    00422188 17400 1F3A __fastcall Editcolorpage::TEditorColor::ColorClick(System::TObject *)
    0042174C 17407 1F3B __fastcall Editcolorpage::TEditorColor::ColorSpeedSettingClick(System::TObject *)
    004224BC 17396 1F3C __fastcall Editcolorpage::TEditorColor::DefaultClick(System::TObject *)
    00422414 17397 1F3D __fastcall Editcolorpage::TEditorColor::EditorColorBroadcast(System::TObject *, Winapi::Messages::TMessage&)
    00421584 17409 1F3E __fastcall Editcolorpage::TEditorColor::EditorColorCreate(System::TObject *)
    00421730 17408 1F3F __fastcall Editcolorpage::TEditorColor::EditorColorDestroy(System::TObject *)
    004217B0 17406 1F40 __fastcall Editcolorpage::TEditorColor::ElementListClick(System::TObject *)
    004222E8 17399 1F41 __fastcall Editcolorpage::TEditorColor::FontClick(System::TObject *)
    004225DC 17395 1F42 __fastcall Editcolorpage::TEditorColor::HelpClick(System::TObject *)
    00421AE8 17404 1F43 __fastcall Editcolorpage::TEditorColor::InitLineFlags(const System::DelphiInterface<Toolsapi::IOTAHighlighterPreview>)
    004219B8 17405 1F44 __fastcall Editcolorpage::TEditorColor::InitSamplePane()
    00421BC8 17403 1F45 __fastcall Editcolorpage::TEditorColor::InitSyntaxEditView(const System::DelphiInterface<Toolsapi::IOTAHighlighterPreview>)
    0042262C 17393 1F46 __fastcall Editcolorpage::TEditorColor::LoadHighlightPreviews()
    004225F4 17394 1F47 __fastcall Editcolorpage::TEditorColor::MarkDirty()
    004220E4 17401 1F48 __fastcall Editcolorpage::TEditorColor::SampleClick(System::TObject *)
    00422080 17402 1F49 __fastcall Editcolorpage::TEditorColor::SetColorSpeedSetting(Vedopts::TColorSpeedSetting)
    0042238C 17398 1F4A __fastcall Editcolorpage::TEditorColor::UpdateSamplePane()
    00422814 17392 1F4B __fastcall Editcolorpage::TEditorColor::tbsetPreviewsChange(System::TObject *, int, bool&)
    004AA8D4 17390 1F4C __fastcall Editcolorpage::initialization()
}


initialization
 InstallHooks;
finalization
 RemoveHooks;
end.

