unit C4D.Console;

interface

uses
  System.SysUtils;

type
  TC4DConsole = class
  private
    FLogEnabled: Boolean;
    FPrefix: string;
    FVersion: string;
    FPort: Integer;
    FDhIni: TDateTime;
    FCommandFinish: string;
    constructor Create;
    function WritePrefixLine: string;
    procedure WritelnInternal(const AStr: string; const AInsertPrefixNewLine: Boolean = True; const AForceWriting: Boolean = False);
    procedure LinhaRodape;
  public
    function LogEnabled: Boolean;
    function EnableLog: TC4DConsole;
    function DisableLog: TC4DConsole;
    function Prefix: string; overload;
    function Prefix(const Value: string): TC4DConsole; overload;
    function Version: string; overload;
    function Version(const Value: string): TC4DConsole; overload;
    function Port: Integer; overload;
    function Port(const Value: Integer): TC4DConsole; overload;
    function DhIni: TDateTime; overload;
    function DhIni(const Value: TDateTime): TC4DConsole; overload;
    function CommandFinish: string; overload;
    function CommandFinish(const Value: string): TC4DConsole; overload;
    function WriteInitialSummary(const AStrFirstLine: string): TC4DConsole;
    function DtHrStr: string;
    function DhCompilation: string;
    function WriteStr(const AStr: string): TC4DConsole;
    function WriteDh(const AStr: string): TC4DConsole;
    function WriteStrLn(const AStr: string; const AForceWriting: Boolean = False): TC4DConsole;
    function WriteDhLn(const AStr: string; const AForceWriting: Boolean = False): TC4DConsole;
    function BreachLines(const ACount: Integer = 1): TC4DConsole;
    function WriteLineSeparation(const ASeparator: WideChar = '*'; const ACount: Integer = 80): TC4DConsole;
    function WritelnLineSeparation(const ASeparator: WideChar; const ACount: Integer): TC4DConsole;
    function ProcessDigitated(const AStr: string): TC4DConsole;
  end;

function C4DConsole: TC4DConsole;

implementation

uses
  C4D.Console.Consts,
  C4D.Console.Utils;

var
  FInstance: TC4DConsole;

function C4DConsole: TC4DConsole;
begin
  if(not Assigned(FInstance))then
    FInstance := TC4DConsole.Create;
  Result := FInstance;
end;

constructor TC4DConsole.Create;
begin
  FLogEnabled := True;
  FPrefix := 'C4D';
  FVersion := '';
  FDhIni := Now;
  FCommandFinish := TC4DConsoleConsts.CMD_FINISH_DEFAULT;
end;

function TC4DConsole.LogEnabled: Boolean;
begin
  Result := FLogEnabled;
end;

function TC4DConsole.EnableLog: TC4DConsole;
begin
  Result := Self;
  FLogEnabled := True;
end;

function TC4DConsole.DisableLog: TC4DConsole;
begin
  Result := Self;
  FLogEnabled := False;
end;

function TC4DConsole.Version: string;
begin
  Result := FVersion;
end;

function TC4DConsole.Version(const Value: string): TC4DConsole;
begin
  Result := Self;
  FVersion := Value;
end;

function TC4DConsole.Prefix: string;
begin
  Result := FPrefix;
end;

function TC4DConsole.Prefix(const Value: string): TC4DConsole;
begin
  Result := Self;
  FPrefix := Value;
end;

function TC4DConsole.Port: Integer;
begin
  Result := FPort;
end;

function TC4DConsole.Port(const Value: Integer): TC4DConsole;
begin
  Result := Self;
  FPort := Value;
end;

function TC4DConsole.DhIni: TDateTime;
begin
  Result := FDhIni;
end;

function TC4DConsole.DhIni(const Value: TDateTime): TC4DConsole;
begin
  Result := Self;
  FDhIni := Value;
end;

function TC4DConsole.CommandFinish(const Value: string): TC4DConsole;
begin
  Result := Self;
  FCommandFinish := Value;
end;

function TC4DConsole.CommandFinish: string;
begin
  Result := FCommandFinish;
end;

function TC4DConsole.WriteInitialSummary(const AStrFirstLine: string): TC4DConsole;
begin
  Result := Self;
  Self.WriteLineSeparation;
  Writeln(AStrFirstLine);
  Writeln('  Compiled: ' + Self.DhCompilation);
  Writeln('  Started : ' + DateTimeToStr(FDhIni));
  Writeln('  Version : ' + FVersion);
  Writeln('  Port    : ' + FPort.ToString);
  Writeln('  Path    : ' + ParamStr(0));
  Writeln('  Help    : ' + TC4DConsoleConsts.CMD_HELP);
  Self.WritePrefixLine;
end;

function TC4DConsole.WritePrefixLine: string;
begin
  Write(FPrefix + ': ');
end;

function TC4DConsole.DtHrStr: string;
begin
  Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
end;

function TC4DConsole.DhCompilation: string;
begin
  Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', TC4DConsoleUtils.DhCompilation);
end;

function TC4DConsole.WriteStr(const AStr: string): TC4DConsole;
begin
  Result := Self;
  Self.WritelnInternal(AStr, False);
end;

function TC4DConsole.WriteDh(const AStr: string): TC4DConsole;
begin
  Result := Self;
  Self.WritelnInternal(Self.DtHrStr + AStr, False);
end;

function TC4DConsole.WriteStrLn(const AStr: string; const AForceWriting: Boolean = False): TC4DConsole;
begin
  Result := Self;
  Self.WritelnInternal(AStr, True, AForceWriting);
end;

function TC4DConsole.WriteDhLn(const AStr: string; const AForceWriting: Boolean = False): TC4DConsole;
begin
  Result := Self;
  Self.WritelnInternal(Self.DtHrStr + AStr, AForceWriting);
end;

procedure TC4DConsole.WritelnInternal(const AStr: string; const AInsertPrefixNewLine: Boolean = True; const AForceWriting: Boolean = False);
begin
  if(AForceWriting)or(FLogEnabled)then
  begin
    Writeln(AStr);

    if(AInsertPrefixNewLine)then
      Self.WritePrefixLine;
  end;
end;

function TC4DConsole.BreachLines(const ACount: Integer = 1): TC4DConsole;
var
  i: Integer;
begin
  Result := Self;
  for i := 1 to ACount do
    Writeln(' ');
end;

function TC4DConsole.WriteLineSeparation(const ASeparator: WideChar = '*'; const ACount: Integer = 80): TC4DConsole;
begin
  Result := Self;
  Writeln(StringOfChar(ASeparator, ACount));
end;

function TC4DConsole.WritelnLineSeparation(const ASeparator: WideChar; const ACount: Integer): TC4DConsole;
begin
  Result := Self;
  Self.WriteLineSeparation(ASeparator, ACount);
  Self.WritePrefixLine;
end;

procedure TC4DConsole.LinhaRodape;
begin
  Self.WriteLineSeparation;
end;

function TC4DConsole.ProcessDigitated(const AStr: string): TC4DConsole;
begin
  Result := Self;
  if(AStr = TC4DConsoleConsts.CMD_DISABLE_LOG)then
  begin
    FLogEnabled := False;
    WriteLineSeparation;
    Writeln('LOG DISABLED');
    Self.LinhaRodape;
  end
  else if(AStr = TC4DConsoleConsts.CMD_ENABLE_LOG)then
  begin
    FLogEnabled := True;
    WriteLineSeparation;
    Writeln('LOG ACTIVATED');
    Self.LinhaRodape;
  end
  else if(AStr = TC4DConsoleConsts.CMD_RESUME)then
  begin
    WriteLineSeparation;
    Writeln(FPrefix + '  SUMMARY: ');
    Writeln('  Server started on: ' + DateTimeToStr(FDhIni));
    Writeln('  Server running at: ' + TC4DConsoleUtils.TimeInRunning(FDhIni));
    Writeln('  Port: ' + Port.ToString);
    Writeln('  Version: ' + Version);
    Writeln('  Path: ' + ParamStr(0));
    Writeln('  Compiled in: ' + DhCompilation);
    Self.LinhaRodape;
  end
  else if(AStr = TC4DConsoleConsts.CMD_HELP)then
  begin
    WriteLineSeparation;
    Writeln(FPrefix + ' HELP:  ');
    Writeln(Format(' %s   Disable logging', [TC4DConsoleConsts.CMD_DISABLE_LOG]));
    Writeln(Format(' %s   Enable logging', [TC4DConsoleConsts.CMD_ENABLE_LOG]));
    Writeln(Format(' %s   Generate summary', [TC4DConsoleConsts.CMD_RESUME]));
    Writeln(Format(' %s   Close', [CommandFinish]));
    Self.LinhaRodape;
  end
  else if(AStr <> '')and(AStr <> CommandFinish)then
    Writeln(Format('Command %s not found (help: %s)', [AStr, TC4DConsoleConsts.CMD_HELP]));

  Self.WritePrefixLine;
end;

initialization

finalization
  if(Assigned(FInstance))then
    FreeAndNil(FInstance);

end.
