unit alphiWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wke, AppEvnts, Imm;

type
  TForm2 = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure WMActivate(var Msg: TMessage); message WM_ACTIVATE;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses main;

{$R *.dfm}

procedure TForm2.WMActivate(var Msg: TMessage);
begin
    inherited;
    if Msg.wParam=0 then
      wkeUnfocus(Form1.webView);
    if (Msg.wParam=1) or (Msg.wParam=2) then
      wkeFocus(Form1.webView);
end;

procedure TForm2.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  flags:Word;
  caret:wkeRect;
  form:TCandidateForm;//CANDIDATEFORM;
  hIMC:integer;
begin
  //form1.mmo1.Lines.Add(inttostr(form2.Handle)+':'+inttostr(Msg.hwnd));
  Handled:=false;
  if form2.Handle=Msg.hwnd then
  case Msg.message of
    {WM_MOUSEMOVE, WM_LBUTTONDOWN, WM_LBUTTONUP, WM_RBUTTONDOWN, WM_LBUTTONDBLCLK, WM_RBUTTONUP:
      begin
        flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;
        //if Msg.message <> WM_MOUSEMOVE then
        //  flags:=HIWORD(Msg.lParam);
        wkeMouseEvent(Form1.webView, Msg.message, loword(Msg.lParam), hiword(Msg.lparam), flags);
      end;}
    WM_CHAR:
      begin 
        //typ := KT_KEYUP;
        //info.sysChar := True;
        //info.imeChar := False;
        {flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;
       // Ord();                }
        {flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyPress(Form1.webView,Msg.wParam,flags,false);
        if Handled then
          form1.mmo1.Lines.Add('c:'+inttostr(Msg.wParam)+'|'+inttostr(HIWORD(Msg.lParam))+'|'+inttostr(LOWORD(Msg.lParam))+'|'+inttostr(flags));
         }
      end;

    WM_KEYDOWN:
      begin
        //typ := KT_KEYDOWN;
        //info.sysChar := False;
        //info.imeChar := False;
        {flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;    }
 {       flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyDown(Form1.webView,Msg.wParam,flags,false);  }
        //form1.mmo1.Lines.Add('d:'+inttostr(Msg.wParam));
        //form1.mmo1.Lines.Add('WM_KEYDOWN-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;
      
    WM_KEYUP:
      begin
        //typ := KT_KEYUP;
        //info.sysChar := False;
        //info.imeChar := False;
        {flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED; }
{        flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyUp(Form1.webView,Msg.wParam,flags,false);     }
        //form1.mmo1.Lines.Add('u:'+inttostr(Msg.wParam));
        //form1.mmo1.Lines.Add('WM_KEYUP-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;

    {WM_SYSCHAR:
      begin  
        flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;
        flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyPress(Form1.webView,Word(Msg.wParam),flags,true);
      end;

    WM_SYSKEYDOWN:
      begin
        //typ := KT_KEYDOWN;
        //info.sysChar := True;
        //info.imeChar := False;
       flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;
        flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyDown(Form1.webView,Word(Msg.wParam),flags,true);
        //form1.mmo1.Lines.Add('WM_SYSKEYDOWN-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;
    WM_SYSKEYUP:
      begin
        //typ := KT_KEYUP;
        //info.sysChar := True;
        //info.imeChar := False;
        flags:=0;
        if (HIWORD(Msg.lParam) and KF_REPEAT)<>0 then
          flags := flags or WKE_REPEAT;
        if (HIWORD(Msg.lParam) and KF_EXTENDED)<>0 then
          flags := flags or WKE_EXTENDED;      
        flags:=HIWORD(Msg.lParam);
        Handled:=wkeKeyUp(Form1.webView,Word(Msg.wParam),flags,true);
        //form1.mmo1.Lines.Add('WM_SYSKEYUP-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;
    WM_IME_CHAR:
      begin
        form1.mmo1.Lines.Add('WM_IME_CHAR');
      end;}
    {WM_IME_CHAR:
      begin
        //typ := KT_CHAR;
        //info.sysChar := False;
        //info.imeChar := True;
        //form1.mmo1.Lines.Add();
        form1.mmo1.Lines.Add('WM_IME_CHAR'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;

    WM_IME_KEYDOWN:
      begin
        //typ := KT_KEYDOWN;
        //info.sysChar := False;
        //info.imeChar := True;
        form1.mmo1.Lines.Add('WM_IME_KEYDOWN-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;
    WM_IME_KEYUP:
      begin
        //typ := KT_KEYUP;
        //info.sysChar := False;
        //info.imeChar := True;
        form1.mmo1.Lines.Add('WM_IME_KEYDOWN-'+inttostr(integer(Msg.wParam))+'|'+inttostr(integer(Msg.lParam)));
      end;}

    WM_CONTEXTMENU:
      begin   
      flags := 0;
      if (HIWORD(Msg.lParam) and MK_CONTROL)<>0 then
          flags := flags or WKE_CONTROL;
      if (HIWORD(Msg.lParam) and MK_SHIFT)<>0 then
          flags := flags or WKE_SHIFT;
      if (HIWORD(Msg.lParam) and MK_LBUTTON)<>0 then
          flags := flags or WKE_LBUTTON;
      if (HIWORD(Msg.lParam) and MK_MBUTTON)<>0 then
          flags := flags or WKE_MBUTTON;
      if (HIWORD(Msg.lParam) and MK_RBUTTON)<>0 then
          flags := flags or WKE_RBUTTON;
      Handled:=wkeContextMenuEvent(Form1.webView,loword(Msg.lParam),hiword(Msg.lparam),flags);
      //form1.mmo1.Lines.Add('WM_CONTEXTMENU');
      end;

    WM_IME_SETCONTEXT:
      begin
        form1.mmo1.Lines.Add('WM_IME');
      end;

    WM_IME_STARTCOMPOSITION:   //处理 输入法 位置 消息
      begin
        caret:=wkeGetCaret(Form1.webView);
        form.dwIndex := 0;
        form.dwStyle := CFS_EXCLUDE;
        form.ptCurrentPos.x := caret.x;
        form.ptCurrentPos.y := caret.y + caret.h;
        form.rcArea.top := caret.y;
        form.rcArea.bottom := caret.y + caret.h;
        form.rcArea.left := caret.x;
        form.rcArea.right := caret.x + caret.w;
        hIMC := ImmGetContext(form2.Handle);
        ImmSetCandidateWindow(hIMC, @form);
        Handled:=ImmReleaseContext(form2.Handle, hIMC);
        //form1.mmo1.Lines.Add('WM_IME_STARTCOMPOSITION');
      end;

    WM_MOUSEWHEEL:      //滚轮消息
      begin
      flags := 0;
      if (HIWORD(Msg.lParam) and MK_CONTROL)<>0 then
          flags := flags or WKE_CONTROL;
      if (HIWORD(Msg.lParam) and MK_SHIFT)<>0 then
          flags := flags or WKE_SHIFT;
      if (HIWORD(Msg.lParam) and MK_LBUTTON)<>0 then
          flags := flags or WKE_LBUTTON;
      if (HIWORD(Msg.lParam) and MK_MBUTTON)<>0 then
          flags := flags or WKE_MBUTTON;
      if (HIWORD(Msg.lParam) and MK_RBUTTON)<>0 then
          flags := flags or WKE_RBUTTON;

      //GET_WHEEL_DELTA_WPARAM();
      //form1.mmo1.Lines.Add('WMMouseWheel'+inttostr(flags));
      //wkeFocus(Form1.webView);
      if Msg.wParam>0 then
        Handled:=wkeMouseWheel(Form1.webView,loword(Msg.lParam),hiword(Msg.lparam),150,flags)
      else
        Handled:=wkeMouseWheel(Form1.webView,loword(Msg.lParam),hiword(Msg.lparam),-150,flags);
        //with TWMMouseWheel(Pointer(@Msg.message)^) do
          //form1.ChromiumOSR1.Browser.SendMouseWheelEvent(XPos, YPos, WheelDelta, 0);
        //Exit; 
      end
  else
    Handled:= false;
    Exit;
  end;
  //info.key := Msg.wParam;
  //form1.ChromiumOSR1.Browser.SendKeyEvent(typ, info, Msg.lParam);
end;

procedure TForm2.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  flags:LongWord;
begin
//ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble
  flags:=0;
  if ssCtrl in Shift then
    flags:=flags or WKE_CONTROL;

  if ssShift in Shift then
    flags:=flags or WKE_SHIFT;

  if ssLeft in Shift then
    flags:=flags or WKE_LBUTTON;

  if ssMiddle in Shift then
    flags:=flags or WKE_MBUTTON;

  if ssRight in Shift then
    flags:=flags or WKE_RBUTTON;
  if Focused then
  begin
    //Form1.mmo1.Lines.add('GetFocuse');
  end;
  case Button of
    mbLeft:   wkeMouseEvent(Form1.webView, WM_LBUTTONDOWN, X, Y, flags);
    mbRight:  wkeMouseEvent(Form1.webView, WM_RBUTTONDOWN, X, Y, flags);
    mbMiddle: wkeMouseEvent(Form1.webView, WM_MBUTTONDOWN, X, Y, flags);
  end;
end;

procedure TForm2.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  wkeMouseEvent(Form1.webView, WM_MOUSEMOVE,X, Y, 1);
end;

procedure TForm2.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  flags:LongWord;
begin
//ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble
  flags:=0;
  if ssCtrl in Shift then
    flags:=flags or WKE_CONTROL;

  if ssShift in Shift then
    flags:=flags or WKE_SHIFT;

  if ssLeft in Shift then
    flags:=flags or WKE_LBUTTON;

  if ssMiddle in Shift then
    flags:=flags or WKE_MBUTTON;

  if ssRight in Shift then
    flags:=flags or WKE_RBUTTON;
  case Button of                       
    mbLeft:   wkeMouseEvent(Form1.webView, WM_LBUTTONUP, X, Y, flags);
    mbRight:  wkeMouseEvent(Form1.webView, WM_RBUTTONUP,X, Y, flags);
    mbMiddle: wkeMouseEvent(Form1.webView, WM_MBUTTONUP,X, Y, flags);
  end;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  wkeKeyPress(Form1.webView,LongWord(Ord(Key)),1,false);
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  flags:LongWord;
begin
//ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble
  flags:=0;
  if ssCtrl in Shift then
    flags:=flags or WKE_CONTROL;

  if ssShift in Shift then
    flags:=flags or WKE_SHIFT;

  if ssLeft in Shift then
    flags:=flags or WKE_LBUTTON;

  if ssMiddle in Shift then
    flags:=flags or WKE_MBUTTON;

  if ssRight in Shift then
    flags:=flags or WKE_RBUTTON;
  wkeKeyDown(Form1.webView,Key,flags,false);
end;

procedure TForm2.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  flags:LongWord;
begin
//ssShift, ssAlt, ssCtrl, ssLeft, ssRight, ssMiddle, ssDouble
  flags:=0;
  if ssCtrl in Shift then
    flags:=flags or WKE_CONTROL;

  if ssShift in Shift then
    flags:=flags or WKE_SHIFT;

  if ssLeft in Shift then
    flags:=flags or WKE_LBUTTON;

  if ssMiddle in Shift then
    flags:=flags or WKE_MBUTTON;

  if ssRight in Shift then
    flags:=flags or WKE_RBUTTON;
  wkeKeyUp(Form1.webView,Key,flags,false);
end;

end.
