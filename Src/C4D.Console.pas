unit C4D.Console;

interface

uses
 System.SysUtils;

type
  TC4DConsole = class
  private
    FLogEnabled: Boolean;
    FPrefix: String;
    FVersion: String;
    FPort: Integer;
    FDhIni: TDateTime;
    FCommandFinish: String;
    constructor Create;
    function WritePrefixLine: String;
    procedure WritelnInternal(const AStr: String;
                              const AInsertPrefixNewLine: Boolean = True;
                              const AForceWriting       : Boolean = False);
    procedure LinhaRodape;
  public
    function LogEnabled: Boolean;
    function EnableLog: TC4DConsole;
    function DisableLog: TC4DConsole;
    function Prefix: String; overload;
    function Prefix(const Value: String): TC4DConsole; overload;
    function Version: String; overload;
    function Version(const Value: String): TC4DConsole; overload;
    function Port: Integer; overload;
    function Port(const Value: Integer): TC4DConsole; overload;
    function DhIni: TDateTime; overload;
    function DhIni(const Value: TDateTime): TC4DConsole; overload;
    function CommandFinish: String; overload;
    function CommandFinish(const Value: String): TC4DConsole; overload;

    function WriteInitialSummary(const AStrFirstLine: String): TC4DConsole;
    function DtHrStr: String;
    function DhCompilation: String;
    function WriteStr(const AStr: String): TC4DConsole;
    function WriteDh(const AStr: String): TC4DConsole;
    function WriteStrLn(const AStr: String; const AForceWriting: Boolean = False): TC4DConsole;
    function WriteDhLn(const AStr: String; const AForceWriting: Boolean = False): TC4DConsole;
    function BreachLines(const ACount: Integer = 1): TC4DConsole;
    function WriteLineSeparation  (const ASeparator: WideChar = '*'; const ACount: Integer = 80): TC4DConsole;
    function WritelnLineSeparation(const ASeparator: WideChar; const ACount: Integer): TC4DConsole;
    function ProcessDigitated(const AStr: String): TC4DConsole;
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
   FLogEnabled    := True;
   FPrefix        := 'C4D';
   FVersion       := '';
   FDhIni         := Now;
   FCommandFinish := TC4DConsoleConsts.CMD_FINISH_DEFAULT;
end;

function TC4DConsole.LogEnabled: Boolean;
begin
   Result := FLogEnabled;
end;

function TC4DConsole.EnableLog: TC4DConsole;
begin
   Result      := Self;
   FLogEnabled := True;
end;

function TC4DConsole.DisableLog: TC4DConsole;
begin
   Result      := Self;
   FLogEnabled := False;
end;

function TC4DConsole.Version: String;
begin
   Result := FVersion;
end;

function TC4DConsole.Version(const Value: String): TC4DConsole;
begin
   Result   := Self;
   FVersion := Value;
end;

function TC4DConsole.Prefix: String;
begin
   Result := FPrefix;
end;

function TC4DConsole.Prefix(const Value: String): TC4DConsole;
begin
   Result  := Self;
   FPrefix := Value;
end;

function TC4DConsole.Port: Integer;
begin
   Result := FPort;
end;

function TC4DConsole.Port(const Value: Integer): TC4DConsole;
begin
   Result := Self;
   FPort  := Value;
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

function TC4DConsole.CommandFinish(const Value: String): TC4DConsole;
begin
   Result         := Self;
   FCommandFinish := Value;
end;

function TC4DConsole.CommandFinish: String;
begin
   Result := FCommandFinish;
end;

function TC4DConsole.WriteInitialSummary(const AStrFirstLine: String): TC4DConsole;
begin
   Result := Self;
   Self.WriteLineSeparation;
   Writeln(AStrFirstLine);
   Writeln('  Compilado: ' + Self.DhCompilation);
   Writeln('  Iniciado : ' + DateTimeToStr(FDhIni));
   Writeln('  Versão   : ' + FVersion);
   Writeln('  Porta    : ' + FPort.ToString);
   Writeln('  Caminho  : ' + ParamStr(0));
   Writeln('  Ajuda    : ' + TC4DConsoleConsts.CMD_HELP);
   Self.WritePrefixLine;
end;

function TC4DConsole.WritePrefixLine: String;
begin
   Write(FPrefix + ': ');
end;

function TC4DConsole.DtHrStr: String;
begin
   Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
end;

function TC4DConsole.DhCompilation: String;
begin
   Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', TC4DConsoleUtils.DhCompilation);
end;

function TC4DConsole.WriteStr(const AStr: String): TC4DConsole;
begin
   Result := Self;
   Self.WritelnInternal(AStr, False);
end;

function TC4DConsole.WriteDh(const AStr: String): TC4DConsole;
begin
   Result := Self;
   Self.WritelnInternal(Self.DtHrStr + AStr, False);
end;

function TC4DConsole.WriteStrLn(const AStr: String; const AForceWriting: Boolean = False): TC4DConsole;
begin
   Result := Self;
   Self.WritelnInternal(AStr, True, AForceWriting);
end;

function TC4DConsole.WriteDhLn(const AStr: String; const AForceWriting: Boolean = False): TC4DConsole;
begin
   Result := Self;
   WriteLn(Self.DtHrStr + AStr, AForceWriting);
end;

procedure TC4DConsole.WritelnInternal(const AStr: String;
                                      const AInsertPrefixNewLine: Boolean = True;
                                      const AForceWriting       : Boolean = False);
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

function TC4DConsole.ProcessDigitated(const AStr: String): TC4DConsole;
begin
   Result := Self;
   if(AStr = TC4DConsoleConsts.CMD_DISABLE_LOG)then
   begin
      FLogEnabled := False;
      WriteLineSeparation;
      WriteLn('LOG DESATIVADO');
      Self.LinhaRodape;
   end
   else if(AStr = TC4DConsoleConsts.CMD_ENABLE_LOG)then
   begin
      FLogEnabled := True;
      WriteLineSeparation;
      WriteLn('LOG ATIVADO');
      Self.LinhaRodape;
   end
   else if(AStr = TC4DConsoleConsts.CMD_RESUME)then
   begin
      WriteLineSeparation;
      WriteLn(FPrefix + '  RESUMO: ');
      WriteLn('  Servidor iniciado em: ' + DateTimeToStr(FDhIni));
      WriteLn('  Servidor rodando a: '   + TC4DConsoleUtils.TimeInRunning(FDhIni));
      WriteLn('  Porta: '                + Port.ToString);
      WriteLn('  Versão: '               + Version);
      WriteLn('  Caminho: '              + ParamStr(0));
      WriteLn('  Compilado em: '         + DhCompilation);
      Self.LinhaRodape;
   end
   else if(AStr = TC4DConsoleConsts.CMD_HELP)then
   begin
      WriteLineSeparation;
      WriteLn(FPrefix + ' AJUDA:  ');
      WriteLn(Format(' %s   Desativar geração de log', [TC4DConsoleConsts.CMD_DISABLE_LOG]));
      WriteLn(Format(' %s   Ativar geração de log',    [TC4DConsoleConsts.CMD_ENABLE_LOG]));
      WriteLn(Format(' %s   Gerar resumo',             [TC4DConsoleConsts.CMD_RESUME]));
      WriteLn(Format(' %s   Encerrar',                 [CommandFinish]));
      Self.LinhaRodape;
   end
   else if(AStr <> '')and(AStr <> CommandFinish)then
   begin
      WriteLn(Format('Comando %s não encontrado (ajuda: %s)', [AStr, TC4DConsoleConsts.CMD_HELP]));
   end;
   Self.WritePrefixLine;
end;

initialization

finalization
  if(Assigned(FInstance))then
    FreeAndNil(FInstance);

end.
