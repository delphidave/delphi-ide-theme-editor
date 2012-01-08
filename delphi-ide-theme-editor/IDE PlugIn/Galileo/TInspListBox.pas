type
  TInspListBox=class(TCustomPropListBox)
  private
   FSelection          :TPropSelection;
   FEdit               :TPropInspEdit;
   FListButton         :TListButton;
   FListGlyph          :TBitmap;
   FDialogGlyph        :TBitmap;
   FButtonVisible      :Boolean;
   FInPropAccess       :Integer;
   FTrackMode          :TTrackMode;
   FModalReturn        :IActivatable;
   FMousePos           :Integer;
   FDragPos            :Integer;
   FDragDelta          :Integer;
   FSelectString       :string;
   FCancelValue        :WideString;
   FReadOnlyMsg        :string;
   FProcessChange      :Boolean;
   FStillProcessingChange:Boolean;
   FNamesSelected      :Boolean;
   FQueryButtonVisible :Boolean;
   FReadOnly           :Boolean;
   FQueryGlyph         :TBitmap;
   FQueryButton        :TSpeedButton;
   FStart              :Integer;
   FInitialized        :Boolean;
   FDirty              :Boolean;
   FInAutoUpdate       :Boolean;
   FInEditFocus        :Boolean;
   FItemsReset         :Boolean;
   FHighlightOnSelect  :Boolean;
   FPendingFormDestroyWnd:Boolean;
   FOnSelectItem       :TNotifyEvent;
   FOnEditDblClick     :TEditDblClickEvent;
   FOnHelp             :TNotifyEvent;
   FOnNCHitTest        :TMouseMoveEvent;
   FOnListButtonClick  :TNotifyEvent;
   FOnQueryButtonClick :TNotifyEvent;
   FControlsHidden     :Boolean;
   FSaveTopIndex       :Integer;
   FHintFontStyle      :TFontStyles;
   FWasFocused         :Boolean;
   FSaveSelStart       :Integer;
   FSaveSelLength      :Integer;
   FOnSelectionKeyDown :TKeyEvent;
   FOnSelectionKeyPress:TKeyPressEvent;
   FOnEditKeyPress     :TKeyPressEvent;
   FGetHintStrEvent    :TGetHintStrEvent;
   FItems              :TStrings;
   FDividerLine        :TBitmap;
   FMiddle             :Integer;
   FAddIndex           :Integer;
   FAddLevel           :Integer;
   FParentItem         :TPropItem;
   FRefSubProps        :Boolean;
   FSelection          :IPropListBoxSelection;
   FMouseTrackItem     :Integer;
   FCaptured           :Boolean;
   FHighlightColor     :TColor;
   FHighlightFontColor :TColor;
   FGutterColor        :TColor;
   FGutterEdgeColor    :TColor;
   FBackgroundColor    :TColor;
   FPropValueColor     :TColor;
   FPropNameColor      :TColor;
   FEditBackgroundColor:TColor;
   FEditValueColor     :TColor;
   FCategoryColor      :TColor;
   FReferenceColor     :TColor;
   FSubPropColor       :TColor;
   FReadOnlyColor      :TColor;
   FNonDefaultColor    :TColor;
   FNonDefaultFontStyle:TFontStyles;
   FShowGutter         :Boolean;
   FShowGridLines      :Boolean;
   FIndentSecondLevel  :Boolean;
   FOldWidth           :Integer;
   FOldMiddle          :Integer;
   FUseVirtualList     :Boolean;
   FOnAllowExpansion   :TAllowExpansionEvent;
   FOnGetProperties    :TGetPropertiesEvent;
   FOnGetSubProperties :TGetSubPropertiesEvent;
   FOnUpdateDirtyData  :TNotifyEvent;
   FOnAfterReset       :TNotifyEvent;
   FOnBeforeReset      :TNotifyEvent;
   FAutoComplete       :Boolean;
   FCount              :Integer;
   FItems              :TStrings;
   FFilter             :string;
   FLastTime           :Cardinal;
   FBorderStyle        :TBorderStyle;
   FCanvas             :TCanvas;
   FColumns            :Integer;
   FItemHeight         :Integer;
   FOldCount           :Integer;
   FStyle              :TListBoxStyle;
   FIntegralHeight     :Boolean;
   FSorted             :Boolean;
   FExtendedSelect     :Boolean;
   FTabWidth           :Integer;
   FSaveItems          :TStringList;
   FSaveTopIndex       :Integer;
   FSaveItemIndex      :Integer;
   FSaveScrollWidth    :Integer;
   FSaveSelection      ::TCustomListBox.:1;
   FOnDrawItem         :TDrawItemEvent;
   FOnMeasureItem      :TMeasureItemEvent;
   FOnData             :TLBGetDataEvent;
   FOnDataFind         :TLBFindDataEvent;
   FOnDataObject       :TLBGetDataObjectEvent;
   FAutoCompleteDelay  :Cardinal;
   FInBufferedPrintClient:Boolean;
   FAlignControlList   :TList;
   FAlignLevel         :Word;
   FBevelEdges         :TBevelEdges;
   FBevelInner         :TBevelCut;
   FBevelOuter         :TBevelCut;
   FBevelKind          :TBevelKind;
   FBevelWidth         :TBevelWidth;
   FBorderWidth        :TBorderWidth;
   FPadding            :TPadding;
   FBrush              :TBrush;
   FDockClients        :TList;
   FDockManager        :IDockManager;
   FImeMode            :TImeMode;
   FImeName            :TImeName;
   FParentWindow       :HWND;
   FTabList            :TList;
   FControls           :TList;
   FWinControls        :TList;
   FTabOrder           :Integer;
   FTabStop            :Boolean;
   FCtl3D              :Boolean;
   FShowing            :Boolean;
   FUseDockManager     :Boolean;
   FDockSite           :Boolean;
   FParentCtl3D        :Boolean;
   FParentDoubleBuffered:Boolean;
   FPerformingShowingChanged:Boolean;
   FOnDockDrop         :TDockDropEvent;
   FOnDockOver         :TDockOverEvent;
   FOnEnter            :TNotifyEvent;
   FOnExit             :TNotifyEvent;
   FOnGetSiteInfo      :TGetSiteInfoEvent;
   FOnKeyDown          :TKeyEvent;
   FOnKeyPress         :TKeyPressEvent;
   FOnKeyUp            :TKeyEvent;
   FOnUnDock           :TUnDockEvent;
   FOnAlignInsertBefore:TAlignInsertBeforeEvent;
   FOnAlignPosition    :TAlignPositionEvent;
   FMouseInClient      :Boolean;
   FMouseControl       :TControl;
   FTouchControl       :TControl;
   FDefWndProc         :Pointer;
   FHandle             :HWND;
   FObjectInstance     :Pointer;
   FParent             :TWinControl;
   FWindowProc         :TWndMethod;
   FLeft               :Integer;
   FTop                :Integer;
   FWidth              :Integer;
   FHeight             :Integer;
   FControlStyle       :TControlStyle;
   FControlState       :TControlState;
   FDesktopFont        :Boolean;
   FVisible            :Boolean;
   FEnabled            :Boolean;
   FParentFont         :Boolean;
   FParentColor        :Boolean;
   FAlign              :TAlign;
   FAutoSize           :Boolean;
   FDragMode           :TDragMode;
   FIsControl          :Boolean;
   FBiDiMode           :TBiDiMode;
   FParentBiDiMode     :Boolean;
   FAnchors            :TAnchors;
   FFont               :TFont;
   FActionLink         :TControlActionLink;
   FColor              :TColor;
   FConstraints        :TSizeConstraints;
   FMargins            :TMargins;
   FCursor             :TCursor;
   FDragCursor         :TCursor;
   FPopupMenu          :TPopupMenu;
   FHint               :string;
   FFontHeight         :Integer;
   FScalingFlags       :TScalingFlags;
   FShowHint           :Boolean;
   FParentShowHint     :Boolean;
   FDragKind           :TDragKind;
   FDockOrientation    :TDockOrientation;
   FHostDockSite       :TWinControl;
   FWheelAccumulator   :Integer;
   FUndockWidth        :Integer;
   FUndockHeight       :Integer;
   FLRDockWidth        :Integer;
   FTBDockHeight       :Integer;
   FFloatingDockSiteClass:TWinControlClass;
   FTouchManager       :TTouchManager;
   FOnCanResize        :TCanResizeEvent;
   FOnConstrainedResize:TConstrainedResizeEvent;
   FOnMouseDown        :TMouseEvent;
   FOnMouseMove        :TMouseMoveEvent;
   FOnMouseUp          :TMouseEvent;
   FOnDragDrop         :TDragDropEvent;
   FOnDragOver         :TDragOverEvent;
   FOnResize           :TNotifyEvent;
   FOnStartDock        :TStartDockEvent;
   FOnEndDock          :TEndDragEvent;
   FOnStartDrag        :TStartDragEvent;
   FOnEndDrag          :TEndDragEvent;
   FOnClick            :TNotifyEvent;
   FOnDblClick         :TNotifyEvent;
   FOnContextPopup     :TContextPopupEvent;
   FOnMouseActivate    :TMouseActivateEvent;
   FOnMouseLeave       :TNotifyEvent;
   FOnMouseEnter       :TNotifyEvent;
   FOnMouseWheel       :TMouseWheelEvent;
   FOnMouseWheelDown   :TMouseWheelUpDownEvent;
   FOnMouseWheelUp     :TMouseWheelUpDownEvent;
   FOnGesture          :TGestureEvent;
   FHelpType           :THelpType;
   FHelpKeyword        :string;
   FHelpContext        :THelpContext;
   FCustomHint         :TCustomHint;
   FParentCustomHint   :Boolean;
   FText               :PWideChar;
   FOwner              :TComponent;
   FName               :TComponentName;
   FTag                :NativeInt;
   FComponents         :TList;
   FFreeNotifies       :TList;
   FDesignInfo         :Integer;
   FComponentState     :TComponentState;
   FVCLComObject       :Pointer;
   FObservers          :TObservers;
   FSortedComponents   :TList;
   function GetListItem(Index: Integer): Variant;
   procedure SetSelected(Index: Integer; Value: Boolean);
   function GetDockClients(Index: Integer): TControl;
   function GetControl(Index: Integer): TControl;
   function GetComponent(AIndex: Integer): TComponent;
  protected
   FMoving             :Boolean;
   FMultiSelect        :Boolean;
   FDoubleBuffered     :Boolean;
   FInImeComposition   :Boolean;
   FDesignSize         :TPoint;
   FAnchorMove         :Boolean;
   FAnchorRules        :TPoint;
   FAnchorOrigin       :TPoint;
   FOriginalParentSize :TPoint;
   FExplicitLeft       :Integer;
   FExplicitTop        :Integer;
   FExplicitWidth      :Integer;
   FExplicitHeight     :Integer;
   FReserved           :Pointer;
   FComponentStyle     :TComponentStyle;
   function GetPropItem(Index: Integer): TPropItem;
   function GetSelected(Index: Integer): Boolean;
  public
   constructor Create(AOwner: TComponent);
   class destructor Destroy;
   procedure Reset;
   procedure DoExit;
   procedure GetPropValue;
   function SetPropValue(CheckModified: Boolean; HandleException: Boolean): Boolean;
   procedure ShowControls;
   procedure SelectItem(Index: Integer);
   procedure BlankItems;
   function ItemIsVisible(I: Integer): Boolean;
   function ItemVisibleCount: Integer;
   procedure InvalidateItem(Index: Integer);
   procedure InvalidateSelection;
   function IsQueryButtonDown: Boolean;
   procedure ListButtonCloseUp(Accept: Boolean);
   procedure ValidateExpandedItemPaths(AStrings: TStrings);
   procedure ReexpandItemPaths(AStrings: TStrings; ExpandNewRootLevels: Boolean);
   function GetItemPath(Index: Integer): string;
   function GetCurItemPath: string;
   procedure EditFocus;
   function IsListButtonDropped: Boolean;
   procedure AfterReexpandItem(Index: Integer);
   constructor Create(AOwner: TComponent);
   class destructor Destroy;
   procedure AdjustItem(Index: Integer);
   function CurItem: TPropItem;
   function FindItem(const Name: string): Integer;
   function Populated: Boolean;
   procedure PostUpdateMsg;
   procedure Reset;
   function SetSelectedPropertyPath(const PropPath: string): Integer;
   (basic) procedure SetSelectedProperty;
   constructor Create(AOwner: TComponent);
   class destructor Destroy;
   procedure AddItem(Item: string; AObject: TObject);
   procedure Clear;
   procedure ClearSelection;
   procedure CopySelection(Destination: TCustomListControl);
   procedure DeleteSelected;
   function GetCount: Integer;
   function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
   function ItemRect(Index: Integer): TRect;
   procedure SelectAll;
   constructor Create(AOwner: TComponent);
   procedure AddItem(Item: string; AObject: TObject);
   procedure Clear;
   procedure ClearSelection;
   procedure CopySelection(Destination: TCustomListControl);
   procedure DeleteSelected;
   function GetCount: Integer;
   procedure MoveSelection(Destination: TCustomListControl);
   procedure SelectAll;
   constructor Create(AOwner: TComponent);
   constructor CreateParented(ParentWindow: HWND);
   class function CreateParentedControl(ParentWindow: HWND): TWinControl;
   class destructor Destroy;
   procedure Broadcast(var Message);
   function CanFocus: Boolean;
   function ContainsControl(Control: TControl): Boolean;
   function ControlAtPos(const Pos: TPoint; AllowDisabled: Boolean; AllowWinControls: Boolean; AllLevels: Boolean): TControl;
   procedure DefaultHandler(var Message);
   procedure DisableAlign;
   procedure DockDrop(Source: TDragDockObject; X: Integer; Y: Integer);
   procedure EnableAlign;
   function FindChildControl(const ControlName: string): TControl;
   procedure FlipChildren(AllLevels: Boolean);
   function Focused: Boolean;
   procedure GetChildren(Proc: TGetChildProc = procedure(Child: TComponent) of object; Root: TComponent);
   procedure GetTabControlList(List: TList);
   procedure GetTabOrderList(List: TList);
   function HandleAllocated: Boolean;
   procedure HandleNeeded;
   procedure InsertControl(AControl: TControl);
   procedure Invalidate;
   procedure PaintTo(DC: HDC; X: Integer; Y: Integer);
   procedure PaintTo(Canvas: TCanvas; X: Integer; Y: Integer);
   function PreProcessMessage(var Msg: tagMSG): Boolean;
   procedure RemoveControl(AControl: TControl);
   procedure Realign;
   procedure Repaint;
   procedure ScaleBy(M: Integer; D: Integer);
   procedure ScrollBy(DeltaX: Integer; DeltaY: Integer);
   procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer);
   procedure SetDesignVisible(Value: Boolean);
   procedure SetFocus;
   procedure Update;
   procedure UpdateControlState;
   constructor Create(AOwner: TComponent);
   class destructor Destroy;
   procedure BeginDrag(Immediate: Boolean; Threshold: Integer);
   procedure BringToFront;
   function ClientToScreen(const Point: TPoint): TPoint;
   function ClientToParent(const Point: TPoint; AParent: TWinControl): TPoint;
   procedure Dock(NewDockSite: TWinControl; ARect: TRect);
   function Dragging: Boolean;
   procedure DragDrop(Source: TObject; X: Integer; Y: Integer);
   function DrawTextBiDiModeFlags(Flags: Integer): Integer;
   function DrawTextBiDiModeFlagsReadingOnly: Integer;
   procedure EndDrag(Drop: Boolean);
   function GetControlsAlignment: TAlignment;
   function GetParentComponent: TComponent;
   function HasParent: Boolean;
   procedure Hide;
   procedure InitiateAction;
   procedure Invalidate;
   procedure MouseWheelHandler(var Message: TMessage);
   function IsRightToLeft: Boolean;
   function ManualDock(NewDockSite: TWinControl; DropControl: TControl; ControlSide: TAlign): Boolean;
   function ManualFloat(ScreenPos: TRect): Boolean;
   function Perform(Msg: Cardinal; WParam: NativeUInt; LParam: NativeInt): NativeInt;
   procedure Refresh;
   procedure Repaint;
   function ReplaceDockedControl(Control: TControl; NewDockSite: TWinControl; DropControl: TControl; ControlSide: TAlign): Boolean;
   function ScreenToClient(const Point: TPoint): TPoint;
   function ParentToClient(const Point: TPoint; AParent: TWinControl): TPoint;
   procedure SendToBack;
   procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer);
   procedure SetDesignVisible(Value: Boolean);
   procedure SetParentComponent(Value: TComponent);
   procedure Show;
   procedure Update;
   function UseRightToLeftAlignment: Boolean;
   function UseRightToLeftReading: Boolean;
   function UseRightToLeftScrollBar: Boolean;
   procedure DefaultHandler(var Message);
   function GetTextBuf(Buffer: PWideChar; BufSize: Integer): Integer;
   function GetTextLen: Integer;
   function Perform(Msg: Cardinal; WParam: NativeUInt; LParam: PWideChar): NativeInt;
   function Perform(Msg: Cardinal; WParam: NativeUInt; var LParam: TRect): NativeInt;
   procedure SetTextBuf(Buffer: PWideChar);
   constructor Create(AOwner: TComponent);
   class destructor Destroy;
   procedure BeforeDestruction;
   procedure DestroyComponents;
   procedure Destroying;
   function ExecuteAction(Action: TBasicAction): Boolean;
   function FindComponent(const AName: string): TComponent;
   procedure FreeNotification(AComponent: TComponent);
   procedure RemoveFreeNotification(AComponent: TComponent);
   procedure FreeOnRelease;
   function GetEnumerator: TComponentEnumerator;
   function GetParentComponent: TComponent;
   function GetNamePath: string;
   function HasParent: Boolean;
   procedure InsertComponent(AComponent: TComponent);
   procedure RemoveComponent(AComponent: TComponent);
   procedure SetSubComponent(IsSubComponent: Boolean);
   function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HRESULT;
   function UpdateAction(Action: TBasicAction): Boolean;
   function IsImplementorOf(const I: IInterface): Boolean;
   function ReferenceInterface(const I: IInterface; Operation: TOperation): Boolean;
   class destructor Destroy;
   procedure Assign(Source: TPersistent);
   function GetNamePath: string;
   constructor Create;
   procedure Free;
   class function InitInstance(Instance: Pointer): TObject;
   procedure CleanupInstance;
   function ClassType: TClass;
   class function ClassName: string;
   class function ClassNameIs(const Name: string): Boolean;
   class function ClassParent: TClass;
   class function ClassInfo: Pointer;
   class function InstanceSize: Integer;
   class function InheritsFrom(AClass: TClass): Boolean;
   class function MethodAddress(const Name: ShortString): Pointer;
   class function MethodAddress(const Name: string): Pointer;
   class function MethodName(Address: Pointer): string;
   class function QualifiedClassName: string;
   function FieldAddress(const Name: ShortString): Pointer;
   function FieldAddress(const Name: string): Pointer;
   function GetInterface(const IID: TGUID; out Obj): Boolean;
   class function GetInterfaceEntry(const IID: TGUID): PInterfaceEntry;
   class function GetInterfaceTable: PInterfaceTable;
   class function UnitName: string;
   class function UnitScope: string;
   function Equals(Obj: TObject): Boolean;
   function GetHashCode: Integer;
   function ToString: string;
   function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HRESULT;
   procedure AfterConstruction;
   procedure BeforeDestruction;
   procedure Dispatch(var Message);
   procedure DefaultHandler(var Message);
   class function NewInstance: TObject;
   procedure FreeInstance;
   class destructor Destroy;
   property Start: Integer;
   property Initialized: Boolean;
   property Dirty: Boolean;
   property Edit: TPropInspEdit;
   property InPropAccess: Boolean;
   property ModalReturn: IActivatable;
   property HighlightOnSelect: Boolean;
   property PendingFormDestroyWnd: Boolean;
   property BackgroundColor: TColor;
   property PropNameColor: TColor;
   property PropValueColor: TColor;
   property EditBackgroundColor: TColor;
   property EditValueColor: TColor;
   property CategoryColor: TColor;
   property GutterColor: TColor;
   property IndentSecondLevel: Boolean;
   property GutterEdgeColor: TColor;
   property ReferenceColor: TColor;
   property SubPropColor: TColor;
   property ReadOnlyColor: TColor;
   property NonDefaultColor: TColor;
   property NonDefaultFontStyle: TFontStyles;
   property HighlightColor: TColor;
   property HighlightFontColor: TColor;
   property UseVirtualList: Boolean;
   property Items: TStrings;
   property ShowGutter: Boolean;
   property ShowGridLines: Boolean;
   property Middle: Integer;
   property Selection: IPropListBoxSelection;
   property OnAfterReset: TNotifyEvent;
   property OnAllowExpansion: TAllowExpansionEvent;
   property OnBeforeReset: TNotifyEvent;
   property OnGetProperties: TGetPropertiesEvent;
   property OnGetSubProperties: TGetSubPropertiesEvent;
   property OnUpdateDirtyData: TNotifyEvent;
   property AutoCompleteDelay: Cardinal;
   property AutoComplete: Boolean;
   property Canvas: TCanvas;
   property Count: Integer;
   property Items: TStrings;
   property ScrollWidth: Integer;
   property TopIndex: Integer;
   property MultiSelect: Boolean;
   property SelCount: Integer;
   property ItemIndex: Integer;
   property DockClientCount: Integer;
   property DockSite: Boolean;
   property DockManager: IDockManager;
   property DoubleBuffered: Boolean;
   property AlignDisabled: Boolean;
   property MouseInClient: Boolean;
   property VisibleDockClientCount: Integer;
   property Brush: TBrush;
   property ControlCount: Integer;
   property Handle: HWND;
   property Padding: TPadding;
   property ParentDoubleBuffered: Boolean;
   property ParentWindow: HWND;
   property Showing: Boolean;
   property TabOrder: TTabOrder;
   property TabStop: Boolean;
   property UseDockManager: Boolean;
   property Enabled: Boolean;
   property Action: TBasicAction;
   property Align: TAlign;
   property Anchors: TAnchors;
   property BiDiMode: TBiDiMode;
   property BoundsRect: TRect;
   property ClientHeight: Integer;
   property ClientOrigin: TPoint;
   property ClientRect: TRect;
   property ClientWidth: Integer;
   property Constraints: TSizeConstraints;
   property ControlState: TControlState;
   property ControlStyle: TControlStyle;
   property DockOrientation: TDockOrientation;
   property ExplicitLeft: Integer;
   property ExplicitTop: Integer;
   property ExplicitWidth: Integer;
   property ExplicitHeight: Integer;
   property Floating: Boolean;
   property FloatingDockSiteClass: TWinControlClass;
   property HostDockSite: TWinControl;
   property LRDockWidth: Integer;
   property ShowHint: Boolean;
   property TBDockHeight: Integer;
   property Touch: TTouchManager;
   property UndockHeight: Integer;
   property UndockWidth: Integer;
   property Visible: Boolean;
   property WindowProc: TWndMethod;
   property Parent: TWinControl;
   property OnGesture: TGestureEvent;
   property ComObject: IInterface;
   property ComponentCount: Integer;
   property ComponentIndex: Integer;
   property ComponentState: TComponentState;
   property ComponentStyle: TComponentStyle;
   property DesignInfo: Integer;
   property Owner: TComponent;
   property VCLComObject: Pointer;
   property Observers: TObservers;
  published
   property Align: TAlign;
   property Anchors: TAnchors;
   property Count: Integer;
   property Ctl3D: Boolean;
   property CurIndex: Integer;
   property Enabled: Boolean;
   property Font: TFont;
   property ItemHeight: Integer;
   property Middle: Integer;
   property ParentColor: Boolean;
   property ParentCtl3D: Boolean;
   property ParentFont: Boolean;
   property PopupMenu: TPopupMenu;
   property ShowGridLines: Boolean;
   property BackgroundColor: TColor;
   property PropNameColor: TColor;
   property PropValueColor: TColor;
   property EditBackgroundColor: TColor;
   property EditValueColor: TColor;
   property CategoryColor: TColor;
   property GutterColor: TColor;
   property GutterEdgeColor: TColor;
   property ReferenceColor: TColor;
   property SubPropColor: TColor;
   property ReadOnlyColor: TColor;
   property NonDefaultColor: TColor;
   property NonDefaultFontStyle: TFontStyles;
   property HighlightColor: TColor;
   property HighlightFontColor: TColor;
   property ShowGutter: Boolean;
   property ReadOnly: Boolean;
   property ReadOnlyMsg: string;
   property ShowHint: Boolean;
   property TabOrder: TTabOrder;
   property TabStop: Boolean;
   property Visible: Boolean;
   property OnAfterReset: TNotifyEvent;
   property OnAllowExpansion: TAllowExpansionEvent;
   property OnBeforeReset: TNotifyEvent;
   property OnClick: TNotifyEvent;
   property OnDblClick: TNotifyEvent;
   property OnDragOver: TDragOverEvent;
   property OnDragDrop: TDragDropEvent;
   property OnEditDblClick: TEditDblClickEvent;
   property OnEditKeyPress: TKeyPressEvent;
   property OnGetHintString: TGetHintStrEvent;
   property OnGetProperties: TGetPropertiesEvent;
   property OnGetSubProperties: TGetSubPropertiesEvent;
   property OnHelp: TNotifyEvent;
   property OnKeyDown: TKeyEvent;
   property OnKeyUp: TKeyEvent;
   property OnKeyPress: TKeyPressEvent;
   property OnListButtonClick: TNotifyEvent;
   property OnMouseDown: TMouseEvent;
   property OnMouseMove: TMouseMoveEvent;
   property OnMouseUp: TMouseEvent;
   property OnNCHitTest: TMouseMoveEvent;
   property OnQueryButtonClick: TNotifyEvent;
   property OnSelectionKeyDown: TKeyEvent;
   property OnSelectionKeyPress: TKeyPressEvent;
   property OnSelectItem: TNotifyEvent;
   property OnUpdateDirtyData: TNotifyEvent;
   property TabStop: Boolean;
   property AlignWithMargins: Boolean;
   property Left: Integer;
   property Top: Integer;
   property Width: Integer;
   property Height: Integer;
   property Cursor: TCursor;
   property Hint: string;
   property HelpType: THelpType;
   property HelpKeyword: string;
   property HelpContext: THelpContext;
   property Margins: TMargins;
   property CustomHint: TCustomHint;
   property ParentCustomHint: Boolean;
   property Name: TComponentName;
   property Tag: NativeInt;
  end;