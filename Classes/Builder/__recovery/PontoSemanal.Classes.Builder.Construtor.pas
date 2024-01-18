unit PontoSemanal.Classes.Builder.Construtor;

interface

uses
  PontoSemanal.Interfaces.Builder.FolhaDePonto, System.Classes,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Classes.Builder.Layout;

type
  TConstrutor = class(TInterfacedObject, IConstrutor)
  private
    FFolhaDePonto: TStringList;
    FLayout: TLayout;
    function GetFolhaDePonto: TStringList;
//    function RetornarLinhaDiaDaSemana(pDia: THorariosDia): string;
//    function RetornarLinhaTotalHoras: string;
//    function RetornarLinhaHorasFaltantes: string;
//    function RetornarLinhaHorasExcedentes: string;
    function AgruparHorarios(pDiaSemana: TDiaSemana): string;
    function RetornarHashHorario(pRegistroHorario: TRegistroHorario; pDia: THorariosDia): string;
    procedure AdicionarLinhaHash(pDia: THorariosDia);
    function RetornarHorariosDoDia(pDiaSemana: TDiaSemana): THorarios;
//    procedure Layout;
  public
    constructor Create;
    property FolhaDePonto: TStringList read GetFolhaDePonto;
    procedure ConstruirCabecalho;                // OK
    procedure ConstruirDadosFuncionario;         // OK
    procedure ConstruirTituloHorarios;           // OK
    procedure ConstruirHorarioSegunda;           // OK
    procedure ConstruirHorarioTerca;             // OK
    procedure ConstruirHorarioQuarta;            // OK
    procedure ConstruirHorarioQuinta;            // OK
    procedure ConstruirHorarioSexta;             // OK
    procedure ConstruirHorarioSabado;            // OK
    procedure ConstruirSaldoDeHoras;             // OK
//    procedure ConstruirLinhaDivisaoHorarios;
    procedure ConstruirRodape;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, 
  System.StrUtils, System.SysUtils,
  PontoSemanal.Helpers.Strings, PontoSemanal.Helpers.Constantes,
  System.RegularExpressions;

{ TConstrutor }

//function TConstrutor.RetornarLinhaDiaDaSemana(pDia: THorariosDia): string;
//var
//  lDiaNome, lSaidaAlmoco, lRetornoAlmoco, lLinhaMontada: string;
//begin
//  lSaidaAlmoco := '  -  ' ;
//  lRetornoAlmoco := '  -  ';
//
//  if pDia.Tag <> dsSabado then
//  begin
//    lSaidaAlmoco := IfThen(pDia.SaidaAlmoco.Trim = EmptyStr, '00:00', pDia.SaidaAlmoco);
//    lRetornoAlmoco := IfThen(pDia.RetornoAlmoco.Trim = EmptyStr, '00:00', pDia.RetornoAlmoco);
//  end;
//
//  lSaidaAlmoco := lSaidaAlmoco.PadRight(10, ' ').PadLeft(14, ' ');
//  lRetornoAlmoco := lRetornoAlmoco.PadRight(11, ' ').PadLeft(16, ' ');
//  lDiaNome := pDia.PegarNomeDaSemana(True, True).PadRight(15, ' ');
//
//  lLinhaMontada := lDiaNome + '|  ' + pDia.Entrada + '  |' + lSaidaAlmoco + '|' + lRetornoAlmoco + '|    ' +
//    pDia.SaidaFinal.PadRight(9, ' ') + '|' + pDia.Desempenho.TotalTrabalhado.PadLeft(9, ' ');
//
//  Result := lLinhaMontada;
//end;

//function TConstrutor.RetornarLinhaHorasExcedentes: string;
//var
//  lPontoSemanal: TFolhaPontoSemanalSingleton;
//  lSaldoHoras, lLinha: string;
//begin
//  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
//  lSaldoHoras := lPontoSemanal.Desempenho.SaldoHoras.PadRight(9, ' ');
//  lLinha := EmptyStr;
//
//  case lPontoSemanal.Desempenho.CumprimentoHorario of
//    chAcima: lLinha := 'Horas/minutos excedentes:    '.PadLeft(77, ' ') + lSaldoHoras;
//    else lLinha := 'Horas/minutos excedentes:      -      '.PadLeft(86, ' ');
//  end;
//
//  Result := ' |' + lLinha + '|';
//end;

//function TConstrutor.RetornarLinhaHorasFaltantes: string;
//var
//  lPontoSemanal: TFolhaPontoSemanalSingleton;
//  lSaldoHoras, lLinha: string;
//begin
//  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
//  lSaldoHoras := lPontoSemanal.Desempenho.SaldoHoras.PadRight(9, ' ');
//  lLinha := EmptyStr;
//
//  case lPontoSemanal.Desempenho.CumprimentoHorario of
//    chAbaixo: lLinha := 'Horas/minutos faltantes:    '.PadLeft(77, ' ') + lSaldoHoras;
//    else lLinha := 'Horas/minutos faltantes:      -      '.PadLeft(86, ' ');
//  end;
//
//  Result := ' |' + lLinha + '|';
//end;

//function TConstrutor.RetornarLinhaTotalHoras: string;
//var
//  lPontoSemanal: TFolhaPontoSemanalSingleton;
//  lLinha: string;
//begin
//  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
//  lLinha := 'Total de horas trabalhadas na semana:    '.PadLeft(77, ' ') + lPontoSemanal.Desempenho.TotalTrabalhado;
//  lLinha := ' |' + lLinha.PadRight(86, ' ') + '|';
//  Result := lLinha;
//end;

function TConstrutor.AgruparHorarios(pDiaSemana: TDiaSemana): string;
var
  lRegex, lValorAgrupado: string;
begin
  case pDiaSemana of
    dsSegunda: lRegex := TConstantes.REGEX_SEGUNDA_HORARIOS;
    dsTerca: lRegex := TConstantes.REGEX_TERCA_HORARIOS;
    dsQuarta: lRegex := TConstantes.REGEX_QUARTA_HORARIOS;
    dsQuinta: lRegex := TConstantes.REGEX_QUINTA_HORARIOS;
    dsSexta: lRegex := TConstantes.REGEX_SEXTA_HORARIOS;
    dsSabado: lRegex := TConstantes.REGEX_SABADO_HORARIOS;
  end;

  lValorAgrupado := TRegex.Match(FLayout.Layout.Text, lRegex).Value;
  lValorAgrupado := lValorAgrupado.Replace('-Feira', EmptyStr, [rfReplaceAll]);
  lValorAgrupado := lValorAgrupado.Replace('ç', 'c', [rfReplaceAll]);
  lValorAgrupado := lValorAgrupado.Replace('á', 'a', [rfReplaceAll]);

  Result := lValorAgrupado.Trim;
end;

procedure TConstrutor.ConstruirCabecalho;
begin
  FLayout.CarregarLayoutCabecalho;
end;

procedure TConstrutor.ConstruirDadosFuncionario;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  FLayout.CarregarLayoutDadosFuncionario;
  FLayout.Codigo := lPontoSemanal.ID;
  FLayout.Funcionario := lPontoSemanal.Nome;
  FLayout.Admissao := lPontoSemanal.DataAdmissao + ' ' + lPontoSemanal.TempoAdmissao;
  FLayout.JornadaSemanal := lPontoSemanal.JornadaSemanal + ' horas';
  FLayout.IntervaloAlmoco := lPontoSemanal.IntervaloAlmoco + ' -> ' + lPontoSemanal.IntervaloAlmocoExtenso;
end;

procedure TConstrutor.ConstruirHorarioQuarta;
begin
  FLayout.CarregarLayoutQuarta;
  FLayout.Quarta := RetornarHorariosDoDia(dsQuarta);
//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioQuinta;
begin
  FLayout.CarregarLayoutQuinta;
  FLayout.Quinta := RetornarHorariosDoDia(dsQuinta);
//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSabado;
begin
  FLayout.CarregarLayoutSabado;
  FLayout.Sabado := RetornarHorariosDoDia(dsSabado);
//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSegunda;
begin
  FLayout.CarregarLayoutSegunda;
  FLayout.Segunda := RetornarHorariosDoDia(dsSegunda);
//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSexta;
begin
  FLayout.CarregarLayoutSexta;
  FLayout.Sexta := RetornarHorariosDoDia(dsSexta);
//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioTerca;
begin
  FLayout.CarregarLayoutTerca;
  FLayout.Terca := RetornarHorariosDoDia(dsTerca);;

//  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
//  ConstruirLinhaDivisaoHorarios;
end;

//procedure TConstrutor.ConstruirLinhaDivisaoHorarios;
//var
//  lLinha: string;
//begin
//  lLinha := ' |'.PadRight(17, '-');
//  lLinha := lLinha + '-|'.PadRight(10, '-');
//  lLinha := lLinha + '-|'.PadRight(15, '-');
//  lLinha := lLinha + '-|'.PadRight(17, '-');
//  lLinha := lLinha + '-|'.PadRight(14, '-');
//  lLinha := lLinha + '-|'.PadRight(15, '-') + '| ';
//
//  FFolhaDePonto.Add(lLinha);
//end;

procedure TConstrutor.ConstruirRodape;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  lSegunda := AgruparHorarios(dsSegunda);
  lTerca := AgruparHorarios(dsTerca);
  lQuarta := AgruparHorarios(dsQuarta);
  lQuinta := AgruparHorarios(dsQuinta);
  lSexta := AgruparHorarios(dsSexta);
  lSabado := AgruparHorarios(dsSabado);

  FFolhaDePonto := FLayout.Layout;

  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');

  FFolhaDePonto.AddStrings([
    TStringHelpers.HashMD5(lPontoSemanal.ID), TStringHelpers.HashMD5(lPontoSemanal.Nome),
    TStringHelpers.HashMD5(lPontoSemanal.DataAdmissao), TStringHelpers.HashMD5(lPontoSemanal.JornadaSemanal),
    TStringHelpers.HashMD5(lPontoSemanal.IntervaloAlmoco)
  ]);
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(FFolhaDePonto.Text));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lSegunda));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lTerca));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lQuarta));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lQuinta));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lSexta));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lSabado));

//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lPontoSemanal.ID));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lPontoSemanal.Nome));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lPontoSemanal.DataAdmissao));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lPontoSemanal.JornadaSemanal));
//  FFolhaDePonto.Add(TStringHelpers.HashMD5(lPontoSemanal.IntervaloAlmoco));

  AdicionarLinhaHash(lPontoSemanal.Segunda);
  AdicionarLinhaHash(lPontoSemanal.Terca);
  AdicionarLinhaHash(lPontoSemanal.Quarta);
  AdicionarLinhaHash(lPontoSemanal.Quinta);
  AdicionarLinhaHash(lPontoSemanal.Sexta);
  AdicionarLinhaHash(lPontoSemanal.Sabado);

  FFolhaDePonto.AddStrings([
    TStringHelpers.HashMD5(lSegunda), TStringHelpers.HashMD5(lTerca), TStringHelpers.HashMD5(lQuarta),
    TStringHelpers.HashMD5(lQuinta), TStringHelpers.HashMD5(lSexta), TStringHelpers.HashMD5(lSabado)
  ]);

  FFolhaDePonto.Add(TStringHelpers.HashMD5(FFolhaDePonto.Text));
end;

function TConstrutor.RetornarHorariosDoDia(pDiaSemana: TDiaSemana): THorarios;
var
  lDiaHorarios: THorariosDia;
begin
  case pDiaSemana of
    dsSegunda: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Segunda;
    dsTerca: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Terca;
    dsQuarta: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Quarta;
    dsQuinta: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Quinta;
    dsSexta: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Sexta;
    dsSabado: lDiaHorarios := TFolhaPontoSemanalSingleton.ObterInstancia.Sabado;
    else Exit;
  end;

  Result.Entrada := lDiaHorarios.Entrada;
  Result.SaidaAlmoco := IfThen(pDiaSemana <> dsSabado, lDiaHorarios.SaidaAlmoco, '  -  ');
  Result.RetornoAlmoco := IfThen(pDiaSemana <> dsSabado, lDiaHorarios.RetornoAlmoco, '  -  ');
  Result.SaidaFinal := lDiaHorarios.SaidaFinal;
  Result.Total := lDiaHorarios.Desempenho.TotalTrabalhado;
end;

procedure TConstrutor.ConstruirSaldoDeHoras;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lHorasFaltantes, lHorasExcedentes: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lHorasFaltantes := '  -  ';
  lHorasExcedentes := '  -  ';

  case lPontoSemanal.Desempenho.CumprimentoHorario of
    chAcima: lHorasExcedentes := lPontoSemanal.Desempenho.SaldoHoras;
    chAbaixo: lHorasFaltantes := lPontoSemanal.Desempenho.SaldoHoras;
    else ;
  end;

  FLayout.CarregarLayoutSaldoDeHorasSemana;
  FLayout.TotalHorasSemana := lPontoSemanal.Desempenho.TotalTrabalhado;
  FLayout.HorasFaltantes := lHorasFaltantes;
  FLayout.HorasExcedentes := lHorasExcedentes;

//  FolhaDePonto.Add(' |'.PadRight(88, ' ') + '| ');
//  FolhaDePonto.Add(RetornarLinhaTotalHoras);
//  FolhaDePonto.Add(RetornarLinhaHorasFaltantes);
//  FolhaDePonto.Add(RetornarLinhaHorasExcedentes);
//  FolhaDePonto.Add(' |'.PadRight(88, ' ') + '| ');
//  FolhaDePonto.Add(' \'.PadRight(88, '_') + '/ ');
end;

procedure TConstrutor.ConstruirTituloHorarios;
begin
  FLayout.CarregarLayoutTituloHorarios;
//  FFolhaDePonto.Add('  ______________________________________________________________________________________');
//  FFolhaDePonto.Add(' /                |         |              |                |             |             \ ');
//  FFolhaDePonto.Add(' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ');
//  FFolhaDePonto.Add(' |                |         |              |                |             |             | ');
//  ConstruirLinhaDivisaoHorarios;
end;

constructor TConstrutor.Create;
begin
  FFolhaDePonto := TStringList.Create;
  FLayout := TLayout.Create;
  FFolhaDePonto.Clear;
end;

function TConstrutor.GetFolhaDePonto: TStringList;
begin
  Result := FFolhaDePonto;
end;

function TConstrutor.RetornarHashHorario(pRegistroHorario: TRegistroHorario; pDia: THorariosDia): string;
var
  lHorario: string;
begin
  case pRegistroHorario of
    rhEntrada: lHorario := pDia.Entrada;
    rhSaidaAlmoco: lHorario := pDia.SaidaAlmoco;
    rhRetornoAlmoco: lHorario := pDia.RetornoAlmoco;
    rhSaidaFinal: lHorario := pDia.SaidaFinal;
  end;

  Result := TStringHelpers.HashMD5(lHorario);
end;

procedure TConstrutor.AdicionarLinhaHash(pDia: THorariosDia);
begin
  FFolhaDePonto.Add(RetornarHashHorario(rhEntrada, pDia));

  if not (pDia.SaidaAlmoco.Trim = EmptyStr) and not (pDia.RetornoAlmoco.Trim = EmptyStr) then
  begin
    FFolhaDePonto.Add(RetornarHashHorario(rhSaidaAlmoco, pDia));
    FFolhaDePonto.Add(RetornarHashHorario(rhRetornoAlmoco, pDia));
  end;

  FFolhaDePonto.Add(RetornarHashHorario(rhSaidaFinal, pDia));
end;

//procedure TConstrutor.Layout;
//  procedure LayoutSetCodigoFuncionar(aValue: string);
//  begin
//    FLayout[4] := FLayout[4].Replace('XXXXXXX', aValue);
//  end;
//begin
//
//  FLayout[0] := ' =====================================';
//  FLayout[1] := ' Registro de Ponto Semanal - Histórico';
//  FLayout[2] := ' =====================================';
//  FLayout[3] := ' ';
//  FLayout[4] := ' Código...........: XXXXXXX';
//  FLayout[5] := ' Funcionário......: XXXXXXXXXXXXXXXXXXXXXXXXX';
//  FLayout[6] := ' Admissão.........: XXXXXXXXX';
//  FLayout[7] := ' Jornada Semanal..: XXXXXX';
//  FLayout[8] := ' Intervalo Almoço.: XXXXXX';
//  FLayout[9] := ' ';
//  FLayout[10] := '  ______________________________________________________________________________________  ';
//  FLayout[11] := ' /                |         |              |                |             |             \ ';
//  FLayout[12] := ' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ';
//  FLayout[13] := ' |                |         |              |                |             |             | ';
//  FLayout[14] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[15] := ' | Segunda-Feira  |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ';
//  FLayout[16] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[17] := ' | Terça-Feira    |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ';
//  FLayout[18] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[19] := ' | Quarta-Feira   |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ';
//  FLayout[20] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[21] := ' | Quinta-Feira   |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ';
//  FLayout[22] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[23] := ' | Sexta-Feira    |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ';
//  FLayout[24] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[25] := ' | Sábado         |  XX:XX  |      -       |       -        |    XX:XX    |    XX:XX    | ';
//  FLayout[26] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
//  FLayout[27] := ' |                                                                                      | ';
//  FLayout[28] := ' |                                    Total de horas trabalhadas na semana:    XX:XX    | ';
//  FLayout[29] := ' |                                                 Horas/minutos faltantes:    XX:XX    | ';
//  FLayout[30] := ' |                                                Horas/minutos excedentes:    XX:XX    | ';
//  FLayout[31] := ' |                                                                                      | ';
//  FLayout[32] := ' \______________________________________________________________________________________/ ';
//
//  LayoutSetCodigoFuncionar('0');
//end;

end.
