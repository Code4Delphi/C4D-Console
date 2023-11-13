unit C4D.Console.Utils;

interface

uses
  System.SysUtils,
  System.DateUtils;

type
  TC4DConsoleUtils = class
  private
  public
    class function DhCompilation: TDateTime;
    class function TimeInRunning(const ADhIni: TDateTime): string;
  end;

implementation

class function TC4DConsoleUtils.DhCompilation: TDateTime;
begin
  FileAge(ParamStr(0), Result);
end;

class function TC4DConsoleUtils.TimeInRunning(const ADhIni: TDateTime): string;
var
  LDaysDif: Double;
begin
  Result := '';
  try
    if(ADhIni > 0)then
    begin
      LDaysDif := DaySpan(Now, ADhIni);
      Result := IntToStr(Trunc(LDaysDif)) + ' days, ' + FormatDateTime('h" hours, "n" minutes e "s" seconds"', LDaysDif);
    end;
  except
    on E: exception do
      Result := 'TimeInRunning: Cant be caught. ' + E.Message;
  end;
end;

end.
