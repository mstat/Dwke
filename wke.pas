unit wke;

interface

uses
  Windows, Graphics;

type
  wkeWebView = Pointer;
  jsExecState = Pointer;
  wkeString = Pointer;
  utf8 = Char;
  Putf8 = PChar;
  PWutf8 = PWChar;
  jsValue = Int64;
  jsType = ( JSTYPE_NUMBER,
             JSTYPE_STRING,
	           JSTYPE_BOOLEAN,
	           JSTYPE_OBJECT,
             JSTYPE_FUNCTION,
             JSTYPE_UNDEFINED);
  
  _wkeClientHandler = record
    onTitleChanged: Pointer; //ON_TITLE_CHANGED
    onURLChanged: Pointer;   //ON_URL_CHANGED
  end;
  PwkeClientHandler=^_wkeClientHandler;
  
  ON_TITLE_CHANGED = procedure(clientHandler: PwkeClientHandler;title: wkeString);
  ON_URL_CHANGED   = procedure(clientHandler: PwkeClientHandler;url: wkeString );
  jsNativeFunction = function(es:jsExecState):jsValue;

  wkeRect = record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;
  
  
  {TwkeClientHandler = record
    name:string;
    id:string;
  end;}

  procedure wke_Init();
  function  wkeIsTransparent(browser: wkeWebView):Boolean; stdcall; cdecl;
  procedure wkeSetTransparent(browser: wkeWebView;transparent: Boolean); stdcall; cdecl;
  function  wkeGetBitmap(const browser: wkeWebView; typ: Integer): TBitmap;
  procedure wkeInit(); stdcall; cdecl;
  function  wkeCreateWebView(): wkeWebView; stdcall; cdecl;
  procedure wkeResize(webView: wkeWebView;w,h: Integer); stdcall; cdecl;
  procedure wkeLoadURL(webView: wkeWebView;url: Putf8); stdcall; cdecl;
  procedure wkeUpdate(); stdcall; cdecl;
  function  wkeVersionString():Putf8; stdcall; cdecl;
  function  wkeIsLoaded(webView: wkeWebView):Boolean; stdcall; cdecl;
  //function  wkeIsLoading(webView: wkeWebView):Boolean; cdecl;
  function  wkeIsDocumentReady(webView: wkeWebView):Boolean; stdcall; cdecl;
  function  wkeIsLoadComplete(webView: wkeWebView):Boolean; stdcall; cdecl;
  function  wkeIsLoadFailed(webView: wkeWebView):Boolean; stdcall; cdecl;
  function  wkeRunJS(webView: wkeWebView;script: Putf8):Boolean; stdcall; cdecl;
  function  wkeRunJSW(webView: wkeWebView;script: PWutf8):Boolean; stdcall; cdecl;
  function  wkeContentsWidth(webView: wkeWebView):Integer; stdcall; cdecl;
  function  wkeContentsHeight(webView: wkeWebView):Integer; stdcall; cdecl;
  function  wkeWidth(webView: wkeWebView):Integer; stdcall; cdecl;
  function  wkeHeight(webView: wkeWebView):Integer; stdcall; cdecl;
  function  wkeTitleW(webView: wkeWebView):PWutf8; stdcall; cdecl;
  procedure wkePaint(wkeWebView: wkeWebView; bits: Pointer;pitch: Integer); stdcall; cdecl;
  function  wkeIsDirty(webView: wkeWebView):Boolean; stdcall; cdecl;
  procedure wkeFocus(webView: wkeWebView); stdcall; cdecl;
  procedure wkeUnfocus(webView: wkeWebView); stdcall; cdecl;
  //procedure wkeSetClientHandler(webView:wkeWebView, handler:wkeClientHandler); cdecl;
  {
WKE_API bool wkeMouseEvent(wkeWebView webView, unsigned int message, int x, int y, unsigned int flags);
WKE_API bool wkeContextMenuEvent(wkeWebView webView, int x, int y, unsigned int flags);
WKE_API bool wkeMouseWheel(wkeWebView webView, int x, int y, int delta, unsigned int flags);
WKE_API bool wkeKeyUp(wkeWebView webView, unsigned int virtualKeyCode, unsigned int flags, bool systemKey);
WKE_API bool wkeKeyDown(wkeWebView webView, unsigned int virtualKeyCode, unsigned int flags, bool systemKey);
WKE_API bool wkeKeyPress(wkeWebView webView, unsigned int charCode, unsigned int flags, bool systemKey);
  }

  {
  PCefKeyInfo = ^TCefKeyInfo;
  TCefKeyInfo = record
    key: Integer;
    sysChar: BOOL;
    imeChar: BOOL;
  end;
  }
  function  wkeMouseEvent(webView: wkeWebView;msg: Integer; x,y:Integer;flags: LongWord):Boolean; stdcall; cdecl;
  function  wkeContextMenuEvent(webView: wkeWebView;x,y:Integer;flags: LongWord):Boolean; stdcall; cdecl;
  function  wkeMouseWheel(webView: wkeWebView;x,y:Integer;msg: Integer; flags: LongWord):Boolean; stdcall; cdecl;

  function  wkeKeyUp   (webView: wkeWebView;virtualKeyCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl;
  function  wkeKeyDown (webView: wkeWebView;virtualKeyCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl;
  function  wkeKeyPress(webView: wkeWebView;      charCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl;

  function  wkeGetCaret(webView: wkeWebView):wkeRect; stdcall; cdecl;
  procedure wkeSetEditable(webView: wkeWebView; editable:Boolean); stdcall; cdecl;

  function  wkeGlobalExec(webView: wkeWebView):jsExecState; stdcall; cdecl;
  function  wkeToString(str : wkeString):Putf8; stdcall; cdecl;

  procedure jsBindFunction(name:Pchar; fn:jsNativeFunction; argCount:Word); stdcall; cdecl;
  procedure jsBindGetter(name:Pchar; fn:jsNativeFunction); stdcall; cdecl;
  procedure jsBindSetter(name:Pchar; fn:jsNativeFunction); stdcall; cdecl;
  function  jsArgCount(es:jsExecState):Integer; stdcall; cdecl;
  function  jsArgType(es:jsExecState; argIdx:integer):jsType; stdcall; cdecl;
  function  jsArg(es:jsExecState;argIdx:Integer):jsValue; stdcall; cdecl;

  function jsTypeOf(v:jsValue):jsType; stdcall; cdecl;
  function jsIsNumber(v:jsValue):boolean; stdcall; cdecl;
  function jsIsString(v:jsValue):boolean; stdcall; cdecl;
  function jsIsBoolean(v:jsValue):boolean; stdcall; cdecl;
  function jsIsObject(v:jsValue):boolean; stdcall; cdecl;
  function jsIsFunction(v:jsValue):boolean; stdcall; cdecl;
  function jsIsUndefined(v:jsValue):boolean; stdcall; cdecl;
  function jsIsNull(v:jsValue):boolean; stdcall; cdecl;
  function jsIsArray(v:jsValue):boolean; stdcall; cdecl;
  function jsIsTrue(v:jsValue):boolean; stdcall; cdecl;
  function jsIsFalse(v:jsValue):boolean; stdcall; cdecl;


var
  MBT_LEFT   :LongWord = 0;
  MBT_MIDDLE :LongWord = 1;
  MBT_RIGHT  :LongWord = 2;
  WKE_LBUTTON :LongWord= $01;
  WKE_RBUTTON :LongWord= $02;
  WKE_SHIFT   :LongWord= $04;
  WKE_CONTROL :LongWord= $08;
  WKE_MBUTTON :LongWord= $10;
  WKE_EXTENDED :LongWord= $0100;
  WKE_REPEAT :LongWord= $000;
  
implementation
  procedure wkeInit; external 'wke.dll';
  function  wkeIsTransparent; external 'wke.dll';
  procedure wkeSetTransparent; external 'wke.dll';
  function  wkeCreateWebView; external 'wke.dll';
  procedure wkeResize; external 'wke.dll';
  procedure wkeLoadURL; external 'wke.dll';
  procedure wkeUpdate; external 'wke.dll';
  function  wkeVersionString; external 'wke.dll';
  function  wkeIsLoaded; external 'wke.dll';         
  //function  wkeIsLoading; external 'wke.dll';
  function  wkeIsDocumentReady; external 'wke.dll';
  function  wkeIsLoadComplete; external 'wke.dll';
  function  wkeIsLoadFailed; external 'wke.dll';
  function  wkeRunJS; external 'wke.dll';    
  function  wkeRunJSW; external 'wke.dll';
  function  wkeContentsWidth; external 'wke.dll';
  function  wkeContentsHeight; external 'wke.dll';      
  function  wkeWidth; external 'wke.dll';
  function  wkeHeight; external 'wke.dll';
  function  wkeTitleW; external 'wke.dll';
  procedure wkePaint; external 'wke.dll';
  function  wkeIsDirty; external 'wke.dll';
  procedure wkeFocus; external 'wke.dll';
  procedure wkeUnfocus; external 'wke.dll'; 
  function  wkeMouseEvent; external 'wke.dll';
  function  wkeContextMenuEvent; external 'wke.dll';
  function  wkeMouseWheel; external 'wke.dll';
  function  wkeKeyUp; external 'wke.dll';
  function  wkeKeyDown; external 'wke.dll';
  function  wkeKeyPress; external 'wke.dll';
  function  wkeGetCaret; external 'wke.dll';
  procedure wkeSetEditable; external 'wke.dll';
  function  wkeGlobalExec; external 'wke.dll';
  function  wkeToString; external 'wke.dll';
  procedure jsBindFunction; external 'wke.dll';
  procedure jsBindGetter; external 'wke.dll';
  procedure jsBindSetter; external 'wke.dll';
  function  jsArgCount; external 'wke.dll';
  function  jsArgType; external 'wke.dll';
  function  jsTypeOf; external 'wke.dll';
  function  jsArg; external 'wke.dll';
  function  jsIsNumber; external 'wke.dll';
  function  jsIsString; external 'wke.dll';
  function  jsIsBoolean; external 'wke.dll';
  function  jsIsObject; external 'wke.dll';
  function  jsIsFunction; external 'wke.dll';
  function  jsIsUndefined; external 'wke.dll';
  function  jsIsNull; external 'wke.dll';
  function  jsIsArray; external 'wke.dll';
  function  jsIsTrue; external 'wke.dll';
  function  jsIsFalse; external 'wke.dll';

  procedure wke_Init();
  begin
    Set8087CW(Get8087CW or $3F);
    wkeInit();
  end;

function wkeGetBitmap(const browser: wkeWebView; typ: Integer): TBitmap;
var
  w, h, i: Integer;
  p, s: Pointer;
  Bitmap: TBitmap;
begin
  h:=wkeHeight(browser);
  w:=wkeWidth(browser);
  {if((wkeW<>w) or (wkeH<>h)) then
  begin
    wkeW:=w;
    wkeH:=h;
    wkeResize(browser, w, h);
  end;}
  //wkeResize(browser, w, h);
  //h:=wkeContentsHeight(browser);
  //w:=wkeContentsWidth(browser);
  Bitmap:=TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;
  Bitmap.Width := w;
  Bitmap.Height := h;
  GetMem(p, h * w * 4);
  try
    //browser.GetImage(typ, w, h, p);
    wkePaint(browser, p, typ);
    s := p;
    for i :=0 to h - 1 do
    begin
      Move(s^, Bitmap.ScanLine[i]^, w*4);
      Inc(Integer(s), w*4);
    end;
    result:=Bitmap;
  finally
    FreeMem(p);
  end;
end;


end.