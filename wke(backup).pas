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
  wkeuint = ^Word;
  wkeint = ^integer;
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

  wkeRect = record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
  end;

  ON_TITLE_CHANGED = procedure(clientHandler: PwkeClientHandler;title: wkeString); cdecl;
  ON_URL_CHANGED   = procedure(clientHandler: PwkeClientHandler;url: wkeString ); cdecl;
  //jsNativeFunction = function(es:jsExecState):jsValue of Object;
  //PjsNativeFunction = ^jsNativeFunction;
  jsNativeFunction = Pointer;
  
  {TwkeClientHandler = record
    name:string;
    id:string;
  end;}

  procedure wke_Init();
  function  wkeIsTransparent(browser: wkeWebView):Boolean;  cdecl; external 'wke.dll';//  name 'wkeIsTransparent';
  procedure wkeSetTransparent(browser: wkeWebView;transparent: Boolean);  cdecl; external 'wke.dll';  //name 'wkeSetTransparent';
  function  wkeGetBitmap(browser: wkeWebView; typ: Integer): TBitmap; 
  procedure wkeInit();  cdecl; external 'wke.dll';  //name 'wkeInit';
  function  wkeCreateWebView(): wkeWebView;  cdecl; external 'wke.dll';  //name 'wkeCreateWebView';
  procedure wkeResize(webView: wkeWebView;w,h: Integer);  cdecl; external 'wke.dll';  //name 'wkeResize';
  procedure wkeLoadURL(webView: wkeWebView;url: Putf8); cdecl; external 'wke.dll';  //name 'wkeLoadURL';
  procedure wkeLoadURLW(webView: wkeWebView;url: PWutf8); cdecl; external 'wke.dll';  //name 'wkeLoadURL';
  procedure wkeUpdate(); cdecl; external 'wke.dll';  //name 'wkeUpdate';
  function  wkeVersionString():Putf8; cdecl; external 'wke.dll';  //name 'wkeVersionString';
  function  wkeIsLoaded(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsLoaded';
  //function  wkeIsLoading(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsLoading';
  function  wkeIsDocumentReady(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsDocumentReady';
  function  wkeIsLoadComplete(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsLoadComplete';
  function  wkeIsLoadFailed(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsLoadFailed';
  function  wkeRunJS(webView: wkeWebView;script: Putf8):Boolean; cdecl; external 'wke.dll';  //name 'wkeRunJS';
  function  wkeRunJSW(webView: wkeWebView;script: PWutf8):Boolean; cdecl; external 'wke.dll';  //name 'wkeRunJSW';
  function  wkeContentsWidth(webView: wkeWebView):Integer; cdecl; external 'wke.dll';  //name 'wkeContentsWidth';
  function  wkeContentsHeight(webView: wkeWebView):Integer; cdecl; external 'wke.dll';  //name 'wkeContentsHeight';
  function  wkeWidth(webView: wkeWebView):Integer; cdecl; external 'wke.dll';  //name 'wkeWidth';
  function  wkeHeight(webView: wkeWebView):Integer; cdecl; external 'wke.dll';  //name 'wkeHeight';
  function  wkeTitleW(webView: wkeWebView):PWutf8; cdecl; external 'wke.dll';  //name 'wkeTitleW';
  procedure wkePaint(wkeWebView: wkeWebView; bits: Pointer;pitch: Integer); cdecl; external 'wke.dll';  //name 'wkePaint';
  function  wkeIsDirty(webView: wkeWebView):Boolean; cdecl; external 'wke.dll';  //name 'wkeIsDirty';
  procedure wkeFocus(webView: wkeWebView); cdecl; external 'wke.dll';  //name 'wkeFocus';
  procedure wkeUnfocus(webView: wkeWebView); cdecl; external 'wke.dll';  //name 'wkeUnfocus';
  //procedure wkeSetClientHandler(webView:wkeWebView, handler:wkeClientHandler); cdecl; external 'wke.dll';  //name 'wkeSetClientHandler';
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
  function  wkeMouseEvent(webView: wkeWebView;msg: Integer; x,y:Integer;flags: LongWord):Boolean; cdecl; external 'wke.dll';  //name 'wkeMouseEvent';
  function  wkeContextMenuEvent(webView: wkeWebView;x,y:Integer;flags: LongWord):Boolean; cdecl; external 'wke.dll';  //name 'wkeContextMenuEvent';
  function  wkeMouseWheel(webView: wkeWebView;x,y:Integer;msg: Integer; flags: LongWord):Boolean; cdecl; external 'wke.dll';  //name 'wkeMouseWheel';

  function  wkeKeyUp   (webView: wkeWebView;virtualKeyCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl; external 'wke.dll';  //name 'wkeKeyUp';
  function  wkeKeyDown (webView: wkeWebView;virtualKeyCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl; external 'wke.dll';  //name 'wkeKeyDown';
  function  wkeKeyPress(webView: wkeWebView;      charCode: Word;flags: Word;systemKey: Boolean):Boolean;  cdecl; external 'wke.dll';  //name 'wkeKeyPress';

  function  wkeGetCaret(webView: wkeWebView):wkeRect; cdecl; external 'wke.dll';  //name 'wkeGetCaret';
  procedure wkeSetEditable(webView: wkeWebView; editable:Boolean); cdecl; external 'wke.dll';  //name 'wkeSetEditable';

  function  wkeGlobalExec(webView: wkeWebView):jsExecState; cdecl; external 'wke.dll';  //name 'wkeGlobalExec';
  function  wkeToString(str : wkeString):Putf8; cdecl; external 'wke.dll';  //name 'wkeToString';

  procedure jsBindFunction(const name:PAnsiChar; fn:jsNativeFunction; argCount:Word); cdecl; external 'wke.dll';  //name 'jsBindFunction';
  procedure jsBindGetter(const name:PAnsiChar; fn:jsNativeFunction); cdecl; external 'wke.dll';  //name 'jsBindGetter';
  procedure jsBindSetter(const name:PAnsiChar; fn:jsNativeFunction); cdecl; external 'wke.dll';  //name 'jsBindSetter';
  function  jsArgCount(es:jsExecState):Byte; cdecl; external 'wke.dll';  //name 'jsArgCount';
  function  jsArgType(es:jsExecState; argIdx:Integer):jsType; cdecl; external 'wke.dll';  //name 'jsArgType';
  function  jsArg(es:jsExecState;argIdx:Integer):jsValue; cdecl; external 'wke.dll';  //name 'jsArg';

  function jsTypeOf(v:jsValue):jsType; cdecl; external 'wke.dll';  //name 'jsTypeOf';
  function jsIsNumber(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsNumber';
  function jsIsString(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsString';
  function jsIsBoolean(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsBoolean';
  function jsIsObject(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsObject';
  function jsIsFunction(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsFunction';
  function jsIsUndefined(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsUndefined';
  function jsIsNull(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsNull';
  function jsIsArray(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsArray';
  function jsIsTrue(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsTrue';
  function jsIsFalse(v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsIsFalse';

  function jsToInt(es:jsExecState; v:jsValue):integer; cdecl; external 'wke.dll';  //name 'jsToInt';
  function jsToFloat(es:jsExecState; v:jsValue):Single; cdecl; external 'wke.dll';  //name 'jsToFloat';
  function jsToDouble(es:jsExecState; v:jsValue):Double; cdecl; external 'wke.dll';  //name 'jsToDouble';
  function jsToBoolean(es:jsExecState; v:jsValue):boolean; cdecl; external 'wke.dll';  //name 'jsToBoolean';
  function jsToString(es:jsExecState; v:jsValue):Putf8; cdecl; external 'wke.dll';  //name 'jsToString';
  function jsToStringW(es:jsExecState; v:jsValue):PWutf8; cdecl; external 'wke.dll';  //name 'jsToStringW';

  function jsInt(n:integer):jsValue; cdecl; external 'wke.dll';  //name 'jsInt';
  function jsFloat(f:Single):jsValue; cdecl; external 'wke.dll';  //name 'jsFloat';
  function jsDouble(d:Double):jsValue; cdecl; external 'wke.dll';  //name 'jsDouble';
  function jsBoolean(b:boolean):jsValue; cdecl; external 'wke.dll';  //name 'jsBoolean';

  function jsUndefined():jsValue; cdecl; external 'wke.dll';  //name 'jsUndefined';
  function jsNull():jsValue; cdecl; external 'wke.dll';  //name 'jsNull';
  function jsTrue():jsValue; cdecl; external 'wke.dll';  //name 'jsTrue';
  function jsFalse():jsValue; cdecl; external 'wke.dll';  //name 'jsFalse';

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
  {procedure wkeInit; external 'wke.dll';
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
  function  jsToInt; external 'wke.dll';
  function  jsToFloat; external 'wke.dll';
  function  jsToDouble; external 'wke.dll';
  function  jsToBoolean; external 'wke.dll';
  function  jsToString; external 'wke.dll';
  function  jsInt; external 'wke.dll';
  function  jsFloat; external 'wke.dll';
  function  jsDouble; external 'wke.dll';
  function  jsBoolean; external 'wke.dll';
  function  jsUndefined; external 'wke.dll';
  function  jsNull; external 'wke.dll';
  function  jsTrue; external 'wke.dll';
  function  jsFalse; external 'wke.dll';
  function  jsToStringW; external 'wke.dll';}

  procedure wke_Init();
  begin
    Set8087CW(Get8087CW or $3F);
    wkeInit();
  end;

function wkeGetBitmap(browser: wkeWebView; typ: Integer): TBitmap;
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