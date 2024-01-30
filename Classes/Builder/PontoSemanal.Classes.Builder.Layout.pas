unit PontoSemanal.Classes.Builder.Layout;

interface

uses
  System.Classes, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Helpers.Constantes;

type
  TLayout = class
  private
    FLayout: TStringList;
//    procedure AlterarValor(pValor: string; pLinha: Integer; pValorAntigo: string); overload;
//    procedure AlterarValor(pValor: TLayoutHorarios; pLinha: Integer); overload;
//    procedure AlterarValorEntrada(pValor: string; pLinha: Integer);
//    procedure AlterarValorSaidaAlmoco(pValor: string; pLinha: Integer);
//    procedure AlterarValorRetornoAlmoco(pValor: string; pLinha: Integer);
//    procedure AlterarValorSaidaFinal(pValor: string; pLinha: Integer);
//    procedure AlterarValorTotalHoras(pValor: string; pLinha: Integer);
//    procedure SetCodigo(const pValor: string);
//    procedure SetFuncionario(const pValor: string);
//    procedure SetAdmissao(const pValor: string);
//    procedure SetJornadaSemanal(const pValor: string);
//    procedure SetIntervaloAlmoco(const pValor: string);
//    procedure SetSegunda(const pValor: TLayoutHorarios);
//    procedure SetTerca(const pValor: TLayoutHorarios);
//    procedure SetQuarta(const pValor: TLayoutHorarios);
//    procedure SetQuinta(const pValor: TLayoutHorarios);
//    procedure SetSexta(const pValor: TLayoutHorarios);
//    procedure SetSabado(const pValor: TLayoutHorarios);
//    procedure SetTotalHorasSemana(const pValor: string);
//    procedure SetHorasFaltantes(const pValor: string);
//    procedure SetHorasExcedentes(const pValor: string);
    procedure ProcessarLinha(const pLinha: Integer; const pValor, pMascara: string);
    procedure ProcessarDia(const pLinha: Integer; const pDias: array of TArray<string>);
  public
    constructor Create;
    property Layout: TStringList read FLayout write FLayout;
//    property Codigo: string write SetCodigo;
//    property Funcionario: string write SetFuncionario;
//    property Admissao: string write SetAdmissao;
//    property JornadaSemanal: string write SetJornadaSemanal;
//    property IntervaloAlmoco: string write SetIntervaloAlmoco;
//    property Segunda: TLayoutHorarios write SetSegunda;
//    property Terca: TLayoutHorarios write SetTerca;
//    property Quarta: TLayoutHorarios write SetQuarta;
//    property Quinta: TLayoutHorarios write SetQuinta;
//    property Sexta: TLayoutHorarios write SetSexta;
//    property Sabado: TLayoutHorarios write SetSabado;
//    property TotalHorasSemana: string write SetTotalHorasSemana;
//    property HorasFaltantes: string write SetHorasFaltantes;
//    property HorasExcedentes: string write SetHorasExcedentes;
    procedure CarregarLayoutCabecalho;
    procedure CarregarLayoutHorarios;
//    procedure CarregarLayoutDadosFuncionario;
//    procedure CarregarLayoutTituloHorarios;
//    procedure CarregarLayoutSegunda;
//    procedure CarregarLayoutTerca;
//    procedure CarregarLayoutQuarta;
//    procedure CarregarLayoutQuinta;
//    procedure CarregarLayoutSexta;
//    procedure CarregarLayoutSabado;
    procedure CarregarLayoutSaldoDeHorasSemana;
    procedure ProcessarDadosFuncionario(const pDados: array of string);
    procedure ProcessarHorarioSemanal(const pDias: array of TLayoutHorarios);
    procedure ProcessarSaldoHoras(const pLinha: Integer; const pDias: array of TArray<string>);
  end;

var
  LayoutFormato: array[0..32] of string = (
    ' ===================================== ',
    ' Registro de Ponto Semanal - Histórico ',
    ' ===================================== ',
    ' ',
    ' Código...........: X',
    ' Funcionário......: X',
    ' Admissão.........: X',
    ' Jornada Semanal..: X',
    ' Intervalo Almoço.: X',
    ' ',
    '  ______________________________________________________________________________________  ',
    ' /                |         |              |                |             |             \ ',
    ' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ',
    ' |                |         |              |                |             |             | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Segunda-Feira  |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Terça-Feira    |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Quarta-Feira   |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Quinta-Feira   |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Sexta-Feira    |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' | Sábado         |  XX:XX  |    XX:XX     |     XX:XX      |    XX:XX    |    XX:XX    | ',
    ' |----------------|---------|--------------|----------------|-------------|-------------| ',
    ' |                                                                                      | ',
    ' |                                    Total de horas trabalhadas na semana:    XXX:XX   | ',
    ' |                                                 Horas/minutos faltantes:    XXX:XX   | ',
    ' |                                                Horas/minutos excedentes:    XXX:XX   | ',
    ' |                                                                                      | ',
    ' \______________________________________________________________________________________/ '
  );

implementation

uses
  System.SysUtils;

{ TLayout }

//procedure TLayout.AlterarValor(pValor: string; pLinha: Integer; pValorAntigo: string);
//begin
//  Layout[pLinha] := StringReplace(Layout[pLinha], pValorAntigo, pValor, [rfReplaceAll]);
//end;

//procedure TLayout.AlterarValor(pValor: TLayoutHorarios; pLinha: Integer);
//begin
//  AlterarValorEntrada(pValor.Entrada, pLinha);
//  AlterarValorSaidaAlmoco(pValor.SaidaAlmoco, pLinha);
//  AlterarValorRetornoAlmoco(pValor.RetornoAlmoco, pLinha);
//  AlterarValorSaidaFinal(pValor.SaidaFinal, pLinha);
//  AlterarValorTotalHoras(pValor.Total, pLinha);
//end;

procedure TLayout.CarregarLayoutCabecalho;
begin
  Layout.Clear;

  for var I := 0 to 9 do
  begin
    Layout[I] := LayoutFormato[I]
  end;
end;

procedure TLayout.CarregarLayoutHorarios;
begin
  for var I := 10 to 26 do
  begin
    Layout[I] := LayoutFormato[I];
  end;
end;

procedure TLayout.CarregarLayoutSaldoDeHorasSemana;
begin
  for var I := 27 to 32 do
  begin
    Layout[I] := LayoutFormato[I];
  end;
end;

procedure TLayout.ProcessarDadosFuncionario(const pDados: array of string);
begin
  for var lLinha := Ord(Low(TLayoutLinha)) to Ord(High(TLayoutLinha)) do
  begin
    if not (lLinha in TConstantes.LINHAS_LAYOUT_DADOS_FUNCIONARIOS) then
    begin
      Continue;
    end;

    ProcessarLinha(lLinha, pDados[lLinha], 'X');
  end;
end;

procedure TLayout.ProcessarDia(const pLinha: Integer; const pDias: array of TArray<string>);
  procedure ProcessaLinha(const pLinha: Integer; const pValues: array of string);
  begin
    for var I := 0 to Pred(Length(pValues)) do
    begin
      if Layout[pLinha].Contains('XX:XX') then
      begin
        Break;
      end;

      Layout[pLinha] := Layout[pLinha].Replace('XX:XX', pValues[I]);
    end;
  end;

begin
//  for var vLinha in [4, 15, 17, 19, 21, 23, 25] do
//  begin
//    for var vDia in pDias do
//    begin
//      ProcessaLinha(vLinha, vDia);
//    end;
//  end
  for var lLinha := Low(TLayoutLinha) to High(TLayoutLinha) do
  begin

  end;
end;

procedure TLayout.ProcessarHorarioSemanal(const pDias: array of TLayoutHorarios);

  function RetornarHorariosDia(const lLinha: Integer; const p);
  begin
    ProcessarLinha(lLinha, pHorarios.Entrada, 'XX:XX');
    ProcessarLinha(lLinha, pHorarios.SaidaAlmoco, 'XX:XX');
    ProcessarLinha(lLinha, pHorarios.RetornoAlmoco, 'XX:XX');
    ProcessarLinha(lLinha, pHorarios.SaidaFinal, 'XX:XX');
    ProcessarLinha(lLinha, pHorarios.Total, 'XX:XX');
  end;
begin
  for var lLinha := Ord(Low(TLayoutLinha)) to Ord(High(TLayoutLinha)) do
  begin
    if not (lLinha in TConstantes.LINHAS_LAYOUT_HORARIOS_SEMANA) then
    begin
      Continue;
    end;

    ProcessarDia(lLinha, pDias[lLinha]);
  end;
end;

procedure TLayout.ProcessarLinha(const pLinha: Integer; const pValor, pMascara: string);
begin
  Layout[pLinha] := Layout[pLinha].Replace(pMascara, pValor);
end;

procedure TLayout.ProcessarSaldoHoras(const pLinha: Integer; const pDias: array of TArray<string>);
begin

end;

//procedure TLayout.AlterarValorTotalHoras(pValor: string; pLinha: Integer);
//begin
//  AlterarValor(pValor, pLinha, 'TO:HO');
//end;
//
//procedure TLayout.AlterarValorSaidaFinal(pValor: string; pLinha: Integer);
//begin
//  AlterarValor(pValor, pLinha, 'SA:FI');
//end;
//
//procedure TLayout.AlterarValorRetornoAlmoco(pValor: string; pLinha: Integer);
//begin
//  AlterarValor(pValor, pLinha, 'RE:AL');
//end;
//
//procedure TLayout.AlterarValorSaidaAlmoco(pValor: string; pLinha: Integer);
//begin
//  AlterarValor(pValor, pLinha, 'SA:AL');
//end;
//
//procedure TLayout.AlterarValorEntrada(pValor: string; pLinha: Integer);
//begin
//  AlterarValor(pValor, pLinha, 'EN:TR');
//end;

constructor TLayout.Create;
begin
  FLayout := TStringList.Create;
end;

//procedure TLayout.SetAdmissao(const pValor: string);
//begin
//  AlterarValor(pValor, Ord(llAdmissao), 'X');
//end;
//
//procedure TLayout.SetCodigo(const pValor: string);
//begin
//  AlterarValor(pValor, Ord(llCodigo), 'X');
//end;
//
//procedure TLayout.SetFuncionario(const pValor: string);
//begin
//  AlterarValor(pValor, Ord(llFuncionario), 'X');
//end;
//
//procedure TLayout.SetIntervaloAlmoco(const pValor: string);
//begin
//  AlterarValor(pValor, Ord(llIntervalo), 'X');
//end;
//
//procedure TLayout.SetJornadaSemanal(const pValor: string);
//begin
//  AlterarValor(pValor, Ord(llJornada), 'X');
//end;

//procedure TLayout.SetSegunda(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llSegunda));
//end;
//
//procedure TLayout.SetTerca(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llTerca));
//end;
//
//procedure TLayout.SetQuarta(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llQuarta));
//end;
//
//procedure TLayout.SetQuinta(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llQuinta));
//end;
//
//procedure TLayout.SetSexta(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llSexta));
//end;
//
//procedure TLayout.SetSabado(const pValor: TLayoutHorarios);
//begin
//  AlterarValor(pValor, Ord(llSabado));
//end;
//
//procedure TLayout.SetTotalHorasSemana(const pValor: string);
//begin
//  AlterarValor(pValor.PadLeft(6, ' '), Ord(llTotalHorasSemana), 'XXX:XX');
//end;
//
//procedure TLayout.SetHorasExcedentes(const pValor: string);
//begin
//  AlterarValor(pValor.PadLeft(6, ' '), Ord(llHorasExcedentes), 'XXX:XX');
//end;
//
//procedure TLayout.SetHorasFaltantes(const pValor: string);
//begin
//  AlterarValor(pValor.PadLeft(6, ' '), Ord(llHorasFaltantes), 'XXX:XX');
//end;

end.
