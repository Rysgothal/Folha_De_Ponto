unit PontoSemanal.Helpers.TiposAuxiliares;

interface

type
  { Enumerados }
  TDiaSemana = (dsNenhum = -1, dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado);
  TRegistroHorario = (rhEntrada, rhSaidaAlmoco, rhRetornoAlmoco, rhSaidaFinal);
  TCumprimentoHorario = (chAcima, chRegular, chAbaixo);

  { Records }
  THorarioSeparado = record
    Horas: Integer;
    Minutos: Integer;
  end;

implementation

end.
