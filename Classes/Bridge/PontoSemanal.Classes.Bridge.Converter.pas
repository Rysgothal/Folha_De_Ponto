unit PontoSemanal.Classes.Bridge.Converter;

interface

uses
  PontoSemanal.Interfaces.Bridge.Converter;

type
  TConverter = class(TinterfacedObject, IConverter)
  public
    function ParaMinutos(pHorario: string): Integer;
  end;
implementation

uses
  PontoSemanal.Helpers.TiposAuxiliares, System.StrUtils, System.SysUtils,
  PontoSemanal.Helpers.Strings;

{ TConverter }

function TConverter.ParaMinutos(pHorario: string): Integer;
var
  lHorario: THorarioSeparado;
begin
  if TStringHelpers.VerificarCampoVazio(pHorario) then
  begin
    pHorario := '00:00';
  end;

  lHorario.Horas := SplitString(pHorario, ':')[0].ToInteger;
  lHorario.Minutos := SplitString(pHorario, ':')[1].ToInteger;

  Result := lHorario.Minutos + (lHorario.Horas * 60);
end;

end.
