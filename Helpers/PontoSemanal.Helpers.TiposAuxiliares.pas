unit PontoSemanal.Helpers.TiposAuxiliares;

interface

type
  { Enumerados }
  TDiaSemana = (dsNenhum = -1, dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado);
  TRegistroHorario = (rhEntrada, rhSaidaAlmoco, rhRetornoAlmoco, rhSaidaFinal);
  TCumprimentoHorario = (chNenhum = -1, chAcima, chRegular, chAbaixo);
  TLayoutLinha = (llCodigo = 4, llFuncionario, llAdmissao , llJornada, llIntervalo, llSegunda = 15, llTerca = 17,
    llQuarta = 19, llQuinta = 21, llSexta = 23, llSabado = 25, llTotalHorasSemana = 28, llHorasFaltantes,
    llHorasExcedentes);

  { Records }
  THorarioSeparado = record
    Horas: Integer;
    Minutos: Integer;
  end;

  THorarios = record
    Entrada: string;
    SaidaAlmoco: string;
    RetornoAlmoco: string;
    SaidaFinal: string;
    Total: string
  end;

implementation

end.
