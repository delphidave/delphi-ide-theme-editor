//**************************************************************************************************
//
// Unit Main
// unit Main  for the Delphi IDE Colorizer
//
// The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy of the
// License at http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
// ANY KIND, either express or implied. See the License for the specific language governing rights
// and limitations under the License.
//
// The Original Code is Main.pas.
//
// The Initial Developer of the Original Code is Rodrigo Ruz V.
// Portions created by Rodrigo Ruz V. are Copyright (C) 2011-2014 Rodrigo Ruz V.
// All Rights Reserved.
//
//
//
//**************************************************************************************************

//TODO

{
  * popup menu tool bars (ex :recent files) -> create hook using colormap
  * TIDEGradientTabSet border lines   -->  hook Pen.Color , Canvas.Polyline? ?
  * TClosableTabScroller background
  * TRefactoringTree


                      TDisassemblerView - colors?
    TStackViewFrame - TDumpVie0w
    TRegisterView
    TFlagsView

    TFPUWindow

  * restore support for Delphi 2007

  * Docked forms title (active/inactive). done
  * TStatusBar separators   done
  * TTabSet background - done
  * gutter code editor   - done:
  * detect parent object from class - done via JCL ProcByLevel
  * popup menu code editor  -done :)
  * TIDEGradientTabSet background done
  * remove access violations on manual unload of package - done
  * check for color key in OTA ;) done :(
  * options-enviroment variables crash    -> TDefaultEnvironmentDialog  GExperts????    done:)
  * tidegradeint buttons , not paint correctly  done:)
  * border of panel in options window is not painted corectly done
}

//options
{

  * Fix icons gray
  * hook main menu
  * Hook ide code editor
  * hook all ide windows

  * Looad feel select (standard, XP)
  * choose the colors automatic way
  * activate glass colorization vista and windows 7?

  flat (ctrl3d) global or by control ?

    background color for windows (tlistview and treeview)
    skin by contorls (by xml) ->>then use ClassName ;)
     * treeview
     * TListBox
     * TlistView
}


unit Main;

interface

uses
 ToolsAPI;

Const
  sLogoBitmap             = 'Logo';
  sLogoIcon16             = 'Logo16';
  sAboutBitnap            = 'About';
  sMenuItemCaption        = 'Delphi IDE Colorizer';
  sMenuItemName           = 'DelphiIDEClrItem';
  sActionItemIdeColorizer = 'DelphiIDEClrAction';

{$IFDEF DLLWIZARD}
function InitIDEColorizer(const BorlandIDEServices: IBorlandIDEServices; RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): Boolean; stdcall;
exports   InitIDEColorizer name WizardEntryPoint;
{$ELSE}
procedure Register;
{$ENDIF}


implementation

{$R DelphiIDEColorizer.res}
{$R Gutter.res}
{$R DICimages.res}

uses
 {$IF CompilerVersion >= 23}
 Vcl.Styles,
 Vcl.Themes,
 {$IFEND}
 Classes,
 ActnMan,
 ActnList,
 Controls,
 Windows,
 Graphics,
 UxTheme,
 Colorizer.Utils,
 ActnColorMaps,
 SysUtils,
 Forms,
 Dialogs,
 Menus,
 ComObj,
 ExtCtrls,
 uDelphiVersions,
 Colorizer.SettingsForm,
 Colorizer.Settings,
 Colorizer.OptionsDlg,
 ColorXPStyleActnCtrls,
 uMisc;


type
  TIDEWizard = class(TInterfacedObject, IOTAWizard, IOTANotifier)
  private
    FDICConfMenuItem: TMenuItem;
    FTimerRefresher: TTimer;
    procedure AddMenuItems;
    procedure RemoveMenuItems;
    procedure InitColorizer;
    procedure FinalizeColorizer;
    procedure OnRefreher(Sender : TObject);
    procedure DICConfClick(Sender: TObject);
    {$IFDEF USE_DUMP_TIMER}
    procedure OnDumper(Sender : TObject);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    function GetIDString: string;
    procedure Execute;
    function GetName: string;
    function GetState: TWizardState;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
  end;
const
  InvalidIndex = -1;

var
  SplashBmp      : Graphics.TBitmap;
  AboutBmp       : Graphics.TBitmap;
  FPlugInInfo    : Integer = InvalidIndex;
{$IFDEF DLLWIZARD}
  IDEWizard      : TIDEWizard;
var
  FWizardIndex: Integer = InvalidIndex;

procedure FinalizeIDEColorizer;
var
  WizardServices: IOTAWizardServices;
begin
  if FWizardIndex <> InvalidIndex then
  begin
    Assert(Assigned(BorlandIDEServices));
    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));
    WizardServices.RemoveWizard(FWizardIndex);
    FWizardIndex := InvalidIndex;
  end;
end;

function InitIDEColorizer(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;
var
  WizardServices: IOTAWizardServices;
begin
  Result := BorlandIDEServices <> nil;
  if Result then
  begin
    Assert(ToolsAPI.BorlandIDEServices = BorlandIDEServices);
    Terminate := FinalizeIDEColorizer;
    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));
    IDEWizard := TIDEWizard.Create;
    FWizardIndex := WizardServices.AddWizard(IDEWizard as IOTAWizard);
    Result := (FWizardIndex >= 0);
  end;
end;

{$ELSE}
procedure Register;
begin
   RegisterPackageWizard(TIDEWizard.Create as IOTAWizard);
end;
{$ENDIF}

function QuerySvcs(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
begin
  Result := (Instance <> nil) and Supports(Instance, Intf, Inst);
end;

procedure RegisterPlugIn;
const
  SColorizerPluginCaption    ='Delphi IDE Colorizer';
  SColorizerPluginDescription=
  'Delphi IDE Colorizer'+sLineBreak+
  ''+sLineBreak+
  'Version %s'+sLineBreak+
  'Copyright: 2011-2014 Rodrigo Ruz V.'+sLineBreak+
  'All rights reserved.'+sLineBreak+
  ''+sLineBreak+
  'This is a freeware, you can use it freely without any fee.'+sLineBreak+
  ''+sLineBreak+
  'http://theroadtodelphi.wordpress.com/'+sLineBreak;
var
  LAboutBoxServices: IOTAAboutBoxServices;
begin
  SplashBmp:=Graphics.TBitmap.Create;
  SplashBmp.Handle := LoadBitmap(hInstance, sLogoBitmap);

  AboutBmp:=Graphics.TBitmap.Create;
  AboutBmp.Handle := LoadBitmap(hInstance, sAboutBitnap);

  if Assigned(SplashScreenServices) then
    SplashScreenServices.AddPluginBitmap(SColorizerPluginCaption, SplashBmp.Handle);

  if QuerySvcs(BorlandIDEServices, IOTAAboutBoxServices, LAboutBoxServices) then
   FPlugInInfo:=LAboutBoxServices.AddPluginInfo(SColorizerPluginCaption, Format(SColorizerPluginDescription, [uMisc.GetFileVersion(GetModuleLocation)]), AboutBmp.Handle, False, 'Freeware');
end;

procedure UnRegisterPlugIn;
var
  LAboutBoxServices : IOTAAboutBoxServices;
begin
  if QuerySvcs(BorlandIDEServices, IOTAAboutBoxServices, LAboutBoxServices) and (FPlugInInfo<>InvalidIndex) then
     LAboutBoxServices.RemovePluginInfo(FPlugInInfo);

  FPlugInInfo:=InvalidIndex;
end;

procedure TIDEWizard.InitColorizer;
var
  LServices : INTAServices;
{$IF CompilerVersion >= 23}
  found : Boolean;
  s : string;
{$IFEND}
begin
  try
    if BorlandIDEServices <> nil then
    begin
        LServices := (BorlandIDEServices as INTAServices);
        if LServices <> nil then
        begin
          RegisterColorizerAddinOptions;
          TColorizerLocalSettings.ColorMap:=TColorXPColorMap.Create(nil);
          LoadSettings(TColorizerLocalSettings.ColorMap, TColorizerLocalSettings.ActionBarStyle, TColorizerLocalSettings.Settings);
          {$IF CompilerVersion >= 23}
          if (TColorizerLocalSettings.Settings.UseVCLStyles) and (TColorizerLocalSettings.Settings.VCLStyleName<>'') then
          begin
            RegisterVClStylesFiles();
            found:=false;
            for s in TStyleManager.StyleNames do
             if not SameText(s, 'Windows') and SameText(s, TColorizerLocalSettings.Settings.VCLStyleName) then
             begin
               found:=True;
               break;
             end;

            if found then
            begin
              TStyleManager.SetStyle(TColorizerLocalSettings.Settings.VCLStyleName);
              GenerateColorMap(TColorizerLocalSettings.ColorMap,TStyleManager.ActiveStyle);
            end
            else
              MessageDlg(Format('The VCL Style %s was not found',[TColorizerLocalSettings.Settings.VCLStyleName]), mtInformation, [mbOK], 0);
          end;
          {$IFEND}
          RefreshIDETheme();
        end;
    end;
  except
    on E: exception do
    begin
      ShowMessage(Format('%s : Error on InitColorizer %s %s Trace %s', [sMenuItemCaption, E.message, sLineBreak, E.StackTrace]));
    end;
  end;
end;

procedure TIDEWizard.FinalizeColorizer;
begin
  FreeAndNil(TColorizerLocalSettings.ColorMap);
  UnRegisterColorizerAddinOptions
end;

{ TIDEWizard }
constructor TIDEWizard.Create;
begin
  inherited;
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook<>0;
  {$WARN SYMBOL_PLATFORM ON}
  //AColorMap:=nil;
  TColorizerLocalSettings.Settings:=TSettings.Create;
  //ColorizerForm := nil;
  RegisterPlugIn;
  AddMenuItems;
  InitColorizer();

  FTimerRefresher:=TTimer.Create(nil);
  FTimerRefresher.OnTimer :=OnRefreher;
  FTimerRefresher.Interval:=1500;
  FTimerRefresher.Enabled:=True;
end;

procedure TIDEWizard.AddMenuItems;
var
  Index: Integer;
  IDEMenuItem, ToolsMenuItem: TMenuItem;
  NTAServices: INTAServices;
  LIcon : TIcon;
begin
  inherited;

   if BorlandIDEServices <> nil then
   begin
     NTAServices := (BorlandIDEServices as INTAServices);

      IDEMenuItem := NTAServices.MainMenu.Items;
      if not Assigned(IDEMenuItem) then
        raise Exception.Create('Was not possible found IDE Menu Item');

      ToolsMenuItem := nil;
      for Index := 0 to IDEMenuItem.Count - 1 do
        if CompareText(IDEMenuItem.Items[Index].Name, 'ToolsMenu') = 0 then
          ToolsMenuItem := IDEMenuItem.Items[Index];
      if not Assigned(ToolsMenuItem) then
        raise Exception.Create('Was not possible found IDE Tools Menu Item');

      FDICConfMenuItem := TMenuItem.Create(nil);
      FDICConfMenuItem.Name := sMenuItemName;
      FDICConfMenuItem.Caption := sMenuItemCaption;
      FDICConfMenuItem.OnClick := DICConfClick;

      LIcon := TIcon.Create;
      try
       LIcon.Handle := LoadIcon(hInstance, sLogoIcon16);
        FDICConfMenuItem.ImageIndex := NTAServices.ImageList.AddIcon(LIcon);
      finally
        LIcon.Free;
      end;

      ToolsMenuItem.Insert(ToolsMenuItem.Count, FDICConfMenuItem);
   end;
end;

procedure TIDEWizard.DICConfClick(Sender: TObject);
var
  ColorizerForm : TFormIDEColorizerSettings;
begin
  try
    ColorizerForm := TFormIDEColorizerSettings.Create(nil);
    ColorizerForm.Name := 'DelphiIDEColorizer_SettingsForm';
    ColorizerForm.LabelSetting.Caption:='Delphi IDE Colorizer for '+TColorizerLocalSettings.IDEData.Name;
    ColorizerForm.Init;
    ColorizerForm.PanelMain.BorderWidth:=5;
    ColorizerForm.ShowModal();
  except
    on E: exception do
    begin
      ShowMessage(Format('%s : Error on dialog display %s', [sMenuItemCaption, E.message]));
    end;
  end;
end;


procedure TIDEWizard.AfterSave;
begin
end;

procedure TIDEWizard.BeforeSave;
begin
end;


destructor TIDEWizard.Destroy;
begin
  UnRegisterPlugIn;
  RemoveMenuItems;
  FreeAndNil(SplashBmp);
  FreeAndNil(AboutBmp);
  FinalizeColorizer();
  FTimerRefresher.Enabled:=False;
  FTimerRefresher.Free;
  inherited;
end;

procedure TIDEWizard.Destroyed;
begin
end;

procedure TIDEWizard.Execute;
begin
end;


function TIDEWizard.GetIDString: string;
begin
  Result := 'Delphi.IDEColorizer';
end;

function TIDEWizard.GetName: string;
begin
  Result := 'Delphi IDE Colorizer';
end;

function TIDEWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TIDEWizard.Modified;
begin
end;

procedure TIDEWizard.OnRefreher(Sender: TObject);
begin
 if Assigned(TColorizerLocalSettings.ColorMap) and Assigned(TColorizerLocalSettings.Settings) and TColorizerLocalSettings.Settings.Enabled then
 begin
  RefreshIDETheme();
  FTimerRefresher.Enabled:=False;
 end;
end;



procedure TIDEWizard.RemoveMenuItems;
begin
  FreeAndNil(FDICConfMenuItem);
end;


//function GetActiveFormEditor: IOTAFormEditor;
//var
//  Module: IOTAModule;
//  Editor: IOTAEditor;
//  i: Integer;
//begin
//  Result := nil;
//  Module := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
//  if Module<>nil then
//  begin
//    for i := 0 to Module.GetModuleFileCount - 1 do
//    begin
//      Editor := Module.GetModuleFileEditor(i);
//      if Supports(Editor, IOTAFormEditor, Result) then
//        Break;
//    end;
//  end;
//end;

end.


