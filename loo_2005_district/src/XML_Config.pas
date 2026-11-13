
{**********************************************************}
{                                                          }
{                     XML Data Binding                     }
{                                                          }
{         Generated on: 15.10.2005 12:10:02                }
{       Generated from: D:\ÀŒŒ 2005 –‡ÈÓÌ\src\config.xml   }
{   Settings stored in: D:\ÀŒŒ 2005 –‡ÈÓÌ\src\config.xdb   }
{                                                          }
{**********************************************************}

unit XML_Config;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLConfigType = interface;
  IXMLTaskType = interface;

{ IXMLConfigType }

  IXMLConfigType = interface(IXMLNodeCollection)
    ['{238EE1C1-B0B8-4650-AFAB-F9C909E25BBA}']
    { Property Accessors }
    function Get_Task(Index: Integer): IXMLTaskType;
    { Methods & Properties }
    function Add: IXMLTaskType;
    function Insert(const Index: Integer): IXMLTaskType;
    property Task[Index: Integer]: IXMLTaskType read Get_Task; default;
  end;

{ IXMLTaskType }

  IXMLTaskType = interface(IXMLNode)
    ['{A1917F94-0C37-4C1C-B732-6AAA7F5EE594}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Task_id: WideString;
    function Get_Filename: WideString;
    function Get_BallsFactor: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Task_id(Value: WideString);
    procedure Set_Filename(Value: WideString);
    procedure Set_BallsFactor(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Task_id: WideString read Get_Task_id write Set_Task_id;
    property Filename: WideString read Get_Filename write Set_Filename;
    property BallsFactor: Integer read Get_BallsFactor write Set_BallsFactor;
  end;

{ Forward Decls }

  TXMLConfigType = class;
  TXMLTaskType = class;

{ TXMLConfigType }

  TXMLConfigType = class(TXMLNodeCollection, IXMLConfigType)
  protected
    { IXMLConfigType }
    function Get_Task(Index: Integer): IXMLTaskType;
    function Add: IXMLTaskType;
    function Insert(const Index: Integer): IXMLTaskType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTaskType }

  TXMLTaskType = class(TXMLNode, IXMLTaskType)
  protected
    { IXMLTaskType }
    function Get_Name: WideString;
    function Get_Task_id: WideString;
    function Get_Filename: WideString;
    function Get_BallsFactor: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Task_id(Value: WideString);
    procedure Set_Filename(Value: WideString);
    procedure Set_BallsFactor(Value: Integer);
  end;

{ Global Functions }

function Getconfig(Doc: IXMLDocument): IXMLConfigType;
function Loadconfig(const FileName: WideString): IXMLConfigType;
function Newconfig: IXMLConfigType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getconfig(Doc: IXMLDocument): IXMLConfigType;
begin
  Result := Doc.GetDocBinding('config', TXMLConfigType, TargetNamespace) as IXMLConfigType;
end;

function Loadconfig(const FileName: WideString): IXMLConfigType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('config', TXMLConfigType, TargetNamespace) as IXMLConfigType;
end;

function Newconfig: IXMLConfigType;
begin
  Result := NewXMLDocument.GetDocBinding('config', TXMLConfigType, TargetNamespace) as IXMLConfigType;
end;

{ TXMLConfigType }

procedure TXMLConfigType.AfterConstruction;
begin
  RegisterChildNode('task', TXMLTaskType);
  ItemTag := 'task';
  ItemInterface := IXMLTaskType;
  inherited;
end;

function TXMLConfigType.Get_Task(Index: Integer): IXMLTaskType;
begin
  Result := List[Index] as IXMLTaskType;
end;

function TXMLConfigType.Add: IXMLTaskType;
begin
  Result := AddItem(-1) as IXMLTaskType;
end;

function TXMLConfigType.Insert(const Index: Integer): IXMLTaskType;
begin
  Result := AddItem(Index) as IXMLTaskType;
end;

{ TXMLTaskType }

function TXMLTaskType.Get_Name: WideString;
begin
  Result := ChildNodes['name'].Text;
end;

procedure TXMLTaskType.Set_Name(Value: WideString);
begin
  ChildNodes['name'].NodeValue := Value;
end;

function TXMLTaskType.Get_Task_id: WideString;
begin
  Result := ChildNodes['task_id'].Text;
end;

procedure TXMLTaskType.Set_Task_id(Value: WideString);
begin
  ChildNodes['task_id'].NodeValue := Value;
end;

function TXMLTaskType.Get_Filename: WideString;
begin
  Result := ChildNodes['filename'].Text;
end;

procedure TXMLTaskType.Set_Filename(Value: WideString);
begin
  ChildNodes['filename'].NodeValue := Value;
end;

function TXMLTaskType.Get_BallsFactor: Integer;
begin
  Result := ChildNodes['BallsFactor'].NodeValue;
end;

procedure TXMLTaskType.Set_BallsFactor(Value: Integer);
begin
  ChildNodes['BallsFactor'].NodeValue := Value;
end;

end.