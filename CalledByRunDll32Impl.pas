unit CalledByRunDll32Impl;

interface
uses Winapi.Windows;



///<summary>rundll32 path\to\your.dll,EntryPoint additional parameters go here</summary>
procedure EntryPoint(_HWnd: HWND; _HInstance: HINST; _CmdLine: PAnsiChar; CmdShow: Integer); stdcall;
///<summary>rundll32 path\to\your.dll,EntryPoint additional parameters go here. If EntryPointA is exported, calls
///  EntryPointA first, otherwise, calls EntryPoint.
///</summary>
procedure EntryPointA(_HWnd: HWND; _HInstance: HINST; _CmdLine: PAnsiChar; CmdShow: Integer); stdcall;
///<summary>rundll32 path\to\your.dll,EntryPoint additional parameters go here. If EntryPointW is exported, calls
///  EntryPointW first, otherwise, calls EntryPoint.
///</summary>
procedure EntryPointW(_HWnd: HWND; _HInstance: HINST; _CmdLine: PWideChar; CmdShow: Integer); stdcall;

implementation
uses
  Vcl.Dialogs, System.SysUtils;

procedure EntryPoint(_HWnd: HWND; _HInstance: HINST; _CmdLine: PAnsiChar; CmdShow: Integer);
begin
{$IF DEFINED(WIN64)}
  EntryPointW(_HWnd, _HInstance, PWideChar(string(_CmdLine)), CmdShow);
{$ELSEIF DEFINED(WIN32)}
  EntryPointA(_HWnd, _HInstance, _CmdLine, CmdShow);
{$ENDIF}
end;

procedure EntryPointA(_HWnd: HWND; _HInstance: HINST; _CmdLine: PAnsiChar; CmdShow: Integer);
begin
  ShowMessage(Format('This is EntryPointA: CmdLine: "%s"', [string(_CmdLine)]));
end;

procedure EntryPointW(_HWnd: HWND; _HInstance: HINST; _CmdLine: PWideChar; CmdShow: Integer);
begin
  ShowMessage(Format('This is EntryPointW: CmdLine: "%s"', [string(_CmdLine)]));
end;

exports
{$IF DEFINED(WIN64)}
  EntryPointW,
{$ELSEIF DEFINED(WIN32)}
  EntryPointA,
{$ENDIF}
  EntryPoint;

end.
