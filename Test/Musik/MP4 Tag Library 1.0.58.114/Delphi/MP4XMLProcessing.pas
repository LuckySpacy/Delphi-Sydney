unit MP4XMLProcessing;

interface

Uses
    SysUtils, StrUtils, XMLIntf, Xml.XMLDoc, msxmldom, ActiveX, Variants;

type
    TInvolvedPeople = record
        FunctionType: String;
        Name: String;
        adamId: String;
    end;

type
    TInvolvedPeoples = Array of TInvolvedPeople;

type
    TMP4XMLiTunMOVI = class
        LDocument: IXMLDocument;
        XMLHeader: String;
        Changed: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        procedure Load(XMLText: String);
        function GetXML: String;
        function Retrieve(var InvolvedPeoples: TInvolvedPeoples): Boolean;
        function AddPerson(InvolvedPeople: TInvolvedPeople): Boolean;
        function AddPersons(InvolvedPeoples: TInvolvedPeoples): Boolean;
        function PersonExists(InvolvedPeople: TInvolvedPeople): Boolean;
        function PersonFindByName(InvolvedPeople: TInvolvedPeople): Integer;
        function PersonChange(Index: Integer; InvolvedPeople: TInvolvedPeople): Boolean; overload;
        function PersonChange(PreviousName: String; InvolvedPeople: TInvolvedPeople): Boolean; overload;
        function PersonDelete(Index: Integer; FunctionType: String): Boolean; overload;
        function PersonIndexChange(Index: Integer; NewIndex: Integer; FunctionType: String): Boolean;
        function PersonDelete(InvolvedPeople: TInvolvedPeople): Boolean; overload;
        function DeleteEmptyNodes: Boolean; overload;
    end;

implementation

constructor TMP4XMLiTunMOVI.Create;
begin
    inherited;
    LDocument := TXMLDocument.Create(nil);
end;

function TMP4XMLiTunMOVI.DeleteEmptyNodes: Boolean;
const
    CAttrName = 'version';
var
    LNodeElement, LNode, LNode2: IXMLNode;
    //LAttrValue: string;
    i, k: Integer;
    //keyIndex: Integer;
    arrayIndex: Integer;
    arrayCount: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        { Traverse child nodes. }
        i := LNodeElement.ChildNodes.Count - 1;
        while i > - 1 do begin
            LNode := LNodeElement.ChildNodes.Get(i);
            if LNode.NodeName = 'dict' then begin
                //keyIndex := - 1;
                arrayIndex := - 1;
                arrayCount := - 1;
                k := LNode.ChildNodes.Count - 1;
                while k > - 1 do begin
                    LNode2 := LNode.ChildNodes.Get(k);
                    {
                    if LNode2.NodeName = 'key' then begin
                        keyIndex := k;
                    end;
                    }
                    if LNode2.NodeName = 'array' then begin
                        arrayIndex := k;
                        arrayCount := LNode2.ChildNodes.Count;
                    end;
                    if (arrayCount = 0)
                    AND (arrayIndex > - 1)
                    //AND (keyIndex > - 1)
                    then begin
                        LNode.ChildNodes.Delete(arrayIndex);
                        if SameText(LNode.ChildNodes[arrayIndex - 1].NodeName, 'key') then begin
                            LNode.ChildNodes.Delete(arrayIndex - 1);
                        end;
                        //keyIndex := - 1;
                        arrayIndex := - 1;
                        arrayCount := - 1;
                        Dec(k, 2);
                    end;
                    Dec(k);
                end;
            end;
            Dec(i);
        end;
    end;
end;

destructor TMP4XMLiTunMOVI.Destroy;
begin
    //FreeAndNil(LDocument);
    inherited;
end;

function TMP4XMLiTunMOVI.GetXML: String;
var
    LNodeElement: IXMLNode;
    MP4XMLiTunMOVISave: String;
begin
    Result := '';
    DeleteEmptyNodes;
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if LNodeElement.ChildNodes.Count > 0 then begin
        LDocument.SaveToXML(Result);
        Result := FormatXMLData(Result);
        MP4XMLiTunMOVISave := XMLHeader + Result;
        Result := MP4XMLiTunMOVISave;
    end;
end;

function TMP4XMLiTunMOVI.Retrieve(var InvolvedPeoples: TInvolvedPeoples): Boolean;
const
    CAttrName = 'version';
var
    LNodeElement, LNode, LNode2, LNode3, LNode4: IXMLNode;
    //LAttrValue: string;
    i, k, j, l: Integer;
    NodeCurrent: String;
    ActorName: String;
    ActoradamId: String;
begin
    Result := False;
    SetLength(InvolvedPeoples, 0);
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        { Get a specific attribute. }
        {
        if (LNodeElement.HasAttribute(CAttrName)) then begin
            LAttrValue := LNodeElement.Attributes[CAttrName];
            if LAttrValue <> '1.0' then begin
                Result := False;
                Exit;
            end else begin
                Result := True;
            end;
        end;
        }
        NodeCurrent := '';
        { Traverse child nodes. }
        for i := 0 to LNodeElement.ChildNodes.Count - 1 do begin
            LNode := LNodeElement.ChildNodes.Get(i);
            for k := 0 to LNode.ChildNodes.Count - 1 do begin
                LNode2 := LNode.ChildNodes.Get(k);
                if SameText(LNode2.NodeName, 'key') then begin
                    NodeCurrent := LNode2.Text;
                end;
                for j := 0 to LNode2.ChildNodes.Count - 1 do begin
                    LNode3 := LNode2.ChildNodes.Get(j);
                    //if LNode3.ChildNodes.Count > 0 then begin
                        SetLength(InvolvedPeoples, Length(InvolvedPeoples) + 1);
                    //end;
                    ActorName := '';
                    ActoradamId := '';
                    for l := 0 to LNode3.ChildNodes.Count - 1 do begin
                        LNode4 := LNode3.ChildNodes.Get(l);
                        //* ID
                        if SameText(LNode4.NodeName, 'integer') then begin
                            ActoradamId := LNode4.Text;
                        end;
                        //* Name
                        if SameText(LNode4.NodeName, 'string') then begin
                            ActorName := LNode4.Text;
                        end;
                    end;
                    //* Fill results
                    if ActorName = '' then begin
                        SetLength(InvolvedPeoples, Length(InvolvedPeoples) - 1);
                    end else begin
                        if ActoradamId = '' then begin
                            ActoradamId := '0';
                        end;
                        InvolvedPeoples[Length(InvolvedPeoples) - 1].FunctionType := NodeCurrent;
                        InvolvedPeoples[Length(InvolvedPeoples) - 1].Name := ActorName;
                        InvolvedPeoples[Length(InvolvedPeoples) - 1].adamId := ActoradamId;
                        Result := True;
                    end;
                end;
                if SameText(LNode2.NodeName, 'array') then begin
                    NodeCurrent := '';
                end;
            end;
        end;
    end;
end;

function XMLFindNodeKey(XMLNode: IXMLNode; NodeName: String): IXMLNode;
var
    LNode, LNode2: IXMLNode;
    i: Integer;
begin
    Result := nil;
    if (XMLNode <> nil) then begin
        for i := 0 to XMLNode.ChildNodes.Count - 1 do begin
            LNode := XMLNode.ChildNodes.Get(i);
            if SameText(LNode.NodeName, 'key') then begin
                if NOT VarIsNull(LNode.NodeValue) then begin
                    if SameText(LNode.NodeValue, NodeName) then begin
                        if XMLNode.ChildNodes.Count > i + 1 then begin
                            LNode2 := XMLNode.ChildNodes.Get(i + 1);
                            if SameText(LNode2.NodeName, 'array') then begin
                                Result := LNode2;
                                Exit;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function TMP4XMLiTunMOVI.AddPerson(InvolvedPeople: TInvolvedPeople): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2: IXMLNode;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if NOT Assigned(LNodeplistdict) then begin
            LNodeplistdict := LNodeElement.AddChild('dict');
        end;
        if InvolvedPeople.adamId = '' then begin
            InvolvedPeople.adamId := '0';
        end;
        LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
        if Assigned(LNode) then begin
            LNode2 := LNode.AddChild('dict');
            LNode2.AddChild('key').NodeValue := 'adamId';
            LNode2.AddChild('integer').NodeValue := InvolvedPeople.adamId;
            LNode2.AddChild('key').NodeValue := 'name';
            LNode2.AddChild('string').NodeValue := InvolvedPeople.Name;
        end else begin
            LNodeplistdict.AddChild('key').NodeValue := InvolvedPeople.FunctionType;
            LNode2 := LNodeplistdict.AddChild('array');
            LNode2 := LNode2.AddChild('dict');
            LNode2.AddChild('key').NodeValue := 'adamId';
            LNode2.AddChild('integer').NodeValue := InvolvedPeople.adamId;
            LNode2.AddChild('key').NodeValue := 'name';
            LNode2.AddChild('string').NodeValue := InvolvedPeople.Name;
        end;
        Changed := True;
        Result := True;
    end;
end;

function TMP4XMLiTunMOVI.AddPersons(InvolvedPeoples: TInvolvedPeoples): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2: IXMLNode;
    i: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if NOT Assigned(LNodeplistdict) then begin
            LNodeplistdict := LNodeElement.AddChild('dict');
        end;
        for i := 0 to Length(InvolvedPeoples) - 1 do begin
            if InvolvedPeoples[i].adamId = '' then begin
                InvolvedPeoples[i].adamId := '0';
            end;
            LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeoples[i].FunctionType);
            if Assigned(LNode) then begin
                LNode2 := LNode.AddChild('dict');
                LNode2.AddChild('key').NodeValue := 'adamId';
                LNode2.AddChild('integer').NodeValue := InvolvedPeoples[i].adamId;
                LNode2.AddChild('key').NodeValue := 'name';
                LNode2.AddChild('string').NodeValue := InvolvedPeoples[i].Name;
            end else begin
                LNodeplistdict.AddChild('key').NodeValue := InvolvedPeoples[i].FunctionType;
                LNode2 := LNodeplistdict.AddChild('array');
                LNode2 := LNode2.AddChild('dict');
                LNode2.AddChild('key').NodeValue := 'adamId';
                LNode2.AddChild('integer').NodeValue := InvolvedPeoples[i].adamId;
                LNode2.AddChild('key').NodeValue := 'name';
                LNode2.AddChild('string').NodeValue := InvolvedPeoples[i].Name;
            end;
            Changed := True;
            Result := True;
        end;
    end;
end;

function TMP4XMLiTunMOVI.PersonExists(InvolvedPeople: TInvolvedPeople): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2, LNode3: IXMLNode;
    i, k: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    try
        if (LNodeElement <> nil) then begin
            LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
            if NOT Assigned(LNodeplistdict) then begin
                LNodeplistdict := LNodeElement.AddChild('dict');
            end;
            LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
            if Assigned(LNode) then begin
                for k := 0 to LNode.ChildNodes.Count - 1 do begin
                    LNode2 := LNode.ChildNodes.Get(k);
                    for i := 0 to LNode2.ChildNodes.Count - 1 do begin
                        LNode3 := LNode2.ChildNodes.Get(i);
                        if SameText(LNode3.NodeName, 'string') then begin
                            if SameText(LNode3.NodeValue, InvolvedPeople.Name) then begin
                                Result := True;
                                Exit;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    except
        Result := False;
    end;
end;

function TMP4XMLiTunMOVI.PersonFindByName(InvolvedPeople: TInvolvedPeople): Integer;
var
    LNodeElement, LNodeplistdict, LNode, LNode2, LNode3: IXMLNode;
    i, k: Integer;
begin
    Result := - 1;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    try
        if (LNodeElement <> nil) then begin
            LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
            if NOT Assigned(LNodeplistdict) then begin
                LNodeplistdict := LNodeElement.AddChild('dict');
            end;
            LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
            if Assigned(LNode) then begin
                for k := 0 to LNode.ChildNodes.Count - 1 do begin
                    LNode2 := LNode.ChildNodes.Get(k);
                    for i := 0 to LNode2.ChildNodes.Count - 1 do begin
                        LNode3 := LNode2.ChildNodes.Get(i);
                        if SameText(LNode3.NodeName, 'string') then begin
                            if SameText(LNode3.NodeValue, InvolvedPeople.Name) then begin
                                Result := k;
                                Exit;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    except
        Result := - 1;
    end;
end;

procedure TMP4XMLiTunMOVI.Load(XMLText: String);
begin
    Changed := False;
    XMLHeader := Copy(XMLText, 1, Pos('<plist', XMLText) - 1);
    //* Create a new XML header if empty
    if XMLHeader = '' then begin
        XMLHeader := '<?xml version="1.0" encoding="UTF-8"?>' + #13#10;
        XMLHeader := XMLHeader + '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' + #13#10;
    end;
    XMLText := Copy(XMLText, Pos('<plist', XMLText), Length(XMLText));
    XMLText := StringReplace(XMLText, 'version=1.0>', 'version="1.0">', [rfIgnoreCase]);
    //LDocument.Options := LDocument.Options + [doNodeAutoIndent];
    //* Create a new XML if empty
    if XMLText = '' then begin
        XMLText := '<plist version="1.0">';
        XMLText := XMLText + #13#10 + '</plist>';
    end;
    LDocument.LoadFromXML(XMLText);
end;

function TMP4XMLiTunMOVI.PersonChange(Index: Integer; InvolvedPeople: TInvolvedPeople): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2, LNode3: IXMLNode;
    i, k: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if NOT Assigned(LNodeplistdict) then begin
            LNodeplistdict := LNodeElement.AddChild('dict');
        end;
        LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
        if Assigned(LNode) then begin
            for k := 0 to LNode.ChildNodes.Count - 1 do begin
                LNode2 := LNode.ChildNodes.Get(k);
                if k = Index then begin
                    for i := 0 to LNode2.ChildNodes.Count - 1 do begin
                        LNode3 := LNode2.ChildNodes.Get(i);
                        if SameText(LNode3.NodeName, 'integer') then begin
                            LNode3.NodeValue := InvolvedPeople.adamId;
                            Changed := True;
                            Result := True;
                        end;
                        if SameText(LNode3.NodeName, 'string') then begin
                            LNode3.NodeValue := InvolvedPeople.Name;
                            Changed := True;
                            Result := True;
                        end;
                    end;
                    Exit;
                end;
            end;
        end;
    end;
end;

function TMP4XMLiTunMOVI.PersonChange(PreviousName: String; InvolvedPeople: TInvolvedPeople): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2, LNode3: IXMLNode;
    i, k: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if NOT Assigned(LNodeplistdict) then begin
            LNodeplistdict := LNodeElement.AddChild('dict');
        end;
        LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
        if Assigned(LNode) then begin
            for k := 0 to LNode.ChildNodes.Count - 1 do begin
                LNode2 := LNode.ChildNodes.Get(k);
                for i := 0 to LNode2.ChildNodes.Count - 1 do begin
                    LNode3 := LNode2.ChildNodes.Get(i);

                    if SameText(LNode3.NodeName, 'string') then begin
                        LNode3.NodeValue := InvolvedPeople.Name;
                        Changed := True;
                        Result := True;
                    end;


                                        if SameText(LNode3.NodeName, 'integer') then begin
                        LNode3.NodeValue := InvolvedPeople.adamId;
                        Changed := True;
                        Result := True;
                    end;



                end;
                Exit;
            end;
        end;
    end;
end;

function TMP4XMLiTunMOVI.PersonDelete(InvolvedPeople: TInvolvedPeople): Boolean;
var
    LNodeElement, LNodeplistdict, LNode, LNode2, LNode3: IXMLNode;
    i, k: Integer;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if Assigned(LNodeplistdict) then begin
            LNode := XMLFindNodeKey(LNodeplistdict, InvolvedPeople.FunctionType);
            if Assigned(LNode) then begin
                for k := 0 to LNode.ChildNodes.Count - 1 do begin
                    LNode2 := LNode.ChildNodes.Get(k);
                    for i := 0 to LNode2.ChildNodes.Count - 1 do begin
                        LNode3 := LNode2.ChildNodes.Get(i);
                        if SameText(LNode3.NodeName, 'string') then begin
                            if SameText(LNode3.NodeValue, InvolvedPeople.Name) then begin
                                LNode.ChildNodes.Delete(k);
                                Changed := True;
                                Result := True;
                                Exit;
                            end;
                        end;
                    end;
                    Exit;
                end;
            end;
        end;
    end;
end;

function TMP4XMLiTunMOVI.PersonDelete(Index: Integer; FunctionType: String): Boolean;
var
    LNodeElement, LNodeplistdict, LNode: IXMLNode;
begin
    Result := False;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if Assigned(LNodeplistdict) then begin
            LNode := XMLFindNodeKey(LNodeplistdict, FunctionType);
            if Assigned(LNode) then begin
                LNode.ChildNodes.Delete(Index);
                Changed := True;
                Result := True;

                //if LNode.ChildNodes.Count = 1 then begin
                //    LNode.ParentNode.ChildNodes.Delete(LNode.NodeName);
                //end;

            end;
        end;
    end;
end;

function TMP4XMLiTunMOVI.PersonIndexChange(Index: Integer; NewIndex: Integer; FunctionType: String): Boolean;
var
    LNodeElement, LNodeplistdict, LNode: IXMLNode;
begin
    Result := False;
    if Index = NewIndex then begin
        Exit;
    end;
    { Find a specific node. }
    LNodeElement := LDocument.ChildNodes.FindNode('plist');
    if (LNodeElement <> nil) then begin
        LNodeplistdict := LNodeElement.ChildNodes.FindNode('dict');
        if NOT Assigned(LNodeplistdict) then begin
            LNodeplistdict := LNodeElement.AddChild('dict');
        end;
        LNode := XMLFindNodeKey(LNodeplistdict, FunctionType);
        if Assigned(LNode) then begin
            LNode.ChildNodes.Insert(NewIndex, LNode.ChildNodes[Index]);
            {
            if NewIndex < Index then begin
                LNode.ChildNodes.Delete(Index + 1);
            end else if NewIndex > Index then begin
                LNode.ChildNodes.Delete(Index);
            end;;
            }
            Changed := True;
            Result := True;
            Exit;
        end;
    end;
end;

Initialization

    MSXMLDOMDocumentFactory.AddDOMProperty('ProhibitDTD', False);

end.
