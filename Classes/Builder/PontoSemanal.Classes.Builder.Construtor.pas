unit PontoSemanal.Classes.Builder.Construtor;

interface

uses
  PontoSemanal.Interfaces.Builder.FolhaDePonto, System.Classes, 
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares;

type
  TConstrutor = class(TInterfacedObject, IConstrutor)
  private
    FFolhaDePonto: TStringList;
    function GetFolhaDePonto: TStringList;
    function RetornarLinhaDiaDaSemana(pDia: THorariosDia): string;
    function RetornarLinhaTotalHoras: string;
    function RetornarLinhaHorasFaltantes: string;
    function RetornarLinhaHorasExcedentes: string;
    function ConcatenarHorarios(pDia: THorariosDia): string;
    function RetornarHashHorario(pRegistroHorario: TRegistroHorario; pDia: THorariosDia): string;
    procedure AdicionarLinhaHash(pDia: THorariosDia);
  public
    constructor Create;
    property FolhaDePonto: TStringList read GetFolhaDePonto;
    procedure ConstruirCabecalho;
    procedure ConstruirDadosFuncionario;
    procedure ConstruirTituloHorarios;
    procedure ConstruirHorarioSegunda;
    procedure ConstruirHorarioTerca;
    procedure ConstruirHorarioQuarta;
    procedure ConstruirHorarioQuinta;
    procedure ConstruirHorarioSexta;
    procedure ConstruirHorarioSabado;
    procedure ConstruirSaldoDeHoras;
    procedure ConstruirLinhaDivisaoHorarios;
    procedure ConstruirRodape;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, 
  System.StrUtils, System.SysUtils,
  PontoSemanal.Helpers.Strings, PontoSemanal.Helpers.Constantes;

{ TConstrutor }

function TConstrutor.RetornarLinhaDiaDaSemana(pDia: THorariosDia): string;
var
  lDiaNome, lSaidaAlmoco, lRetornoAlmoco, lLinhaMontada: string;
begin
  lSaidaAlmoco := '  -  ' ;
  lRetornoAlmoco := '  -  ';

  if pDia.Tag <> dsSabado then
  begin
    lSaidaAlmoco := IfThen(pDia.SaidaAlmoco.Trim = EmptyStr, '00:00', pDia.SaidaAlmoco);
    lRetornoAlmoco := IfThen(pDia.RetornoAlmoco.Trim = EmptyStr, '00:00', pDia.RetornoAlmoco);
  end;

  lSaidaAlmoco := lSaidaAlmoco.PadRight(10, ' ').PadLeft(14, ' ');
  lRetornoAlmoco := lRetornoAlmoco.PadRight(11, ' ').PadLeft(16, ' ');
  lDiaNome := pDia.PegarNomeDaSemana(True, True).PadRight(15, ' ');

  lLinhaMontada := lDiaNome + '|  ' + pDia.Entrada + '  |' + lSaidaAlmoco + '|' + lRetornoAlmoco + '|    ' +
    pDia.SaidaFinal.PadRight(9, ' ') + '|' + pDia.Desempenho.TotalTrabalhado.PadLeft(9, ' ');

  Result := lLinhaMontada;
end;

function TConstrutor.RetornarLinhaHorasExcedentes: string;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSaldoHoras, lLinha: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lSaldoHoras := lPontoSemanal.Desempenho.SaldoHoras.PadRight(9, ' ');
  lLinha := EmptyStr;

  case lPontoSemanal.Desempenho.CumprimentoHorario of
    chAcima: lLinha := 'Horas/minutos excedentes:    '.PadLeft(77, ' ') + lSaldoHoras;
    else lLinha := 'Horas/minutos excedentes:      -      '.PadLeft(86, ' ');
  end;

  Result := ' |' + lLinha + '|';
end;

function TConstrutor.RetornarLinhaHorasFaltantes: string;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSaldoHoras, lLinha: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lSaldoHoras := lPontoSemanal.Desempenho.SaldoHoras.PadRight(9, ' ');
  lLinha := EmptyStr;

  case lPontoSemanal.Desempenho.CumprimentoHorario of
    chAbaixo: lLinha := 'Horas/minutos faltantes:    '.PadLeft(77, ' ') + lSaldoHoras;
    else lLinha := 'Horas/minutos faltantes:      -      '.PadLeft(86, ' ');
  end;

  Result := ' |' + lLinha + '|';
end;

function TConstrutor.RetornarLinhaTotalHoras: string;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lLinha: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lLinha := 'Total de horas trabalhadas na semana:    '.PadLeft(77, ' ') + lPontoSemanal.Desempenho.TotalTrabalhado;
  lLinha := ' |' + lLinha.PadRight(86, ' ') + '|';
  Result := lLinha;
end;

function TConstrutor.ConcatenarHorarios(pDia: THorariosDia): string;
begin
  Result := pDia.Entrada + pDia.SaidaAlmoco + pDia.RetornoAlmoco + pDia.SaidaFinal;
end;

procedure TConstrutor.ConstruirCabecalho;
begin
  FolhaDePonto.Add(' =====================================');
  FolhaDePonto.Add(' Registro de Ponto Semanal - Histórico');
  FolhaDePonto.Add(' =====================================');
  FolhaDePonto.Add(' ');
end;

procedure TConstrutor.ConstruirDadosFuncionario;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  
  FolhaDePonto.Add(' Código...........: ' + lPontoSemanal.ID);
  FolhaDePonto.Add(' Funcionário......: ' + lPontoSemanal.Nome);
  FolhaDePonto.Add(' Admissão.........: ' + lPontoSemanal.DataAdmissao + ' ' + lPontoSemanal.TempoAdmissao);
  FolhaDePonto.Add(' Jornada Semanal..: ' + lPontoSemanal.JornadaSemanal + ' horas');
  FolhaDePonto.Add(' Intervalo Almoço.: ' + lPontoSemanal.IntervaloAlmoco + ' -> ' + lPontoSemanal.IntervaloAlmocoExtenso);
  FolhaDePonto.Add(' ');
end;

procedure TConstrutor.ConstruirHorarioQuarta;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Quarta;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioQuinta;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Quinta;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSabado;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Sabado;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSegunda;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Segunda;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioSexta;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Sexta;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirHorarioTerca;
var
  lHorariosDia: THorariosDia;
begin
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Terca;
  FFolhaDePonto.Add(' | ' + RetornarLinhaDiaDaSemana(lHorariosDia) + '    | ');
  ConstruirLinhaDivisaoHorarios;
end;

procedure TConstrutor.ConstruirLinhaDivisaoHorarios;
var
  lLinha: string;
begin
  lLinha := ' |'.PadRight(17, '-');
  lLinha := lLinha + '-|'.PadRight(10, '-');
  lLinha := lLinha + '-|'.PadRight(15, '-');
  lLinha := lLinha + '-|'.PadRight(17, '-');
  lLinha := lLinha + '-|'.PadRight(14, '-');
  lLinha := lLinha + '-|'.PadRight(15, '-') + '| ';

  FFolhaDePonto.Add(lLinha);
end;

procedure TConstrutor.ConstruirRodape;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  lSegunda := ConcatenarHorarios(lPontoSemanal.Segunda);
  lTerca := ConcatenarHorarios(lPontoSemanal.Terca);
  lQuarta := ConcatenarHorarios(lPontoSemanal.Quarta);
  lQuinta := ConcatenarHorarios(lPontoSemanal.Quinta);
  lSexta := ConcatenarHorarios(lPontoSemanal.Sexta);
  lSabado := ConcatenarHorarios(lPontoSemanal.Sabado);

  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('[Folha]: ' + TStringHelpers.HashMD5(FFolhaDePonto.Text));
  FFolhaDePonto.Add('[Segunda]: ' + TStringHelpers.HashMD5(lSegunda));
  FFolhaDePonto.Add('[Terca]: ' + TStringHelpers.HashMD5(lTerca));
  FFolhaDePonto.Add('[Quarta]: ' + TStringHelpers.HashMD5(lQuarta));
  FFolhaDePonto.Add('[Quinta]: ' + TStringHelpers.HashMD5(lQuinta));
  FFolhaDePonto.Add('[Sexta]: ' + TStringHelpers.HashMD5(lSexta));
  FFolhaDePonto.Add('[Sabado]: ' + TStringHelpers.HashMD5(lSabado));

  FFolhaDePonto.Add('[Funcionario-Codigo]: ' + TStringHelpers.HashMD5(lPontoSemanal.ID));
  FFolhaDePonto.Add('[Funcionario-Nome]: ' + TStringHelpers.HashMD5(lPontoSemanal.Nome));
  FFolhaDePonto.Add('[Funcionario-Admissao]: ' + TStringHelpers.HashMD5(lPontoSemanal.DataAdmissao));
  FFolhaDePonto.Add('[Funcionario-Jornada]: ' + TStringHelpers.HashMD5(lPontoSemanal.JornadaSemanal));
  FFolhaDePonto.Add('[Funcionario-Intervalo]: ' + TStringHelpers.HashMD5(lPontoSemanal.IntervaloAlmoco));

  AdicionarLinhaHash(lPontoSemanal.Segunda);
  AdicionarLinhaHash(lPontoSemanal.Terca);
  AdicionarLinhaHash(lPontoSemanal.Quarta);
  AdicionarLinhaHash(lPontoSemanal.Quinta);
  AdicionarLinhaHash(lPontoSemanal.Sexta);
  AdicionarLinhaHash(lPontoSemanal.Sabado);
end;

procedure TConstrutor.ConstruirSaldoDeHoras;
begin
  FolhaDePonto.Add(' |'.PadRight(88, ' ') + '| ');
  FolhaDePonto.Add(RetornarLinhaTotalHoras);
  FolhaDePonto.Add(RetornarLinhaHorasFaltantes);
  FolhaDePonto.Add(RetornarLinhaHorasExcedentes);
  FolhaDePonto.Add(' |'.PadRight(88, ' ') + '| ');
  FolhaDePonto.Add(' \'.PadRight(88, '_') + '/ ');
end;

procedure TConstrutor.ConstruirTituloHorarios;
begin
  FFolhaDePonto.Add('  ______________________________________________________________________________________');
  FFolhaDePonto.Add(' /                |         |              |                |             |             \ ');
  FFolhaDePonto.Add(' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ');
  FFolhaDePonto.Add(' |                |         |              |                |             |             | ');
  ConstruirLinhaDivisaoHorarios;
end;

constructor TConstrutor.Create;
begin
  FFolhaDePonto := TStringList.Create;
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

  Result := TStringHelpers.HashMD5(lHorario + TConstantes.HASH_SALTING);
end;

procedure TConstrutor.AdicionarLinhaHash(pDia: THorariosDia);
var
  lDia: string;
begin
  lDia := pDia.PegarNomeDaSemana;

  FFolhaDePonto.Add('[' + lDia + '-Entrada]: ' + RetornarHashHorario(rhEntrada, pDia));

  if not (pDia.SaidaAlmoco.Trim = EmptyStr) and not (pDia.RetornoAlmoco.Trim = EmptyStr) then
  begin
    FFolhaDePonto.Add('[' + lDia + '-SaidaAlmoco]: ' + RetornarHashHorario(rhSaidaAlmoco, pDia));
    FFolhaDePonto.Add('[' + lDia + '-RetornoAlmoco]: ' + RetornarHashHorario(rhRetornoAlmoco, pDia));
  end;

  FFolhaDePonto.Add('[' + lDia + '-SaidaFinal]: ' + RetornarHashHorario(rhSaidaFinal, pDia));
end;

end.
