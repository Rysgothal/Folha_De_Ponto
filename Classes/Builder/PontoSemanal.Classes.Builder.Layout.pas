unit PontoSemanal.Classes.Builder.Layout;

interface

uses
  System.Classes, PontoSemanal.Helpers.TiposAuxiliares;

type
  TLayout = class
  private
    FLayout: TStringList;
    procedure AlterarValor(pValor: string; pLinha: Integer; pValorAntigo: string); overload;
    procedure AlterarValor(pValor: TLayoutHorarios; pLinha: Integer); overload;
    procedure AlterarValorEntrada(pValor: string; pLinha: Integer);
    procedure AlterarValorSaidaAlmoco(pValor: string; pLinha: Integer);
    procedure AlterarValorRetornoAlmoco(pValor: string; pLinha: Integer);
    procedure AlterarValorSaidaFinal(pValor: string; pLinha: Integer);
    procedure AlterarValorTotalHoras(pValor: string; pLinha: Integer);
    procedure SetCodigo(const pValor: string);
    procedure SetFuncionario(const pValor: string);
    procedure SetAdmissao(const pValor: string);
    procedure SetJornadaSemanal(const pValor: string);
    procedure SetIntervaloAlmoco(const pValor: string);
    procedure SetSegunda(const pValor: TLayoutHorarios);
    procedure SetTerca(const pValor: TLayoutHorarios);
    procedure SetQuarta(const pValor: TLayoutHorarios);
    procedure SetQuinta(const pValor: TLayoutHorarios);
    procedure SetSexta(const pValor: TLayoutHorarios);
    procedure SetSabado(const pValor: TLayoutHorarios);
    procedure SetTotalHorasSemana(const pValor: string);
    procedure SetHorasFaltantes(const pValor: string);
    procedure SetHorasExcedentes(const pValor: string);
  public
    constructor Create;
    property Layout: TStringList read FLayout write FLayout;
    property Codigo: string write SetCodigo;
    property Funcionario: string write SetFuncionario;
    property Admissao: string write SetAdmissao;
    property JornadaSemanal: string write SetJornadaSemanal;
    property IntervaloAlmoco: string write SetIntervaloAlmoco;
    property Segunda: TLayoutHorarios write SetSegunda;
    property Terca: TLayoutHorarios write SetTerca;
    property Quarta: TLayoutHorarios write SetQuarta;
    property Quinta: TLayoutHorarios write SetQuinta;
    property Sexta: TLayoutHorarios write SetSexta;
    property Sabado: TLayoutHorarios write SetSabado;
    property TotalHorasSemana: string write SetTotalHorasSemana;
    property HorasFaltantes: string write SetHorasFaltantes;
    property HorasExcedentes: string write SetHorasExcedentes;
//    procedure CarregarLayout;
    procedure CarregarLayoutCabecalho;
    procedure CarregarLayoutDadosFuncionario;
    procedure CarregarLayoutTituloHorarios;
    procedure CarregarLayoutSegunda;
    procedure CarregarLayoutTerca;
    procedure CarregarLayoutQuarta;
    procedure CarregarLayoutQuinta;
    procedure CarregarLayoutSexta;
    procedure CarregarLayoutSabado;
    procedure CarregarLayoutSaldoDeHorasSemana;
  end;

implementation

uses
  System.SysUtils;

{ TLayout }

procedure TLayout.AlterarValor(pValor: string; pLinha: Integer; pValorAntigo: string);
begin
  Layout[pLinha] := StringReplace(Layout[pLinha], pValorAntigo, pValor, [rfReplaceAll]);
end;

procedure TLayout.AlterarValor(pValor: TLayoutHorarios; pLinha: Integer);
begin
  AlterarValorEntrada(pValor.Entrada, pLinha);
  AlterarValorSaidaAlmoco(pValor.SaidaAlmoco, pLinha);
  AlterarValorRetornoAlmoco(pValor.RetornoAlmoco, pLinha);
  AlterarValorSaidaFinal(pValor.SaidaFinal, pLinha);
  AlterarValorTotalHoras(pValor.Total, pLinha);
end;

//procedure TLayout.CarregarLayout;
//begin
//  Layout.Clear;
//  CarregarLayoutCabecalho;
//  CarregarLayoutDadosFuncionario;
//  CarregarLayoutTituloHorarios;
//  CarregarLayoutSegunda;
//  CarregarLayoutTerca;
//  CarregarLayoutQuarta;
//  CarregarLayoutQuinta;
//  CarregarLayoutSexta;
//  CarregarLayoutSabado;
//  CarregarLayoutSaldoDeHorasSemana;
//end;

procedure TLayout.CarregarLayoutCabecalho;
begin
  Layout[0] := ' ===================================== ';
  Layout[1] := ' Registro de Ponto Semanal - Histórico ';
  Layout[2] := ' ===================================== ';
  Layout[3] := ' ';
end;

procedure TLayout.CarregarLayoutDadosFuncionario;
begin
  Layout[4] := ' Código...........: X';
  Layout[5] := ' Funcionário......: X';
  Layout[6] := ' Admissão.........: X';
  Layout[7] := ' Jornada Semanal..: X';
  Layout[8] := ' Intervalo Almoço.: X';
  Layout[9] := ' ';
end;

procedure TLayout.CarregarLayoutTituloHorarios;
begin
  Layout[10] := '  ______________________________________________________________________________________  ';
  Layout[11] := ' /                |         |              |                |             |             \ ';
  Layout[12] := ' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ';
  Layout[13] := ' |                |         |              |                |             |             | ';
  Layout[14] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutSegunda;
begin
  Layout[15] := ' | Segunda-Feira  |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[16] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutTerca;
begin
  Layout[17] := ' | Terça-Feira    |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[18] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutQuarta;
begin
  Layout[19] := ' | Quarta-Feira   |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[20] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutQuinta;
begin
  Layout[21] := ' | Quinta-Feira   |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[22] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutSexta;
begin
  Layout[23] := ' | Sexta-Feira    |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[24] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutSabado;
begin
  Layout[25] := ' | Sábado         |  EN:TR  |    SA:AL     |     RE:AL      |    SA:FI    |    TO:HO    | ';
  Layout[26] := ' |----------------|---------|--------------|----------------|-------------|-------------| ';
end;

procedure TLayout.CarregarLayoutSaldoDeHorasSemana;
begin
  Layout[27] := ' |                                                                                      | ';
  Layout[28] := ' |                                    Total de horas trabalhadas na semana:    XXX:XX   | ';
  Layout[29] := ' |                                                 Horas/minutos faltantes:    XXX:XX   | ';
  Layout[30] := ' |                                                Horas/minutos excedentes:    XXX:XX   | ';
  Layout[31] := ' |                                                                                      | ';
  Layout[32] := ' \______________________________________________________________________________________/ ';
end;

procedure TLayout.AlterarValorTotalHoras(pValor: string; pLinha: Integer);
begin
  AlterarValor(pValor, pLinha, 'TO:HO');
end;

procedure TLayout.AlterarValorSaidaFinal(pValor: string; pLinha: Integer);
begin
  AlterarValor(pValor, pLinha, 'SA:FI');
end;

procedure TLayout.AlterarValorRetornoAlmoco(pValor: string; pLinha: Integer);
begin
  AlterarValor(pValor, pLinha, 'RE:AL');
end;

procedure TLayout.AlterarValorSaidaAlmoco(pValor: string; pLinha: Integer);
begin
  AlterarValor(pValor, pLinha, 'SA:AL');
end;

procedure TLayout.AlterarValorEntrada(pValor: string; pLinha: Integer);
begin
  AlterarValor(pValor, pLinha, 'EN:TR');
end;

constructor TLayout.Create;
var
  lArrayAux: array[0..32] of string;
begin
  FLayout := TStringList.Create;
  FLayout.Clear;
  FLayout.AddStrings(lArrayAux);
end;

procedure TLayout.SetAdmissao(const pValor: string);
begin
  AlterarValor(pValor, Ord(llAdmissao), 'X');
end;

procedure TLayout.SetCodigo(const pValor: string);
begin
  AlterarValor(pValor, Ord(llCodigo), 'X');
end;

procedure TLayout.SetFuncionario(const pValor: string);
begin
  AlterarValor(pValor, Ord(llFuncionario), 'X');
end;

procedure TLayout.SetIntervaloAlmoco(const pValor: string);
begin
  AlterarValor(pValor, Ord(llIntervalo), 'X');
end;

procedure TLayout.SetJornadaSemanal(const pValor: string);
begin
  AlterarValor(pValor, Ord(llJornada), 'X');
end;

procedure TLayout.SetSegunda(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llSegunda));
end;

procedure TLayout.SetTerca(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llTerca));
end;

procedure TLayout.SetQuarta(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llQuarta));
end;

procedure TLayout.SetQuinta(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llQuinta));
end;

procedure TLayout.SetSexta(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llSexta));
end;

procedure TLayout.SetSabado(const pValor: TLayoutHorarios);
begin
  AlterarValor(pValor, Ord(llSabado));
end;

procedure TLayout.SetTotalHorasSemana(const pValor: string);
begin
  AlterarValor(pValor.PadLeft(6, ' '), Ord(llTotalHorasSemana), 'XXX:XX');
end;

procedure TLayout.SetHorasExcedentes(const pValor: string);
begin
  AlterarValor(pValor.PadLeft(6, ' '), Ord(llHorasExcedentes), 'XXX:XX');
end;

procedure TLayout.SetHorasFaltantes(const pValor: string);
begin
  AlterarValor(pValor.PadLeft(6, ' '), Ord(llHorasFaltantes), 'XXX:XX');
end;

end.
