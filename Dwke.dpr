program Dwke;

uses
  Forms,
  main in 'main.pas' {Form1},
  alphiWindow in 'alphiWindow.pas' {Form2};

{$R *.res}
//var
//  webView:wkeWebView;

begin
  //Application.Initialize;
  //Application.CreateForm(TForm1, Form1);
 // Application.Run;
  //wkeInit();
  //webView := wkeCreateWebView();
  //wkeResize(webView, 1024, 768);
  //wkeLoadURL(webView,'http://www.baidu.com');
  //while True do
  //begin
    //wkeUpdate();
    //if wkeIsLoadComplete(webView) then
    //begin
      Application.Initialize;
      Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
      //Break;
    //end;
  //end;
end.
