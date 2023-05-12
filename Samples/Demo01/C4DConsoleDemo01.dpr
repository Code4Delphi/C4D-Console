program C4DConsoleDemo01;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  C4D.Console;

var
 FDig: String;

begin
   ReportMemoryLeaksOnShutdown := True;
   C4DConsole
     .Prefix('C4DConsoleDemo01')
     .Version('1.0.0')
     .Port(0)
     .WriteInitialSummary('#CODE4DELPHI SERVIDOR INICIADO');

   FDig := '';
   while(FDig <> C4DConsole.CommandFinish)do
   begin
      ReadLn(FDig);
      C4DConsole.ProcessDigitated(FDig);
   end;

   C4DConsole
     .WriteStr('Finalizando')
     .BreachLines
     .WriteStr('  Passo 1/3')
     .BreachLines
     .WriteStr('  Passo 2/3')
     .BreachLines
     .WriteStr('  Passo 3/3')
     .BreachLines;

   C4DConsole.WriteStr('ENCERANDO').WriteLineSeparation('#', 80);
   Sleep(3000);
end.
