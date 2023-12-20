unit PontoSemanal.Classes.Bridge.Converter;

interface

uses
  PontoSemanal.Interfaces.Bridge.Converter;

type
  TConverter = class(TinterfacedObject, IConverter)
  private
    function ZerarSeVazio(pValor: string): string;
  public
    function ParaMinutos(const pHorario: string): Integer;
  end;
implementation

uses
  PontoSemanal.Helpers.TiposAuxiliares, System.StrUtils, System.SysUtils;

{ TConverter }

function TConverter.ParaMinutos(const pHorario: string): Integer;
var
  lHorario: THorarioSeparado;
begin
  lHorario.Horas := ZerarSeVazio(SplitString(pHorario, ':')[0]).ToInteger;
  lHorario.Minutos := ZerarSeVazio(SplitString(pHorario, ':')[1]).ToInteger;

  Result := lHorario.Minutos + (lHorario.Horas * 60);
end;

function TConverter.ZerarSeVazio(pValor: string): string;
begin
  case pValor.Trim = EmptyStr of
    True: Result := '0';
    else Result := pValor.Trim;
  end;
end;

end.
