unit PontoSemanal.Classes.Singleton.Principal;

interface

type
  TFolhaPontoSemanalSingleton = class
  private
    FID: string;
    FNome: string;
    FDataAdmissao: string;
    FTempoAdmissao: string;
    procedure SetID(const pValor: string);
    procedure SetDataAdmissao(const pValor: string);
    constructor Create;
    procedure CalcularTempoAdmissao;
  public
    property ID: string read FID write SetID;
    property Nome: string read FNome write FNome;
    property DataAdmissao: string read FDataAdmissao write SetDataAdmissao;
    property TempoAdmissao: string read FTempoAdmissao;
    class function ObterInstancia: TFolhaPontoSemanalSingleton;
  end;

var
  FFolhaPontoSemanal: TFolhaPontoSemanalSingleton;

implementation

uses
  System.SysUtils, PontoSemanal.Helpers.Strings, System.DateUtils,
  PontoSemanal.Helpers.Exceptions;

{ TFolhaPontoSemanalSingleton }

constructor TFolhaPontoSemanalSingleton.Create;
begin
  FID := EmptyStr;
  FNome := EmptyStr;
  FDataAdmissao := EmptyStr;
  FTempoAdmissao := '-> anos; meses; semanas; dias;';
end;

class function TFolhaPontoSemanalSingleton.ObterInstancia: TFolhaPontoSemanalSingleton;
begin
  case Assigned(FFolhaPontoSemanal) of
    True: Result := FFolhaPontoSemanal;
    else  Result := TFolhaPontoSemanalSingleton.Create;
  end;
end;

procedure TFolhaPontoSemanalSingleton.SetDataAdmissao(const pValor: string);
var
  lValor: string;
  lData: TDateTime;
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FDataAdmissao := EmptyStr;
    CalcularTempoAdmissao;
    Exit;
  end;

  lValor := pValor;

  if not TryStrToDate(lValor, lData) then
  begin
    raise EDataInvalida.Create('A data informada está incorreta, verifique.');
  end;

  if lData > Date then
  begin
    raise EDataAlemDosDiasAtuais.Create('A data informada está além dos dias atuais, verifique.');
  end;

  if YearsBetween(lData, Date) > 100 then
  begin
    raise EDataUltrapassada.Create('A data informada está incoerente com os dias atuais, verifique.');
  end;

  FDataAdmissao := pValor;
  CalcularTempoAdmissao;
end;

procedure TFolhaPontoSemanalSingleton.SetID(const pValor: string);
var
  lValor: string;
begin
  lValor := pValor;

  if TStringHelpers.VerificarCampoVazio(lValor) or (lValor.ToInteger = 0) then
  begin
    lValor := '1';
  end;

  FID := TStringHelpers.Completar(lValor, 7, '0');
end;

procedure TFolhaPontoSemanalSingleton.CalcularTempoAdmissao;
var
  lDataNascimento: TDateTime;
  lAnos, lMeses, lSemanas, lDias: Integer;
begin
  if TStringHelpers.VerificarCampoVazio(DataAdmissao) then
  begin
    FTempoAdmissao := '-> anos; meses; semanas; dias;';
    Exit;
  end;

  lDataNascimento := StrToDate(DataAdmissao);

  lAnos    := YearsBetween(lDataNascimento, Date);
  lMeses   := MonthsBetween(IncYear(lDataNascimento, lAnos), Date);
  lSemanas := WeeksBetween(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), Date);
  lDias    := DaysBetween(IncWeek(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), lSemanas), Date);

  FTempoAdmissao := 'Seu primeiro dia..';

  case lAnos of
    0: ;
    1: FTempoAdmissao := lAnos.ToString + ' Ano; ';
    else FTempoAdmissao := lAnos.ToString + ' Anos; ';
  end;

  case lMeses of
    0: ;
    1: FTempoAdmissao := FTempoAdmissao + lMeses.ToString + ' Mês; ';
    else FTempoAdmissao := FTempoAdmissao + lMeses.ToString + ' Meses; ';
  end;

  case lSemanas of
    0: ;
    1: FTempoAdmissao := FTempoAdmissao + lSemanas.ToString + ' Semana; ';
    else FTempoAdmissao := FTempoAdmissao + lSemanas.ToString + ' Semanas; ';
  end;

  case lDias of
    0: ;
    1: FTempoAdmissao := FTempoAdmissao + lDias.ToString + ' Dia. ';
    else FTempoAdmissao := FTempoAdmissao + lDias.ToString + ' Dias. ';
  end;

  FTempoAdmissao := Copy(FTempoAdmissao, 1, Length(FTempoAdmissao) - 2) + '.';
end;

initialization

finalization
  FreeAndNil(FFolhaPontoSemanal);

end.
