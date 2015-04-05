unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, wke{, sGroupBox};

type    
  TLayoutThread = class(TThread)
  protected
    procedure Execute; override;
  end;  
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    edt1: TEdit;
    tmr1: TTimer;
    btn2: TButton;
    scrlbx1: TScrollBox;
    img1: TImage;
    btn3: TButton;
    tmr2: TTimer;
    edt2: TEdit;
    btn4: TButton;
    btn5: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    CheckBox1: TCheckBox;
    Button7: TButton;
    Edit1: TEdit;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Timer1: TTimer;
    procedure btn1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tti:Integer;
    DocumentNotReady: Boolean;  
    webView: wkeWebView;
    LayoutThread:TLayoutThread;
    s_testCount:integer;
  end;
  
var
  Form1: TForm1;
  canclose:boolean;
  
implementation

uses alphiWindow;

{$R *.dfm}  

procedure   TForm1.WMSysCommand;
begin
  if Msg.CmdType   =   SC_MINIMIZE  then
    Form1.Hide;
  DefaultHandler(Msg);
end;

procedure AlphaUpdateLayeredWindow(Wnd: HWND; Bmp: TBitmap; Alpha: Byte);
var
  P: TPoint;
  R: TRect;
  S: TSize;
  BF: _BLENDFUNCTION;
begin
  GetWindowRect(Wnd, R);
  P := Point(0, 0);
  S.cx := Bmp.Width;
  S.cY := Bmp.Height;
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  bf.SourceConstantAlpha := Alpha;
  bf.AlphaFormat := AC_SRC_ALPHA;
  UpdateLayeredWindow(wnd, 0, @R.TopLeft, @S, Bmp.Canvas.Handle, @P, $FFFFFF, @BF, ULW_ALPHA);
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  url:Putf8;
begin
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  wkeLoadURL(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
  //Sleep(10000);
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
  h,w:Integer;
  //pic:TBitmap;
begin          
  inc(tti);  
  Form1.Caption:=IntToStr(tti);
  wkeUpdate();
  if (wkeIsDocumentReady(webView) and DocumentNotReady) then
  begin
    //wkeRunJS(webView,'document.body.style.overflow=''hidden'';');
    //wkeResize(webView,wkeContentsWidth(webView), wkeContentsHeight(webView));
    mmo1.Lines.Add('wkeIsDocumentReady');
    DocumentNotReady:=False;
  end;

  if wkeIsLoaded(webView) then
  begin
    //wkeRunJS(webView,'document.body.style.overflow = ''hidden'';');
    //wkeResize(webView,wkeContentsWidth(webView), wkeContentsHeight(webView));
    mmo1.Lines.Add('wkeIsLoaded');
  end;

  {if wkeIsLoading(webView) then
  begin
    mmo1.Lines.Add('wkeIsLoading');
  end;}

  if wkeIsLoadComplete(webView) then
  begin                
    tmr1.Enabled:=False;    
    mmo1.Lines.Add('');
    mmo1.Lines.Add('wke Is Load Completed');
    //wkeRunJS(webView,'document.body.style.overflow=''hidden'';');
    h:=wkeHeight(webView);
    w:=wkeWidth(webView);
    //wkeResize(webView, w, h);
    //pic:=wkeGetBitmap(webView,0);        
    mmo1.Lines.Add('W:'+inttostr(w)+' H:'+inttostr(h));
    Form2.Width:=w;
    Form2.Height:=h;
    //img1.Picture.Bitmap:=wkeGetBitmap(webView,0);
    //pic.SaveToFile('test.bmp');
    //pic.Free;
    tti:=0;
    Form1.Caption:=string(wkeTitleW(webView));   
    Form2.Caption:=string(wkeTitleW(webView));
  end;
  if wkeIsLoadFailed(webView) then
  begin
    mmo1.Lines.Add('wke Is Load Failed');
    tmr1.Enabled:=False;
    tti:=0;
    Form1.Caption:='Failed';
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  mmo1.Lines.Add(string(wkeTitleW(webView)));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Set8087CW(Get8087CW or $3F);
  canclose:=false;
  wke_Init();       
  mmo1.Lines.Add(string(wkeVersionString()));
  Button7Click(Sender);
  Button9Click(Sender);
  webView := wkeCreateWebView();
  wkeResize(webView, Screen.Width, Screen.Height);
  if wkeIsTransparent(webView) then
    mmo1.Lines.Add('Is Transparent')
  else
    mmo1.Lines.Add('Is Not Transparent');
  wkeSetTransparent(webView,true); 
  if wkeIsTransparent(webView) then
    mmo1.Lines.Add('Set Transparent ok')
  else
    mmo1.Lines.Add('Set Transparent faled');
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  tmr2.Enabled:=not tmr2.Enabled;
  if tmr2.Enabled then
     btn3.Caption:='AutoGetImg ¡Ì'
  else
     btn3.Caption:='AutoGetImg X ';
  Form2.Show;
  //LayoutThread:=TLayoutThread.Create(False);
end;

procedure TForm1.tmr2Timer(Sender: TObject);
var
  pic:TBitmap;
begin
  {if(wkeIsDirty(webView))then
  begin
    pic:=wkeGetBitmap(webView,0);
    img1.Picture.Bitmap:=pic;
    pic.Free;
  end;}
  //while true do
  //begin
  if(wkeIsDirty(webView))then
  begin
    pic:=wkeGetBitmap(webView,0);
    //img1.Picture.Bitmap:=pic;
    AlphaUpdateLayeredWindow(Form2.Handle, pic, 255);
    pic.Free;
  end;
  //sleep(1);
  //end;
end;

procedure TLayoutThread.Execute;
var
  pic:TBitmap;
begin 
  FreeOnTerminate := True;
  //pic:=TBitmap.Create;
  while True do
  begin
    if wkeIsDirty(Form1.webView) then
    begin
      pic:=wkeGetBitmap(Form1.webView,0);
      //Form1.img1.Picture.Bitmap:=pic;
      AlphaUpdateLayeredWindow(Form2.Handle, pic, 255);
      pic.Free; 
    end;
    Sleep(10);
  end;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  wkeRunJS(webView,PAnsiChar(edt2.text));
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form2.Left:=0;
  Form2.Top:=0;   
  form2.Width:=1024;
  form2.Height:=1024;
  SetWindowLong(Form2.Handle, GWL_EXSTYLE, GetWindowLong(Form2.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  tmr2.Enabled:=not tmr2.Enabled;
  if tmr2.Enabled then
     btn3.Caption:='AutoGetImg ¡Ì'
  else
     btn3.Caption:='AutoGetImg X ';
  Form2.Show;
end;

procedure TForm1.btn5Click(Sender: TObject);
var
  pic:TBitmap;
begin
  {if(wkeIsDirty(webView))then
  begin
    pic:=wkeGetBitmap(webView,0);
    img1.Picture.Bitmap:=pic;
    pic.Free;
  end;}
  //if (wkeIsDirty(webView)) then
  //begin
    pic:=wkeGetBitmap(webView,0);
    pic.SaveToFile('test.bmp');
    img1.Picture.Bitmap:=pic;
    //AlphaUpdateLayeredWindow(Form2.Handle, pic, 255);
    pic.Free;   
  //end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  url:Putf8;
begin
  //edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/index.html';
  edt1.Text:='www/index.html';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  url:Putf8;
begin
  //edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/flash.html';
  edt1.Text:='www/flash.html';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  url:Putf8;
begin
  //edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/2048-master/index.html';
  edt1.Text:='www/2048-master/index.html';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  url:Putf8;
begin
  //edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/Ball Pool.htm';
  edt1.Text:='www/Ball Pool.htm';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  url:Putf8;
begin
  //edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/card.html';
  edt1.Text:='www/card.html';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  url:Putf8;
begin
  edt1.Text:='file:///'+ExtractFileDir(Application.Exename)+'/www/CSS Bubbles.html';
  edt1.Text:='www/CSS Bubbles.html';
  url:=Putf8(edt1.Text);
  mmo1.Lines.Add('Load:'+edt1.Text);
  //wkeLoadURL(webView,url);
  wkeLoadFile(webView,url);
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  wkeSetEditable(webView,CheckBox1.Checked);
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  jsRet:jsValue;
begin
  jsRet:=wkeRunJS(webView,PAnsiChar(edit1.text));
  mmo1.Lines.Add('jsRun:'+string(jsToStringW(wkeGlobalExec(webView),jsRet)));
end;          

function js_getTestCount(es:jsExecState):jsValue;
begin
    result:=jsInt(form1.s_testCount);
end;

function js_setTestCount(es:jsExecState):jsValue;
begin
  form1.s_testCount := jsToInt(es, jsArg(es, 0));
  form1.mmo1.Lines.Add('js_setTestCount:'+inttostr(form1.s_testCount));
  result:=jsUndefined();
end;

function js_malert(es:jsExecState):jsValue;//cdecl;
var
  str:Putf8;
begin
  str:=jsToString(es, jsArg(es, 0));
  if(jsIsString(jsArg(es, 0))) then
    Form1.mmo1.Lines.Add('malert:jsIsString');
  if(jsIsUndefined(jsArg(es, 0))) then
    Form1.mmo1.Lines.Add('malert:jsIsUndefined');
  Form1.mmo1.Lines.Add('malert:'+string(str)+'('+inttostr(jsArgCount(es))+')');
  result:=jsUndefined();
end;   

procedure TForm1.Button7Click(Sender: TObject);
begin
  jsBindFunction(Pchar('malert'), @js_malert,1);
  Button7.Enabled:=false;
  jsBindGetter('testCount', @js_getTestCount);
  jsBindSetter('testCount', @js_setTestCount);
  //FreeMem(p);
end;

function js_nalert(es:jsExecState):jsValue;//cdecl;
begin
  Form1.mmo1.Lines.Add('nalert:ok('+inttostr(jsArgCount(es))+')');
  result:=jsUndefined();
  if canclose then
    Application.Terminate;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  jsBindFunction(Pchar('nalert'), @js_nalert,0);
  Button9.Enabled:=false;
  //FreeMem(p);
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Timer1.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  form1.Hide;
  wkeLoadFile(webView,'www/MAC/mac-osx-lion.html');
  tmr1.Enabled:=True;
  DocumentNotReady:=True;
  form1.Left:=-100;
  Form1.Width:=0;
  Form1.Height:=0;
  canclose:=true;
  Timer1.Enabled:=false;
end;

end.
