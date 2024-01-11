unit PontoSemanal.Classes.Builder.Construtor;

interface

uses
  PontoSemanal.Interfaces.Builder.FolhaDePonto, System.Classes, 
  PontoSemanal.Classes.Base.Horarios;

type
  TConstrutor = class(TInterfacedObject, IConstrutor)
  private
    FFolhaDePonto: TStringList;          
    function GetFolhaDePonto: TStringList;
    function RetornarLinhaDeHorarios(pDiaHorarios: THorariosDia): string;
  public                                        
    constructor Create;
    property FolhaDePonto: TStringList read GetFolhaDePonto write FFolhaDePonto;
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
  System.StrUtils, System.SysUtils, PontoSemanal.Helpers.TiposAuxiliares;

{ TConstrutor }

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
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

end;

procedure TConstrutor.ConstruirHorarioQuinta;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
end;

procedure TConstrutor.ConstruirHorarioSabado;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

end;

procedure TConstrutor.ConstruirHorarioSegunda;
var
//  lPontoSemanal: TFolhaPontoSemanalSingleton; 
  lHorariosDia: THorariosDia;
  lDiaNome, lSaidaAlmoco, lRetornoAlmoco, lHorariosNoMemo: string;
begin                                                      
  lHorariosDia := TFolhaPontoSemanalSingleton.ObterInstancia.Segunda;
  lDiaNome := lHorariosDia.PegarNomeDaSemana(True, True);

  lSaidaAlmoco := IfThen(lHorariosDia.SaidaAlmoco.Trim = EmptyStr, '00:00', lHorariosDia.SaidaAlmoco);
  lRetornoAlmoco := IfThen(lHorariosDia.RetornoAlmoco.Trim = EmptyStr, '00:00', lHorariosDia.RetornoAlmoco);
  
  lSaidaAlmoco := lSaidaAlmoco.PadRight(10, ' ').PadLeft(14, ' ');
  lRetornoAlmoco := lRetornoAlmoco.PadRight(11, ' ').PadLeft(16, ' ');

  lHorariosNoMemo := RetornarLinhaDeHorarios(lHorariosDia).PadRight(41, ' ');
  lHorariosNoMemo := lDiaNome.PadRight(15, ' ') + '|   ' + lHorariosNoMemo + '|    ' + lHorariosDia.Desempenho.TotalTrabalhado;

  FolhaDePonto.Add(' | ' + lHorariosNoMemo + '    | ');
end;

procedure TConstrutor.ConstruirHorarioSexta;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

end;

procedure TConstrutor.ConstruirHorarioTerca;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

end;

procedure TConstrutor.ConstruirLinhaDivisaoHorarios;
begin
  FFolhaDePonto.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
end;

procedure TConstrutor.ConstruirRodape;
begin

end;

procedure TConstrutor.ConstruirSaldoDeHoras;
begin

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

function TConstrutor.RetornarLinhaDeHorarios(pDiaHorarios: THorariosDia): string;
var
  lSaidaAlmoco, lRetornoAlmoco: string;
begin
  lSaidaAlmoco := IfThen(pDiaHorarios.SaidaAlmoco.Trim = EmptyStr, '00:00', pDiaHorarios.SaidaAlmoco);
  lRetornoAlmoco := IfThen(pDiaHorarios.RetornoAlmoco.Trim = EmptyStr, '00:00', pDiaHorarios.RetornoAlmoco);

  if pDiaHorarios.Tag = dsSabado then
  begin
    lSaidaAlmoco := '  -  ' ;
    lRetornoAlmoco := '  -  ';
  end;
  
  lSaidaAlmoco := lSaidaAlmoco.PadRight(10, ' ').PadLeft(14, ' ');
  lRetornoAlmoco := lRetornoAlmoco.PadRight(11, ' ').PadLeft(16, ' ');
  
  Result := pDiaHorarios.Entrada + ' |' + lSaidaAlmoco + '|' + lRetornoAlmoco + '|    ' + pDiaHorarios.SaidaFinal;
end;

end.
