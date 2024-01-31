unit PontoSemanal.Classes.Builder.Layout;

interface

uses
  System.Classes, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Helpers.Constantes, System.Generics.Collections;

type
  TLayout = class
  private
    FLayout: TStringList;
    procedure ProcessarLinha(const pLinha: Integer; const pValor, pMascara: string);
    procedure ProcessarGenerico(const pLinhas: array of Integer; const pDados: array of string; const pMascara: string); overload;
    procedure ProcessarGenerico(const pLinhas: Integer; const pDados, pMascara: string); overload;
  public
    constructor Create;
    property Layout: TStringList read FLayout write FLayout;
    procedure CarregarLayoutCabecalho;
    procedure CarregarLayoutHorarios;
    procedure CarregarLayoutSaldoDeHorasSemana;
    procedure ProcessarDadosFuncionario(const pDados: array of string);
    procedure ProcessarHorarioSemanal(const pDias: array of TLayoutHorarios);
    procedure ProcessarSaldoHoras(const pDados: array of string);
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

procedure TLayout.CarregarLayoutCabecalho;
begin
  Layout.Clear;

  for var I := 0 to 9 do
  begin
    Layout.Add(LayoutFormato[I]);
  end;
end;

procedure TLayout.CarregarLayoutHorarios;
begin
  for var I := 10 to 26 do
  begin
    Layout.Add(LayoutFormato[I]);
  end;
end;

procedure TLayout.CarregarLayoutSaldoDeHorasSemana;
begin
  for var I := 27 to 32 do
  begin
    Layout.Add(LayoutFormato[I]);
  end;
end;

procedure TLayout.ProcessarDadosFuncionario(const pDados: array of string);
begin
  ProcessarGenerico(TConstantes.LINHAS_LAYOUT_DADOS_FUNCIONARIOS, pDados, 'X');
end;

procedure TLayout.ProcessarGenerico(const pLinhas: Integer; const pDados, pMascara: string);
begin
  ProcessarGenerico([pLinhas], [pDados], pMascara);
end;

procedure TLayout.ProcessarGenerico(const pLinhas: array of Integer; const pDados: array of string; const pMascara: string);
var
  lItem, lIndexEncontrado: Integer;
begin
  lItem := -1;

  for var lLinha := Ord(Low(TLayoutLinha)) to Ord(High(TLayoutLinha)) do
  begin
    if not TArray.BinarySearch<Integer>(pLinhas, lLinha, lIndexEncontrado) then
    begin
      Continue;
    end;

    Inc(lItem);
    ProcessarLinha(lLinha, pDados[lItem], pMascara);
  end;
end;

procedure TLayout.ProcessarHorarioSemanal(const pDias: array of TLayoutHorarios);

  procedure ProcessarHorariosDia(const lLinha: Integer; const pHorarios: TLayoutHorarios);
  begin
    ProcessarGenerico(lLinha, pHorarios.Entrada, 'XX:XX');
    ProcessarGenerico(lLinha, pHorarios.SaidaAlmoco, 'XX:XX');
    ProcessarGenerico(lLinha, pHorarios.RetornoAlmoco, 'XX:XX');
    ProcessarGenerico(lLinha, pHorarios.SaidaFinal, 'XX:XX');
    ProcessarGenerico(lLinha, pHorarios.Total, 'XX:XX');
  end;
begin
  for var I := 0 to Pred(Length(pDias)) do
  begin
    ProcessarHorariosDia(TConstantes.LINHAS_LAYOUT_HORARIOS_SEMANA[I], pDias[I]);
  end;
end;

procedure TLayout.ProcessarLinha(const pLinha: Integer; const pValor, pMascara: string);
begin
  Layout[pLinha] := Layout[pLinha].Replace(pMascara, pValor.PadLeft(pMascara.Length, ' '), [rfIgnoreCase]);
end;

procedure TLayout.ProcessarSaldoHoras(const pDados: array of string);
begin
  ProcessarGenerico(TConstantes.LINHAS_LAYOUT_SALDO_HORAS_SEMANA, pDados, 'XXX:XX');
end;

constructor TLayout.Create;
begin
  FLayout := TStringList.Create;
end;

end.
