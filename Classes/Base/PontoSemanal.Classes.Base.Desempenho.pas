unit PontoSemanal.Classes.Base.Desempenho;

interface

uses
  PontoSemanal.Helpers.TiposAuxiliares;

type
  TDesempenho = class
  private
    FTotalTrabalhado: string;
    FSaldoHoras: string;
    FCumprimentoHorario: TCumprimentoHorario;
  public
    property TotalTrabalhado: string read FTotalTrabalhado write FTotalTrabalhado;
    property SaldoHoras: string read FSaldoHoras write FSaldoHoras;
    property CumprimentoHorario: TCumprimentoHorario read FCumprimentoHorario;
    procedure AtualizarCumprimento(pJornada: Integer);
  end;

implementation

uses
  System.Classes, System.StrUtils, System.SysUtils;

{ TDesempenho }

procedure TDesempenho.AtualizarCumprimento(pJornada: Integer);
var
  lHorario: THorarioSeparado;
begin
  FCumprimentoHorario := chAcima;

  lHorario.Horas := SplitString(TotalTrabalhado, ':')[0].ToInteger;
  lHorario.Minutos := SplitString(TotalTrabalhado, ':')[1].ToInteger;

  if (lHorario.Horas = pJornada) and (lHorario.Minutos = 0) then
  begin
    FCumprimentoHorario := chRegular;
  end else
  if lHorario.Horas < pJornada then
  begin
    FCumprimentoHorario := chAbaixo;
  end;

//  if (lHorario.Horas > pJornadaDiaria) or ((lHorario.Horas = pJornadaDiaria) and (lHorario.Minutos > 0)) then
//  begin
//    FCumprimentoHorario := chAcima;
//  end else
//  if lHorario.Horas < pJornadaDiaria then
//  begin
//    FCumprimentoHorario := chAbaixo;
//  end;
end;

end.
