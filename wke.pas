unit wke;

interface

uses
  Windows, Graphics, Dialogs;

type
  wkeWebView = Pointer;
  jsExecState = Pointer;
  wkeString = Pointer;
  utf8 = Char;
  Putf8 = PChar;
  PWutf8 = PWChar;
  jsValue = Int64;//UInt64;//
  PjsValue = ^Int64;//UInt64;//
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
  jsNativeFunction = function(es:jsExecState):jsValue; cdecl;
  PjsNativeFunction = ^jsNativeFunction;
  //jsNativeFunction = Pointer;
  
  {TwkeClientHandler = record
    name:string;
    id:string;
  end;}
 
  TwkeIsTransparent = function(browser: wkeWebView):Boolean;cdecl;
  TwkeSetTransparent = procedure(browser: wkeWebView;transparent: Boolean);cdecl;
  TwkeInit = procedure();cdecl;
  TwkeCreateWebView = function(): wkeWebView;cdecl;
  TwkeResize = procedure(webView: wkeWebView;w,h: Integer);cdecl;

  TwkeLoadURL = procedure(webView: wkeWebView;const url: Putf8);cdecl;
  TwkeLoadURLW = procedure(webView: wkeWebView;const url: PWutf8);cdecl;

  TwkeLoadHTML = procedure(webView: wkeWebView;const html: Putf8);cdecl;
  TwkeLoadHTMLW = procedure(webView: wkeWebView;const html: PWutf8);cdecl;

  TwkeLoadFile = procedure(webView: wkeWebView;const filename: Putf8);cdecl;
  TwkeLoadFileW = procedure(webView: wkeWebView;const filename: PWutf8);cdecl;

  TwkeUpdate = procedure();cdecl;
  TwkeVersionString = function():Putf8;cdecl;
  TwkeIsLoaded = function(webView: wkeWebView):Boolean;cdecl;
  // = functionwkeIsLoading(webView: wkeWebView):Boolean;cdecl;
  TwkeIsDocumentReady = function(webView: wkeWebView):Boolean;cdecl;
  TwkeIsLoadComplete = function(webView: wkeWebView):Boolean;cdecl;
  TwkeIsLoadFailed = function(webView: wkeWebView):Boolean;cdecl;
  TwkeRunJS = function(webView: wkeWebView;script: Putf8):jsValue;cdecl;
  TwkeRunJSW = function(webView: wkeWebView;script: PWutf8):jsValue;cdecl;
  TwkeContentsWidth = function(webView: wkeWebView):Integer;cdecl;
  TwkeContentsHeight = function(webView: wkeWebView):Integer;cdecl;
  TwkeWidth = function(webView: wkeWebView):Integer;cdecl;
  TwkeHeight = function(webView: wkeWebView):Integer;cdecl;
  TwkeTitleW = function(webView: wkeWebView):PWutf8;cdecl;
  TwkePaint = procedure(wkeWebView: wkeWebView;bits: Pointer;pitch: Integer);cdecl;
  TwkeIsDirty = function(webView: wkeWebView):Boolean;cdecl;
  TwkeFocus = procedure(webView: wkeWebView);cdecl;
  TwkeUnfocus = procedure(webView: wkeWebView);cdecl;
  
  TwkeMouseEvent = function(webView: wkeWebView;msg: LongWord;x,y:Integer;flags: LongWord):Boolean;cdecl;
  TwkeContextMenuEvent = function(webView: wkeWebView;x,y:Integer;flags: LongWord):Boolean;cdecl;
  TwkeMouseWheel = function(webView: wkeWebView;x,y:Integer;msg: Integer;flags: LongWord):Boolean;cdecl;

  TwkeKeyUp = function(webView: wkeWebView;virtualKeyCode: LongWord;flags: Word;systemKey: Boolean):Boolean;cdecl;
  TwkeKeyDown = function(webView: wkeWebView;virtualKeyCode: LongWord;flags: Word;systemKey: Boolean):Boolean;cdecl;
  TwkeKeyPress = function(webView: wkeWebView;charCode: LongWord;flags: Word;systemKey: Boolean):Boolean;cdecl;

  TwkeGetCaret = function(webView: wkeWebView):wkeRect;cdecl;
  TwkeSetEditable = procedure(webView: wkeWebView;editable:Boolean);cdecl;

  TwkeGlobalExec = function(webView: wkeWebView):jsExecState;cdecl;
  TwkeToString = function(str : wkeString):Putf8;cdecl;

  TjsBindFunction = procedure(const name:PAnsiChar;fn:jsNativeFunction;argCount:Cardinal);cdecl;
  TjsBindGetter = procedure(const name:PAnsiChar;fn:jsNativeFunction);cdecl;
  TjsBindSetter = procedure(const name:PAnsiChar;fn:jsNativeFunction);cdecl;
  TjsArgCount = function(es:jsExecState):Integer;cdecl;
  TjsArgType = function(es:jsExecState;argIdx:Integer):jsType;cdecl;
  TjsArg = function(es:jsExecState;argIdx:Integer):jsValue;cdecl;

  TjsTypeOf = function(v:jsValue):jsType;cdecl;
  TjsIsNumber = function(v:jsValue):boolean;cdecl;
  TjsIsString = function(v:jsValue):boolean;cdecl;
  TjsIsBoolean = function(v:jsValue):boolean;cdecl;
  TjsIsObject = function(v:jsValue):boolean;cdecl;
  TjsIsfunction= function(v:jsValue):boolean;cdecl;
  TjsIsUndefined = function(v:jsValue):boolean;cdecl;
  TjsIsNull = function(v:jsValue):boolean;cdecl;
  TjsIsArray = function(v:jsValue):boolean;cdecl;
  TjsIsTrue = function(v:jsValue):boolean;cdecl;
  TjsIsFalse = function(v:jsValue):boolean;cdecl;

  TjsToInt = function(es:jsExecState;v:jsValue):integer;cdecl;
  TjsToFloat = function(es:jsExecState;v:jsValue):Single;cdecl;
  TjsToDouble = function(es:jsExecState;v:jsValue):Double;cdecl;
  TjsToBoolean = function(es:jsExecState;v:jsValue):boolean;cdecl;
  TjsToString = function(es:jsExecState;v:jsValue):Putf8;cdecl;
  TjsToStringW = function(es:jsExecState;v:jsValue):PWutf8;cdecl;

  TjsInt = function(n:integer):jsValue;cdecl;
  TjsFloat = function(f:Single):jsValue;cdecl;
  TjsDouble = function(d:Double):jsValue;cdecl;
  TjsBoolean = function(b:boolean):jsValue;cdecl;

  TjsUndefined = function():jsValue;cdecl;
  TjsNull = function():jsValue;cdecl;
  TjsTrue = function():jsValue;cdecl;
  TjsFalse = function():jsValue;cdecl;
  
  TjsString = function(es:jsExecState;const str:Putf8):jsValue;
  TjsStringW = function(es:jsExecState;const str:PWutf8):jsValue;
  Tjsjsobject = function(es:jsExecState):jsValue;
  TjsArray = function(es:jsExecState):jsValue;

  TjsFunction = function(es:jsExecState;fn:jsNativeFunction;argCount:Cardinal):jsValue;

//return the window object
  TjsGlobalobject = function(es:jsExecState):jsValue;

  TjsEval = function(es:jsExecState;const str:Putf8):jsValue;
  TjsEvalW = function(es:jsExecState;const str:PWutf8):jsValue;

  TjsCall = function(es:jsExecState;func:jsValue;thisjsobject:jsValue;args:PjsValue;argCount:Integer):jsValue;
  TjsCallGlobal = function(es:jsExecState;func:jsValue;args:PjsValue;argCount:Integer):jsValue;

  TjsGet = function(es:jsExecState;jsobject:jsValue;const prop:Putf8):jsValue;
  TjsSet = procedure(es:jsExecState;jsobject:jsValue;const prop:Putf8;v:jsValue);

  TjsGetGlobal = function(es:jsExecState;const prop:Putf8):jsValue;
  TjsSetGlobal = procedure(es:jsExecState;const prop:Putf8;v:jsValue);

  TjsGetAt = function(es:jsExecState;jsobject:jsValue;index:Integer):jsValue;
  TjsSetAt = procedure(es:jsExecState;jsobject:jsValue;index:Integer;v:jsValue);

  TjsGetLength = function(es:jsExecState;jsobject:jsValue):Integer;
  TjsSetLength = procedure(es:jsExecState;jsobject:jsValue;length:integer);

  TjsGetWebView = function(es:jsExecState):wkeWebView;

  TjsGC = procedure();//garbage collect
  
  
  procedure wke_Init();
  function  wkeGetBitmap(browser: wkeWebView; typ: Integer): TBitmap; 
  

var
  //wkeDllHandle: THandle;
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
  
  wkeIsTransparent: TwkeIsTransparent;
  wkeSetTransparent: TwkeSetTransparent;
  wkeInit: TwkeInit;
  wkeCreateWebView: TwkeCreateWebView;
  wkeResize: TwkeResize;

  wkeLoadURL: TwkeLoadURL;
  wkeLoadURLW: TwkeLoadURLW;

  wkeLoadHTML: TwkeLoadHTML;
  wkeLoadHTMLW: TwkeLoadHTMLW;

  wkeLoadFile: TwkeLoadFile;
  wkeLoadFileW: TwkeLoadFileW;

  wkeUpdate: TwkeUpdate;
  wkeVersionString: TwkeVersionString;
  wkeIsLoaded: TwkeIsLoaded;
  
  wkeIsDocumentReady: TwkeIsDocumentReady;
  wkeIsLoadComplete: TwkeIsLoadComplete;
  wkeIsLoadFailed: TwkeIsLoadFailed;
  wkeRunJS: TwkeRunJS;
  wkeRunJSW: TwkeRunJSW;
  wkeContentsWidth: TwkeContentsWidth;
  wkeContentsHeight: TwkeContentsHeight;
  wkeWidth: TwkeWidth;
  wkeHeight: TwkeHeight;
  wkeTitleW: TwkeTitleW;
  wkePaint: TwkePaint;
  wkeIsDirty: TwkeIsDirty;
  wkeFocus: TwkeFocus;
  wkeUnfocus: TwkeUnfocus;
  
  wkeMouseEvent: TwkeMouseEvent;
  wkeContextMenuEvent: TwkeContextMenuEvent;
  wkeMouseWheel: TwkeMouseWheel;

  wkeKeyUp: TwkeKeyUp;
  wkeKeyDown: TwkeKeyDown;
  wkeKeyPress: TwkeKeyPress;

  wkeGetCaret: TwkeGetCaret;
  wkeSetEditable: TwkeSetEditable;

  wkeGlobalExec: TwkeGlobalExec;
  wkeToString: TwkeToString;

  jsBindFunction: TjsBindFunction;
  jsBindGetter: TjsBindGetter;
  jsBindSetter: TjsBindSetter;
  jsArgCount: TjsArgCount;
  jsArgType: TjsArgType;
  jsArg: TjsArg;

  jsTypeOf: TjsTypeOf;
  jsIsNumber: TjsIsNumber;
  jsIsString: TjsIsString;
  jsIsBoolean: TjsIsBoolean;
  jsIsObject: TjsIsObject;
  jsIsfunction: TjsIsfunction;
  jsIsUndefined: TjsIsUndefined;
  jsIsNull: TjsIsNull;
  jsIsArray: TjsIsArray;
  jsIsTrue: TjsIsTrue;
  jsIsFalse: TjsIsFalse;

  jsToInt: TjsToInt;
  jsToFloat: TjsToFloat;
  jsToDouble: TjsToDouble;
  jsToBoolean: TjsToBoolean;
  jsToString: TjsToString;
  jsToStringW: TjsToStringW;

  jsInt: TjsInt;
  jsFloat: TjsFloat;
  jsDouble: TjsDouble;
  jsBoolean: TjsBoolean;

  jsUndefined: TjsUndefined;
  jsNull: TjsNull;
  jsTrue: TjsTrue;
  jsFalse: TjsFalse;
  
  jsString: TjsString;
  jsStringW: TjsStringW;
  jsjsobject: Tjsjsobject;
  jsArray: TjsArray;

  jsFunction: TjsFunction;

//return the window object
  jsGlobalobject: TjsGlobalobject;

  jsEval: TjsEval;
  jsEvalW: TjsEvalW;

  jsCall: TjsCall;
  jsCallGlobal: TjsCallGlobal;

  jsGet: TjsGet;
  jsSet: TjsSet;

  jsGetGlobal: TjsGetGlobal;
  jsSetGlobal: TjsSetGlobal;

  jsGetAt: TjsGetAt;
  jsSetAt: TjsSetAt;

  jsGetLength: TjsGetLength;
  jsSetLength: TjsSetLength;

  jsGetWebView: TjsGetWebView;

  jsGC: TjsGC;
  
implementation

function LoadDllFunc(Funcname:String):Pointer;
var
  wkeDllHandle: THandle;
begin
   //if wkeDllHandle = 0 then
	   wkeDllHandle := LoadLibrary(PChar('wke.dll'));
   if wkeDllHandle <> 0 then { success }
   begin
     result := GetProcAddress(wkeDllHandle, PChar(Funcname));
	   //MessageDlg('Error: could not find exampleDLL.DLL', mtError, [mbOk], 0);
   end
   else
   begin
     result := nil;
	 MessageDlg('Error: could not find '+Funcname+' in wke.dll', mtError, [mbOk], 0);
   end;
  //FreeLibrary(hDll);
end;

procedure wke_Init();
begin
  Set8087CW(Get8087CW or $3F);

  wkeIsTransparent := LoadDllFunc('wkeIsTransparent');
  wkeSetTransparent := LoadDllFunc('wkeSetTransparent');
  wkeInit := LoadDllFunc('wkeInit');
  wkeCreateWebView := LoadDllFunc('wkeCreateWebView');
  wkeResize := LoadDllFunc('wkeResize');

  wkeLoadURL := LoadDllFunc('wkeLoadURL');
  wkeLoadURLW := LoadDllFunc('wkeLoadURLW');
  wkeLoadHTML:= LoadDllFunc('wkeLoadHTML');
  wkeLoadHTMLW:= LoadDllFunc('wkeLoadHTMLW');
  wkeLoadFile:= LoadDllFunc('wkeLoadFile');
  wkeLoadFileW:= LoadDllFunc('wkeLoadFileW');

  wkeUpdate := LoadDllFunc('wkeUpdate');
  wkeVersionString := LoadDllFunc('wkeVersionString');
  wkeIsLoaded := LoadDllFunc('wkeIsLoaded');
  
  wkeIsDocumentReady := LoadDllFunc('wkeIsDocumentReady');
  wkeIsLoadComplete := LoadDllFunc('wkeIsLoadComplete');
  wkeIsLoadFailed := LoadDllFunc('wkeIsLoadFailed');
  wkeRunJS := LoadDllFunc('wkeRunJS');
  wkeRunJSW := LoadDllFunc('wkeRunJSW');
  wkeContentsWidth := LoadDllFunc('wkeContentsWidth');
  wkeContentsHeight := LoadDllFunc('wkeContentsHeight');
  wkeWidth := LoadDllFunc('wkeWidth');
  wkeHeight := LoadDllFunc('wkeHeight');
  wkeTitleW := LoadDllFunc('wkeTitleW');
  wkePaint := LoadDllFunc('wkePaint');
  wkeIsDirty := LoadDllFunc('wkeIsDirty');
  wkeFocus := LoadDllFunc('wkeFocus');
  wkeUnfocus := LoadDllFunc('wkeUnfocus');
  
  wkeMouseEvent := LoadDllFunc('wkeMouseEvent');
  wkeContextMenuEvent := LoadDllFunc('wkeContextMenuEvent');
  wkeMouseWheel := LoadDllFunc('wkeMouseWheel');

  wkeKeyUp := LoadDllFunc('wkeKeyUp');
  wkeKeyDown := LoadDllFunc('wkeKeyDown');
  wkeKeyPress := LoadDllFunc('wkeKeyPress');

  wkeGetCaret := LoadDllFunc('wkeGetCaret');
  wkeSetEditable := LoadDllFunc('wkeSetEditable');

  wkeGlobalExec := LoadDllFunc('wkeGlobalExec');
  wkeToString := LoadDllFunc('wkeToString');

  jsBindFunction := LoadDllFunc('jsBindFunction');
  jsBindGetter := LoadDllFunc('jsBindGetter');
  jsBindSetter := LoadDllFunc('jsBindSetter');
  jsArgCount := LoadDllFunc('jsArgCount');
  jsArgType := LoadDllFunc('jsArgType');
  jsArg := LoadDllFunc('jsArg');

  jsTypeOf := LoadDllFunc('jsTypeOf');
  jsIsNumber := LoadDllFunc('jsIsNumber');
  jsIsString := LoadDllFunc('jsIsString');
  jsIsBoolean := LoadDllFunc('jsIsBoolean');
  jsIsObject := LoadDllFunc('jsIsObject');
  jsIsfunction := LoadDllFunc('jsIsfunction');
  jsIsUndefined := LoadDllFunc('jsIsUndefined');
  jsIsNull := LoadDllFunc('jsIsNull');
  jsIsArray := LoadDllFunc('jsIsArray');
  jsIsTrue := LoadDllFunc('jsIsTrue');
  jsIsFalse := LoadDllFunc('jsIsFalse');

  jsToInt := LoadDllFunc('jsToInt');
  jsToFloat := LoadDllFunc('jsToFloat');
  jsToDouble := LoadDllFunc('jsToDouble');
  jsToBoolean := LoadDllFunc('jsToBoolean');
  jsToString := LoadDllFunc('jsToString');
  jsToStringW := LoadDllFunc('jsToStringW');

  jsInt := LoadDllFunc('jsInt');
  jsFloat := LoadDllFunc('jsFloat');
  jsDouble := LoadDllFunc('jsDouble');
  jsBoolean := LoadDllFunc('jsBoolean');

  jsUndefined := LoadDllFunc('jsUndefined');
  jsNull := LoadDllFunc('jsNull');
  jsTrue := LoadDllFunc('jsTrue');
  jsFalse := LoadDllFunc('jsFalse');
  
  jsString := LoadDllFunc('jsString');
  jsStringW := LoadDllFunc('jsStringW');
  jsjsobject := LoadDllFunc('jsjsobject');
  jsArray := LoadDllFunc('jsArray');

  jsFunction := LoadDllFunc('jsFunction');

//return the window object
  jsGlobalobject := LoadDllFunc('jsGlobalobject');

  jsEval := LoadDllFunc('jsEval');
  jsEvalW := LoadDllFunc('jsEvalW');

  jsCall := LoadDllFunc('jsCall');
  jsCallGlobal := LoadDllFunc('jsCallGlobal');

  jsGet := LoadDllFunc('jsGet');
  jsSet := LoadDllFunc('jsSet');

  jsGetGlobal := LoadDllFunc('jsGetGlobal');
  jsSetGlobal := LoadDllFunc('jsSetGlobal');

  jsGetAt := LoadDllFunc('jsGetAt');
  jsSetAt := LoadDllFunc('jsSetAt');

  jsGetLength := LoadDllFunc('jsGetLength');
  jsSetLength := LoadDllFunc('jsSetLength');

  jsGetWebView := LoadDllFunc('jsGetWebView');

  jsGC := LoadDllFunc('jsGC');
  
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