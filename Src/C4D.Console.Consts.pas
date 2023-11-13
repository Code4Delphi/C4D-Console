unit C4D.Console.Consts;

interface

uses
  System.SysUtils;

type
  TC4DConsoleConsts = class
  public const
    CMD_DISABLE_LOG = '-l';
    CMD_ENABLE_LOG = '+l';
    CMD_RESUME = '-r';
    CMD_HELP = '-h';
    CMD_FINISH_DEFAULT = '\q';
  end;

implementation

end.
