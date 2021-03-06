type
  TWindowListCommands=class(TDataModule)
  private
   FMainWindowsMenu    :TMenuItem;
   FDesignSize         :TPoint;
   FDesignOffset       :TPoint;
   FOnCreate           :TNotifyEvent;
   FOnDestroy          :TNotifyEvent;
   FOldCreateOrder     :Boolean;
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
   function GetComponent(AIndex: Integer): TComponent;
  protected
   FComponentStyle     :TComponentStyle;
  public
   constructor Create(AOwner: TComponent);
   constructor CreateNew(AOwner: TComponent; Dummy: Integer);
   class destructor Destroy;
   procedure AfterConstruction;
   procedure BeforeDestruction;
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
   property DesignOffset: TPoint;
   property DesignSize: TPoint;
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
   PopupMenu1          :TPopupMenu;
   ActionList1         :TActionList;
   ImageList1          :TImageList;
   ViewWindowListCommand:TPopupAction;
   ViewWindowListItem  :TMenuItem;
   WindowListPopup     :TPopupMenu;
   ViewNextWindowCommand:TAction;
   emp1                :TMenuItem;
   WindowsMenu         :TMenuItem;
   emp2                :TMenuItem;
   procedure ViewNextWindowCommandUpdate(Sender: TObject);
   procedure DataModuleDestroy(Sender: TObject);
   procedure ViewWindowListCommandExecute(Sender: TObject);
   procedure WindowsMenuClick(Sender: TObject);
   procedure ViewNextWindowCommandExecute(Sender: TObject);
   procedure WindowListPopupPopup(Sender: TObject);
   property OldCreateOrder: Boolean;
   property OnCreate: TNotifyEvent;
   property OnDestroy: TNotifyEvent;
   property Name: TComponentName;
   property Tag: NativeInt;
  end;
