unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ToolWin, ExtCtrls, ActnList, cRTF, uConst,
  Types;

type
  TfEditor = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    menuFile: TMenuItem;
    menuEdit: TMenuItem;
    menuFileExit: TMenuItem;
    menuFileOpen: TMenuItem;
    menuFileSave: TMenuItem;
    menuFileSaveAs: TMenuItem;
    menuEditCopy: TMenuItem;
    menuEditPaste: TMenuItem;
    menuEditCopyScriptblock: TMenuItem;
    menuHelp: TMenuItem;
    menuHelpAbout: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    menuFormat: TMenuItem;
    menuFormatWordWrap: TMenuItem;
    N4: TMenuItem;
    menuFormatTabwidth: TMenuItem;
    menuFormatTabwidth2: TMenuItem;
    menuFormatTabwidth3: TMenuItem;
    menuFormatTabwidth4: TMenuItem;
    menuFormatTabwidth5: TMenuItem;
    menuFormatTabwidth6: TMenuItem;
    menuFormatTabwidth7: TMenuItem;
    menuFormatTabwidth8: TMenuItem;
    pFiles: TPanel;
    gbFile2: TGroupBox;
    SplitterH: TSplitter;
    gbFileMain: TGroupBox;
    Popup2: TPopupMenu;
    mMemo: TMemo;
    popup2Open: TMenuItem;
    OpenDialog: TOpenDialog;
    PopupMain: TPopupMenu;
    popupMainOpen: TMenuItem;
    ActionList: TActionList;
    ActionHighLight: TAction;
    reRTF: TRTF;  //TRichEdit
    N5: TMenuItem;
    MenuFormatColors: TMenuItem;
    ActionChooseColors: TAction;
    ColorDialog: TColorDialog;
    pRight: TPanel;
    gbCommands: TGroupBox;
    GroupBox1: TGroupBox;
    ToolButton2: TToolButton;
    lvCommands: TListView;
    cbScriptBlocks: TComboBox;
    SplitterV: TSplitter;
    MenuView: TMenuItem;
    MenuViewCommands: TMenuItem;
    Edit1: TEdit;
    ActionSetTabWidth: TAction;
    MenuViewGroupBox1: TMenuItem;
    Edit2: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure menuFormatWordWrapClick(Sender: TObject);
    procedure popup2OpenClick(Sender: TObject);
    procedure popupMainOpenClick(Sender: TObject);
    // RTF events
    procedure reRTFSelectionChange(Sender: TObject);
    procedure reRTFChange(Sender: TObject);
    procedure reRTFVScroll(Msg: TMessage);
    procedure reRTFKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure reRTFMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure reRTFResize(Msg: TWMSize);
    // actions
    procedure ActionHighLightExecute(Sender: TObject);
    procedure ActionChooseColorsExecute(Sender: TObject);
    procedure gbCommandsStartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure GroupBox1StartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure ActionSetTabWidthExecute(Sender: TObject);
    procedure MenuViewCommandsClick(Sender: TObject);
    procedure MenuViewGroupBox1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure pRightUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
    procedure SplitterHMoved(Sender: TObject);
  private
    FWindowProc: TWndMethod;
    PerformanceCounter, PerformanceFrequency: Int64;
    FS: TFormatSettings;
    ScriptBlocks: TScriptBlocks;
    Enriched: array of boolean;
    //
{    procedure RTFMessageProc(var Message: TMessage);}

    procedure SetBGColor(const RTF: TRTF; const LineNr: integer; const BG: TColor);
    procedure DoHighlight(RTF: TRTF; const SStart,SLength: integer; SColor: TColor; SStyle: TFontStyles);
    function GetRTFLineNr(const RTF: TRTF) : integer;
    function GetTotalLines(const RTF: TRTF) : integer;
    function GetFirstVisibleLine(const RTF: TRTF) : integer;
    function GetTotalVisibleLines(const RTF: TRTF) : integer;
    function GetTotalVisibleLinesF(const RTF: TRTF) : single;
    function GetLastVisibleLine(const RTF: TRTF) : integer;
    function GetLineHeight(const RTF: TRTF) : integer;
    procedure SetLineSpacing(const RTF: TRTF; LineSpacing: integer);
    //
    function IsHScrollbarVisible(const RTF: TRTF) : boolean;
    function GetHScrollbarHeight(const RTF: TRTF) : integer;
    function GetVScrollbarWidth(const RTF: TRTF) : integer;
    procedure SetScrollbarInfo(const RTF: TRTF);
    //
    function FindNextWord(const RTF: TRTF; var LineNr: integer; var WordStart,WordEnd, WordLen: integer; var s: string) : boolean;
    function FindNextWord2(const RTF: TRTF; var WordStart,WordEnd,WordLen: integer; const skipComment, skipString: boolean) : boolean;
    function IsTriggerDefinition(const RTF: TRTF; var LineNr: integer; var WordStart,WordEnd, WordLen: integer; const CommentX: integer) : boolean;
    function IsEvent(const RTF: TRTF; var LineNr: integer; const EventType: string; var WordStart,WordEnd, WordLen: integer; const CommentX: integer) : boolean;
    //
    procedure GetScriptBlocks(const RTF: TRTF);
  public
  end;



  TDockForm = class(TCustomDockForm)
    constructor Create(AOwner: TComponent); override;
    procedure   DoClose(var Action: TCloseAction); override;
  end;



//------------------------------------------------------------------------------

var
  fEditor: TfEditor;



implementation
uses StrUtils, RichEdit, Math;
{$R *.dfm}

//------------------------------------------------------------------------------
constructor TDockForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderIcons := [];                    // This disables the 'close' button
end;

procedure TDockForm.DoClose(var Action: TCloseAction);
begin
  Action := caNone;
end;
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
{procedure TfEditor.RTFMessageProc(var Message: TMessage);
begin
  with Message do begin
    case Msg of
      EN_VSCROLL: begin
                    if LParam = reRTF.Handle then ActionHighLightExecute(nil);
                    Result := 0;
                  end;
    else
      FWindowProc(Message);
    end;
  end;
end;}

procedure TfEditor.FormCreate(Sender: TObject);
var i: integer;
begin
(*
  FWindowProc := WindowProc;
  WindowProc := RTFMessageProc;
*)
  // performance measurements
  QueryPerformanceFrequency(PerformanceFrequency);

  // Settings for English/US (DecimalsSeperator)
  GetLocaleFormatSettings($0409,FS);  // en/us

  SetLength(ScriptBlocks, 0);

  // dock controls to the panel on the right
  gbCommands.ManualDock(pRight, nil, alTop);
  GroupBox1.ManualDock(pRight, nil, alBottom);

  with reRTF.DefAttributes do begin
    Height := 11;
    Color := clBlack;
    Style := [];
  end;

  // set linespacing and tab-positions
  SetLineSpacing(reRTF, cLineSpacing);
  ActionSetTabWidthExecute(nil);

  mMemo.Lines.LoadFromFile('UJE_warzone_sniper.script');
  reRTF.Lines.LoadFromFile('UJE_00.script');
  SetLength(Enriched, reRTF.Lines.Count);
  for i:=Low(Enriched) to High(Enriched) do Enriched[i] := false;

  // we want to get notified of scroll-events
  SendMessage(reRTF.Handle, EM_SETEVENTMASK, 0, ENM_CHANGE + ENM_SCROLL + ENM_SCROLLEVENTS);
  // set the scrollbar pagesize
  SetScrollbarInfo(reRTF);

  // find all scriptblocks
  //GetScriptBlocks(reRTF);

  // splitter to top position to hide the 2nd file
//  gbFile2.Height := 10;

  ActionHighLightExecute(nil);
end;

procedure TfEditor.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
var Diff: integer;
    TM : TTextMetric;
//2    HScrollVisible: boolean;
//2    PixelsNeeded: integer;
begin
  GetTextMetrics(GetDC(reRTF.Handle), TM);
  Diff := (NewHeight mod TM.tmAscent) -1;

//2  PixelsNeeded := GetTotalVisibleLines(reRTF) * GetLineHeight(reRTF);
//2  // RTF's horizontal scrollbar visible??
//2  HScrollVisible := IsHScrollbarVisible(reRTF);
//2  if HScrollVisible then Inc(PixelsNeeded, 16); //scrollbar height
//2  if IsHScrollbarVisible(reRTF) then Diff := reRTF.ClientHeight - PixelsNeeded;

  NewHeight := NewHeight - Diff;
end;

procedure TfEditor.gbCommandsStartDock(Sender: TObject; var DragObject: TDragDockObject);
begin
//**  DragObject := TDragDockObjectEx.Create(gbCommands); //test
//  gbCommands.FloatingDockSiteClass := TDockForm;    // Use our own docksite class, which in our case disables the 'close' button
end;
procedure TfEditor.GroupBox1StartDock(Sender: TObject; var DragObject: TDragDockObject);
begin
//**  DragObject := TDragDockObjectEx.Create(gbCommands); //test
//  GroupBox1.FloatingDockSiteClass := TDockForm;    // Use our own docksite class, which in our case disables the 'close' button
end;

procedure TfEditor.pRightUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
  // undocking the last client??
//  if pRight.DockClientCount=1 then //pRight.Width := 29;
                                   //pFiles.Width := ClientWidth - 25;
end;




//------------------------------------------------------------------------------
procedure TfEditor.reRTFSelectionChange(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Line '+ IntToStr(GetRTFLineNr(reRTF)) +'/'+ IntToStr(GetTotalLines(reRTF));
end;

procedure TfEditor.reRTFChange(Sender: TObject);
var LineNr, FirstVisibleLine, LastVisibleLine: integer;
begin
(*
  LineNr := GetRTFLineNr(reRTF);
  if LineNr<Length(Enriched) then Enriched[LineNr-1] := false;
*)
  FirstVisibleLine := GetFirstVisibleLine(reRTF);
  LastVisibleLine := GetLastVisibleLine(reRTF);
  for LineNr:=FirstVisibleLine to LastVisibleLine do
    if LineNr<Length(Enriched) then Enriched[LineNr-1] := false;

  ActionHighLightExecute(nil);
end;

procedure TfEditor.reRTFVScroll(Msg: TMessage);
begin
  // it works, but..
  // this call creates a buggy vertical-scrollbar for the RTF-control while dragging
{  ActionHighLightExecute(nil);}
end;

procedure TfEditor.reRTFResize(Msg: TWMSize);
begin
  // Msg.Width  Msg.Height
  ActionHighLightExecute(nil);
end;

procedure TfEditor.reRTFKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
//    VK_LEFT, VK_RIGHT,          // arrow-left, arrow-right
//    VK_UP, VK_DOWN,             // arrow-up, arrow-down
    VK_HOME, VK_END,            // home, end
    VK_PRIOR, VK_NEXT: begin    // page-up, page-down
      ActionHighLightExecute(nil);
    end;
  end;
end;

procedure TfEditor.reRTFMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ActionHighLightExecute(nil);
end;

procedure TfEditor.SplitterHMoved(Sender: TObject);
begin
  SetScrollbarInfo(reRTF);
end;




//------------------------------------------------------------------------------
procedure TfEditor.menuFormatWordWrapClick(Sender: TObject);
begin
  if menuFormatWordWrap.Checked then begin
    reRTF.ScrollBars := ssVertical;
    reRTF.WordWrap := true;
  end else begin
    reRTF.ScrollBars := ssBoth;
    reRTF.WordWrap := false;
  end;
end;

procedure TfEditor.MenuViewCommandsClick(Sender: TObject);
begin
  if not gbCommands.Visible then gbCommands.Visible := true;
end;

procedure TfEditor.MenuViewGroupBox1Click(Sender: TObject);
begin
  if not GroupBox1.Visible then GroupBox1.Visible := true;
end;


// een bestand openen in de onderste RTF
procedure TfEditor.popupMainOpenClick(Sender: TObject);
var i: integer;
begin
  if not OpenDialog.Execute then Exit;
  reRTF.Lines.LoadFromFile(OpenDialog.FileName);
  SetLength(Enriched, reRTF.Lines.Count);
  for i:=Low(Enriched) to High(Enriched) do Enriched[i] := false;
  gbFileMain.Caption := 'File: '+ OpenDialog.FileName;
  ActionHighLightExecute(nil);
end;

// een bestand openen in de bovenste Memo
procedure TfEditor.popup2OpenClick(Sender: TObject);
begin
  if not OpenDialog.Execute then Exit;
  mMemo.Lines.LoadFromFile(OpenDialog.FileName);
end;


//------------------------------------------------------------------------------
procedure TfEditor.SetBGColor(const RTF: TRTF; const LineNr: integer; const BG: TColor);
var CFormat: TCharFormat2;
begin
  ZeroMemory(@CFormat, SizeOf(TCharFormat2));
  with CFormat do begin
    cbSize := SizeOf(TCharFormat2);
    dwMask := CFM_BACKCOLOR;
    crBackColor := BG;
    RTF.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@CFormat));
  end;
end;

procedure TfEditor.DoHighlight(RTF: TRTF; const SStart, SLength: integer; SColor: TColor; SStyle: TFontStyles);
begin
  RTF.SelStart := SStart;
  RTF.SelLength := SLength;
  with RTF.SelAttributes do begin
    Color := SColor;
    Style := SStyle;
  end;
end;

function TfEditor.GetRTFLineNr(const RTF: TRTF): integer;
begin
  Result := SendMessage(RTF.Handle, EM_LINEFROMCHAR, RTF.SelStart, 0);
end;

function TfEditor.GetTotalLines(const RTF: TRTF): integer;
begin
  Result := SendMessage(RTF.Handle, EM_GETLINECOUNT, 0, 0);
end;

function TfEditor.GetFirstVisibleLine(const RTF: TRTF): integer;
begin
  Result := SendMessage(RTF.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
end;

function TfEditor.GetLastVisibleLine(const RTF: TRTF): integer;
begin
  Result := GetFirstVisibleLine(RTF) + GetTotalVisibleLines(RTF);
end;

function TfEditor.GetTotalVisibleLines(const RTF: TRTF): integer;
begin
  Result := RTF.ClientHeight div GetLineHeight(RTF);
end;

function TfEditor.GetTotalVisibleLinesF(const RTF: TRTF): single;
begin
  Result := RTF.ClientHeight / GetLineHeight(RTF);
end;

function TfEditor.GetLineHeight(const RTF: TRTF): integer;
var R: TRect;
begin
  R := Rect(0,0,0,0);
  with TBitmap.Create do
    try
      Canvas.Font.Assign(RTF.Font);
      DrawText(Canvas.Handle, 'ABC', -1, R, DT_SINGLELINE or DT_CALCRECT);
    finally
      Free;
    end;
  Result := R.Bottom - R.Top;
end;

procedure TfEditor.SetLineSpacing(const RTF: TRTF; LineSpacing: integer);
var PF2: TParaFormat2;
begin
  RTF.SelectAll;
  ZeroMemory(@PF2, SizeOf(TParaFormat2));
  PF2.cbSize := SizeOf(TParaFormat2);
  PF2.dwMask := PFM_LINESPACING + PFM_SPACEAFTER;
  // if single-spacing, set to 20 twentieths
  {if LineSpacing<>0 then begin}
    PF2.bLineSpacingRule := 5; // space in 20ths of a line height
    PF2.dyLineSpacing := 20 * LineSpacing;
    RTF.Perform(EM_SETPARAFORMAT, 0, LongInt(@PF2));
  {end;
  // drop through even if lineSpacing == 0 to ensure
  // correct value from bLineSpacingRule with EM_GETPARAFORMAT
  PF2.bLineSpacingRule := LineSpacing;
  RTF.Perform(EM_SETPARAFORMAT, 0, LongInt(@PF2));}
  RTF.SelLength := 0;
end;

function TfEditor.IsHScrollbarVisible(const RTF: TRTF): boolean;
begin
  Result := (GetWindowLong(RTF.Handle, GWL_STYLE) and WS_HSCROLL <> 0);
end;

function TfEditor.GetHScrollbarHeight(const RTF: TRTF): integer;
begin
  Result := 0;
  if (GetWindowlong(RTF.Handle, GWL_STYLE) and WS_HSCROLL) <> 0 then
    Result := GetSystemMetrics(SM_CYHSCROLL);
end;

function TfEditor.GetVScrollbarWidth(const RTF: TRTF): integer;
begin
  Result := 0;
  if (GetWindowlong(RTF.Handle, GWL_STYLE) and WS_VSCROLL) <> 0 then
    Result := GetSystemMetrics(SM_CXVSCROLL);
end;

procedure TfEditor.SetScrollbarInfo(const RTF: TRTF);
var ScrollInfo: TScrollInfo;
    i: integer;
    {lh: single;}
begin
  // set scroll page distance
  {lh := GetLineHeight(RTF) / 20 * cLineSpacing + GetLineHeight(RTF);}
  i := ((GetTotalVisibleLines(RTF)+1) {* GetLineHeight(RTF)}{round(lh)}) {- GetHScrollbarHeight(RTF)};
  ZeroMemory(@ScrollInfo, SizeOf(TScrollInfo));
  With ScrollInfo do begin
    cbSize := SizeOf(TScrollInfo);
    fMask := SIF_ALL; //SIF_PAGE;  //ALL = SIF_PAGE, SIF_POS, SIF_RANGE, and SIF_TRACKPOS
  end;
  GetScrollInfo(RTF.Handle, SB_CTL{SB_VERT}, ScrollInfo);
  With ScrollInfo do begin
    cbSize := SizeOf(TScrollInfo);
    fMask := SIF_RANGE + SIF_PAGE {+ SIF_POS};
    nMin := 0;
    {nMax := round(abs((RTF.Lines.Count * lh) - i));}
    nMax := abs((RTF.Lines.Count {* GetLineHeight(RTF)}) - i);
    nPage := i;
    {nPos := GetFirstVisibleLine(RTF) * GetLineHeight(RTF);}
  end;
  i := SetScrollInfo(RTF.Handle, SB_CTL{SB_VERT}, ScrollInfo, true);
//  reRTF.Perform(SBM_SETSCROLLINFO, 1, longint(@ScrollInfo));
{  GetScrollInfo(reRTF.Handle, SB_VERT, ScrollInfo);}
end;




function TfEditor.FindNextWord(const RTF: TRTF; var LineNr: integer; var WordStart, WordEnd, WordLen: integer; var s: string): boolean;
var Len: integer;
    stmp: string;
begin
  stmp := RTF.Lines.Strings[LineNr];
  if Trim(stmp)='' then begin
    Result := false;
    Exit;
  end;
  Len := Length(stmp);
  // strip leading characters
  while (stmp[WordStart]=#9) or (stmp[WordStart]=' ') do
    Inc(WordStart);
  // strip word
  WordEnd := WordStart;
  repeat
    Inc(WordEnd);
  until (stmp[WordEnd]=#9) or (stmp[WordEnd]=' ') or
        (stmp[WordEnd]=#13) or (stmp[WordEnd]=#10) or (WordEnd>Len);
  //
  WordLen := WordEnd - WordStart;
  s := Copy(stmp, WordStart,WordLen);
  if s='' then begin
    Result := false;
    WordLen := 0;
  end else begin
    Result := true;
  end;
end;

function TfEditor.FindNextWord2(const RTF: TRTF; var WordStart,WordEnd,WordLen: integer; const skipComment,skipString: boolean): boolean;
var WS,WL: integer;
    CommentX, StringX,StringX2: integer;
    EOL, q,q1,q2,q3,q4,j: integer;
begin
  // input:  WordStart = current position
  // output: WordStart = beginning of next word
  //         WordLen   = length of word
  
  //WS := RTF.SelStart;
  //WL := RTF.SelLength;

  q := WordStart;

  // check if text starts with a comment
  if not (Copy(RTF.Text,q,2)='//') then begin
    // caret in the middle of a word??
    j := AnsiIndexText(RTF.Text[q], ETDelimiters);
    if j=-1 then begin
      // search for next delimiter
      q1 := PosEx(' ', RTF.Text, q+1);
      q2 := PosEx(#9, RTF.Text, q+1);
      q3 := PosEx(#13, RTF.Text, q+1);
      q4 := PosEx(#10, RTF.Text, q+1);
      q := Min(q1,Min(q2,Min(q3,q4)));
    end;

    // find next character
    repeat
      Inc(q);
    until (AnsiIndexText(RTF.Text[q], ETDelimiters)=-1);
    WordStart := q;
  end;

  repeat
    // skip comment
    if Copy(RTF.Text,q,2)='//' then begin
    //if AnsiStartsText('//', RTF.Text[WordStart]) then begin
      // find EOL
      EOL := PosEx(#13, RTF.Text, q);
      // find the next character on the next line
      q := EOL;
      repeat
        Inc(q);
      until (AnsiIndexText(RTF.Text[q], ETDelimiters)=-1);
      WordStart := q;
    end;

    // skip string
    if RTF.Text[WordStart]='"' then begin
      // find the next "-quote
      q := PosEx('"', RTF.Text, q+1);
      // find the next character
      Inc(q);
      repeat
        Inc(q);
      until (AnsiIndexText(RTF.Text[q], ETDelimiters)=-1);
      WordStart := q;
    end;
  until not ((RTF.Text[q]='/') or (RTF.Text[q]='"'));

  // find next delimiter
  q1 := PosEx(' ', RTF.Text, q+1);
  q2 := PosEx(#9, RTF.Text, q+1);
  q3 := PosEx(#13, RTF.Text, q+1);
  q4 := PosEx(#10, RTF.Text, q+1);
  q := Min(q1,Min(q2,Min(q3,q4)));
  WordLen := q - WordStart;

  Result := (WordStart+WordLen+1 < Length(RTF.Text));

  //RTF.SelLength := WL;
  //RTF.SelStart := WS;
end;


function TfEditor.IsTriggerDefinition(const RTF: TRTF; var LineNr: integer; var WordStart,WordEnd, WordLen: integer; const CommentX: integer): boolean;
var WS,WE,WL: integer;
    s: string;
    b: boolean;
//--
  procedure RestoreVars;
  begin
    WordStart := WS;
    WordEnd := WE;
    WordLen := WL;
  end;
//--
  procedure ContinueSearchOnNextLine;
  begin
    Inc(LineNr);
    RTF.CaretPos := Point(0,LineNr);
    WordStart := 1;
    b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // {
    if b then begin
      if s='{' then begin
        Result := true;
        Exit;
      end else begin
        // restore search position
        Result := false;
        Dec(LineNr);
        RTF.CaretPos := Point(0,LineNr);
        RestoreVars;
      end;
    end;
  end;
//--
begin
  // Result=true if only found: 'trigger' + triggername + '{'
  Result := false;
  WS := WordStart;
  WE := WordEnd;
  WL := WordLen;
  WordStart := WordEnd+1;
  b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // triggername
  if b then begin
    WordStart := WordEnd+1;
    b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // {
    if b then begin
      // continue search on next line??
      if WordStart>=CommentX then begin
        ContinueSearchOnNextLine;
        if Result then Exit;
      end;
      if s='{' then begin
        Result := true;
        Exit;
      end else begin
        // restore search position
        Result := false;
        RestoreVars;
      end;
    end else begin
      // continue search on next line
      ContinueSearchOnNextLine;
      if Result then Exit;
    end;
  end else begin
    // restore search position
    Result := false;
    RestoreVars;
  end;
end;

function TfEditor.IsEvent(const RTF: TRTF; var LineNr: integer; const EventType: string; var WordStart,WordEnd,WordLen: integer; const CommentX: integer): boolean;
var WS,WE,WL,WLR, j: integer;
    s: string;
    b: boolean;
//--
  procedure RestoreVars;
  begin
    WordStart := WS;
    WordEnd := WE;
    WordLen := WL;
  end;
//--
  procedure ContinueSearchOnNextLine;
  begin
    Inc(LineNr);
    RTF.CaretPos := Point(0,LineNr);
    WordStart := 1;
    b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // {
    if b then begin
      if s='{' then begin
        WordLen := WLR;    //!
        Result := true;
        Exit;
      end else begin
        // restore search position
        Result := false;
        Dec(LineNr);
        RTF.CaretPos := Point(0,LineNr);
        RestoreVars;
      end;
    end;
  end;
//--
begin
  // Result=true if found: 'trigger' + eventname + '{'
  // Result=true if found: 'activate' + eventname + '{'
  // Result=true if found: 'mg42' + eventname + '{'
  Result := false;
  WS := WordStart;
  WE := WordEnd;
  WL := WordLen;
  WordStart := WordEnd+1;
  b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // eventname
  if b then begin
    // check for an eventname
    if EventType='trigger' then j := AnsiIndexText(s, Events2) else
    if EventType='activate' then j := AnsiIndexText(s, Events3) else
    if EventType='mg42' then j := AnsiIndexText(s, Events4) else
    if EventType='buildstart' then j := AnsiIndexText(s, Events5) else
    if EventType='built' then j := AnsiIndexText(s, Events5) else
    if EventType='decayed' then j := AnsiIndexText(s, Events5) else
    if EventType='destroyed' then j := AnsiIndexText(s, Events5);
    WLR := WordEnd-WS;
    if j<>-1 then begin
      WordStart := WordEnd+1;
      b := FindNextWord(RTF, LineNr, WordStart,WordEnd,WordLen, s); // {
      if b then begin
        // continue search on next line??
        if WordStart>=CommentX then begin
          ContinueSearchOnNextLine;
          if Result then Exit;
        end;
        if s='{' then begin
          WordLen := WLR;  //!
          Result := true;
          Exit;
        end else begin
          // restore search position
          Result := false;
          RestoreVars;
        end;
      end else begin
        // continue search on next line
        ContinueSearchOnNextLine;
        if Result then Exit;
      end;
    end else begin
      Result := false;
      RestoreVars;
    end;
  end else begin
    // restore search position
    Result := false;
    RestoreVars;
  end;
end;


procedure TfEditor.GetScriptBlocks(const RTF: TRTF);
var Wordstart,WordEnd,WordLen: integer;
    Level: integer;
    s: string;
begin
  // get all scriptblocks contained in the script
  Wordstart := 0;
  Level := 0;
  while FindNextWord2(RTF, WordStart,WordEnd,WordLen,true,true) do begin
    if RTF.Text[WordStart]='{' then Inc(Level);
    if Level=0 then begin
      s := Copy(RTF.Text,WordStart,WordLen);
      cbScriptBlocks.Items.Add(s);
    end;
    if RTF.Text[WordStart]='}' then Dec(Level);
  end;
end;


//------------------------------------------------------------------------------
procedure TfEditor.ActionChooseColorsExecute(Sender: TObject);
begin
  //
end;

procedure TfEditor.ActionSetTabWidthExecute(Sender: TObject);
const NrOfTabs = MAX_TAB_STOPS {32};
var TW, i: integer;
    EventMask: longint;
    PF: TParaFormat;
    TS: TagSize;
    Twips: integer;
begin
  if menuFormatTabwidth2.Checked then TW := 2 else
  if menuFormatTabwidth3.Checked then TW := 3 else
  if menuFormatTabwidth4.Checked then TW := 4 else
  if menuFormatTabwidth5.Checked then TW := 5 else
  if menuFormatTabwidth6.Checked then TW := 6 else
  if menuFormatTabwidth7.Checked then TW := 7 else
  if menuFormatTabwidth8.Checked then TW := 8 else Exit;

//  reRTF.Perform(EM_HIDESELECTION, 1, 0);
  reRTF.Perform(WM_SETREDRAW, 0, 0);
  EventMask := SendMessage(reRTF.Handle, EM_SETEVENTMASK, 0, 0);
  reRTF.Lines.BeginUpdate;
  reRTF.SelectAll;

  // convert pixels to twips
  GetTextExtentPoint32(getDC(reRTF.Handle), PChar(DupeString('X',TW)), TW, TS);
  TS.cx := TS.cx - 2;
  Twips := TS.cx * 1440 div reRTF.Font.PixelsPerInch;

  ZeroMemory(@PF, SizeOf(TParaFormat));
  PF.cbSize := SizeOf(TParaFormat);
  PF.dwMask := PFM_TABSTOPS;
  for i:=1 to NrOfTabs do PF.rgxTabs[i-1] := i * Twips;
  PF.cTabCount := NrOfTabs;
  reRTF.Perform(EM_SETPARAFORMAT, 0, longint(@PF));

  reRTF.SelStart := 0;
  reRTF.Lines.EndUpdate;
  SendMessage(reRTF.Handle, EM_SETEVENTMASK, 0, EventMask);
  reRTF.Perform(WM_SETREDRAW, 1, 0);
  InvalidateRect(reRTF.Handle, 0, longbool(false)); //no background erase
//  reRTF.Perform(EM_HIDESELECTION, 0, 0);
end;

procedure TfEditor.ActionHighLightExecute(Sender: TObject);
label LabelCommands;
type TRestore = record
       EventMask: longint;
       CaretPos: TPoint;
       SelStart, SelLength: integer;
     end;
var LineNr,Len, LineStart, i,j: integer;
    WStart, WEnd, WLen: integer;
    CommentX: integer;
    StringX, StringX2: integer;
    CommandX, CommandX2: integer;
    FirstVisibleLine, LastVisibleLine: integer;
    Restore: TRestore;
    s,sw: string;
    b: boolean;
    WS: integer;
    aNumber, Code: integer;
    aFloatNumber: single;
    CommandLine, StringFound: boolean;
    Level: integer;
    CounterBefore, CounterAfter: int64;
    XLen: integer;
    eventChange: TNotifyEvent;
    eventKey: TKeyEvent;
    eventMouseWheel: TMouseWheelEvent;
    eventResize: TResizeEvent;
    eventSelectionChange: TNotifyEvent;
    eventScroll: TScrollEvent;
begin
//  if not reRTF.Modified then Exit;

  //timing
  QueryPerformanceCounter(CounterBefore);

//  SetScrollbarInfo(reRTF);

  try
    // event-handlers tijdelijk deactiveren..
    eventChange := reRTF.OnChange;
    reRTF.OnChange := nil;
    eventKey := reRTF.OnKeyUp;
    reRTF.OnKeyUp := nil;
    eventMouseWheel := reRTF.OnMouseWheel;
    reRTF.OnMouseWheel := nil;
    eventResize := reRTF.OnResize;
    reRTF.OnResize := nil;
    eventSelectionChange := reRTF.OnSelectionChange;
    reRTF.OnSelectionChange := nil;
    eventScroll := reRTF.OnVScroll;
    reRTF.OnVScroll := nil;

//    LockWindowUpdate(reRTF.Handle);   //creates a flickering desktop :S
    Restore.EventMask := SendMessage(reRTF.Handle, EM_SETEVENTMASK, 0, 0);
    //SendMessage(reRTF.Handle, WM_SETREDRAW, 0, 0); //false,0
    reRTF.Perform(WM_SETREDRAW, 0, 0); //false,0
    reRTF.Perform(EM_HIDESELECTION, 1, 0);
    with Restore do begin
//    ShowCursor(false);
      CaretPos := reRTF.CaretPos;
      SelStart := reRTF.SelStart;
      SelLength := reRTF.SelLength;
    end;

    Level := 0;
    FirstVisibleLine := GetFirstVisibleLine(reRTF);
    LastVisibleLine := GetLastVisibleLine(reRTF);
    for LineNr:=FirstVisibleLine to LastVisibleLine do begin
//    for LineNr:=0 to reRTF.Lines.Count-1 do begin

      // has this line allready been converted to RTF??
      if LineNr<Length(Enriched) then begin
        if Enriched[LineNr-1] then Continue;
        Enriched[LineNr-1] := true;
      end;

      // set the beginning of the selection to the beginning of this line
      reRTF.CaretPos := Point(0,LineNr);
      LineStart := reRTF.SelStart;
      Len := Length(reRTF.Lines.Strings[LineNr]);

      // default text-style
      DoHighlight(reRTF, LineStart,Len, clBlack,[]);
//    SetBGColor(reRTF,LineNr,$00F9F9F9);


      //--- check for comments -------------------------------------------------
      CommentX := Pos('//', reRTF.Lines.Strings[LineNr]);
      if CommentX>0 then DoHighlight(reRTF, LineStart+CommentX-1,Len-CommentX+1, clGreen,[]);
      if CommentX=1 then Continue;


      //------------------------------------------------------------------------
      WStart := 1;
      CommandLine := false;
      while FindNextWord(reRTF, LineNr, WStart,WEnd,WLen, s) do begin
        if (CommentX>0) and (WStart>=CommentX) then Break;

        //--- check for events -------------------------------------------------
        j := AnsiIndexText(s, Events);
        if j<>-1 then begin
          // check for event declarations (that consist of 2 words)
          WS := WStart;
          if (AnsiIndexText(s, Events_)<>-1) then begin
            if IsEvent(reRTF, LineNr, s, WStart,WEnd,WLen, CommentX) then begin
              WStart := WS;
            end else
//              if (s='trigger') or (s='mg42') then Break;
              if (s='trigger') then goto LabelCommands;
          end;
          //
          if not CommandLine then DoHighlight(reRTF, LineStart+WStart-1,WLen, clRed,[fsBold]);
        end else begin

LabelCommands:
          //--- check for commands ---------------------------------------------
          if not CommandLine then begin
            j := AnsiIndexText(s, Commands);
            if j<>-1 then begin
              // check for a trigger definition
              if s='trigger' then
                if IsTriggerDefinition(reRTF, LineNr, WStart,WEnd,WLen, CommentX) then Break;
              //
              DoHighlight(reRTF, LineStart+WStart-1,WLen, clBlack,[fsBold]);
              // there is only 1 command on each line
              CommandLine := true;
            end;
          end else begin

            //--- check for reserved words -------------------------------------
            j := AnsiIndexText(s, ReservedWords);
            if j<>-1 then
              DoHighlight(reRTF, LineStart+WStart-1,WLen, clBlue,[])
            else begin

              //--- check for strings ------------------------------------------
              StringFound := false;
              StringX := Pos('"', s);
              repeat
                if StringX<>1 then Break;          // not found
                if CommentX>0 then
                  if WStart+StringX>CommentX then Break; // string opening-doublequote found in comment
                XLen := Length(s);
                if s[XLen]='"' then StringX2 := WStart + XLen
                               else StringX2 := PosEx('"', reRTF.Lines.Strings[LineNr], WStart+1);
                if StringX2=0 then Break;         // no string closing-doublequote found

                WLen := StringX2 - WStart+1;
                WEnd := StringX2;
                DoHighlight(reRTF, LineStart+WStart-1,WLen, clNavy,[]);

                StringFound := true;
                Break;
              until true;

              //--- check for numbers ------------------------------------------
              if not StringFound then begin
                Val(s, aNumber, Code);
                if Code<>0 then begin
                  // check for a float
                  if TryStrToFloat(s,aFloatNumber,FS) then Code := 0
                                                      else Code := -1;
                end;
                if Code=0 then DoHighlight(reRTF, LineStart+WStart-1,WLen, clMaroon,[]);
              end;
            end;

          end;
        end;

        WStart := WEnd+1;
        if WStart>Len then Break;
        if (CommentX>0) and (WStart>=CommentX) then Break;
      end;

    end;

//    FindCurrentScriptblock(reRTF, Restore.SelStart);

  finally
    with Restore do begin
      reRTF.CaretPos := CaretPos;
      reRTF.SelStart := SelStart;
      reRTF.SelLength := SelLength;
//    ShowCursor(true);
    end;
    reRTF.Perform(EM_HIDESELECTION, 0, 0);
    //SendMessage(reRTF.Handle, WM_SETREDRAW, 1, 0);  //true,0
    reRTF.Perform(WM_SETREDRAW, 1, 0); //true,0
    InvalidateRect(reRTF.Handle, 0, longbool(false)); //no background erase
    SendMessage(reRTF.Handle, EM_SETEVENTMASK, 0, Restore.EventMask);
//    LockWindowUpdate(0);

    // events weer inschakelen
    reRTF.OnChange := eventChange;
    reRTF.OnKeyUp := eventKey;
    reRTF.OnMouseWheel := eventMouseWheel;
    reRTF.OnResize := eventResize;
    reRTF.OnSelectionChange := eventSelectionChange;
    reRTF.OnVScroll := eventScroll;

//SetScrollbarInfo(reRTF);

    QueryPerformanceCounter(CounterAfter);
    edit1.Text := floattoStr( (CounterAfter-CounterBefore)/PerformanceFrequency );
  end;
end;









end.
