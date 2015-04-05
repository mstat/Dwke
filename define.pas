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
  