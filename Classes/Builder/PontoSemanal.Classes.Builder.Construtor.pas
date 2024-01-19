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
    function RetornarHashHorario(pRegistroHorario: TRegistroHorario; pDia: THorariosDia): string;
    procedure AdicionarLinhaHash(pDia: THorariosDia);
    function RetornarHorariosDoDia(pDiaSemana: TDiaSemana): TLayoutHorarios;
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
    procedure ConstruirRodape;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, 
  System.StrUtils, System.SysUtils,
  PontoSemanal.Helpers.Strings, PontoSemanal.Helpers.Constantes,
  System.RegularExpressions;

{ TConstrutor }

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
end;

procedure TConstrutor.ConstruirHorarioQuinta;
begin
  FLayout.CarregarLayoutQuinta;
  FLayout.Quinta := RetornarHorariosDoDia(dsQuinta);
end;

procedure TConstrutor.ConstruirHorarioSabado;
begin
  FLayout.CarregarLayoutSabado;
  FLayout.Sabado := RetornarHorariosDoDia(dsSabado);
end;

procedure TConstrutor.ConstruirHorarioSegunda;
begin
  FLayout.CarregarLayoutSegunda;
  FLayout.Segunda := RetornarHorariosDoDia(dsSegunda);
end;

procedure TConstrutor.ConstruirHorarioSexta;
begin
  FLayout.CarregarLayoutSexta;
  FLayout.Sexta := RetornarHorariosDoDia(dsSexta);
end;

procedure TConstrutor.ConstruirHorarioTerca;
begin
  FLayout.CarregarLayoutTerca;
  FLayout.Terca := RetornarHorariosDoDia(dsTerca);;
end;

procedure TConstrutor.ConstruirRodape;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  lSegunda := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsSegunda);
  lTerca := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsTerca);
  lQuarta := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsQuarta);
  lQuinta := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsQuinta);
  lSexta := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsSexta);
  lSabado := TStringHelpers.AgruparHorarios(FLayout.Layout.Text, dsSabado);

  FFolhaDePonto := FLayout.Layout;

  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');
  FFolhaDePonto.Add('');

  FFolhaDePonto.AddStrings([
    TStringHelpers.HashMD5(lPontoSemanal.ID), TStringHelpers.HashMD5(lPontoSemanal.Nome),
    TStringHelpers.HashMD5(lPontoSemanal.DataAdmissao), TStringHelpers.HashMD5(lPontoSemanal.JornadaSemanal),
    TStringHelpers.HashMD5(lPontoSemanal.IntervaloAlmoco)
  ]);

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

function TConstrutor.RetornarHorariosDoDia(pDiaSemana: TDiaSemana): TLayoutHorarios;
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
end;

procedure TConstrutor.ConstruirTituloHorarios;
begin
  FLayout.CarregarLayoutTituloHorarios;
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

end.
