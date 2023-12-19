unit PontoSemanal.Classes.Singleton.Principal;

interface

type
  TFolhaPontoSemanalSingleton = class
  private
    FID: string;
    FNome: string;
    FDataAdmissao: string;
    FTempoAdmissao: string;
    FJornadaSemanal: string;
    FIntervaloAlmoco: string;
    procedure SetID(const pValor: string);
    procedure SetDataAdmissao(const pValor: string);
    constructor Create;
    procedure CalcularTempoAdmissao;
    procedure SetJornadaSemanal(const pValor: string);
    procedure SetIntervaloAlmoco(const pValor: string);
  public
    property ID: string read FID write SetID;
    property Nome: string read FNome write FNome;
    property DataAdmissao: string read FDataAdmissao write SetDataAdmissao;
    property TempoAdmissao: string read FTempoAdmissao;
    property JornadaSemanal: string read FJornadaSemanal write SetJornadaSemanal;
    property IntervaloAlmoco: string read FIntervaloAlmoco write SetIntervaloAlmoco;
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
  lData: TDateTime;
begin
  FDataAdmissao := EmptyStr;

  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    CalcularTempoAdmissao;
    Exit;
  end;

  if not TryStrToDate(pValor, lData) then
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

procedure TFolhaPontoSemanalSingleton.SetIntervaloAlmoco(const pValor: string);
var
  lValor: TDateTime;
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FIntervaloAlmoco := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, lValor) then
  begin
    raise EIntervaloAlmocoInvalido.Create('O intervalo de almoço inserido está incorreto, verifique.');
  end;

  FIntervaloAlmoco := pValor;
end;

procedure TFolhaPontoSemanalSingleton.SetJornadaSemanal(const pValor: string);
var
  lValor: Integer;
begin
  FJornadaSemanal := EmptyStr;

  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    Exit;
  end;

  if not TryStrToInt(pValor, lValor) then
  begin
    raise EJornadaSemanalInvalida.Create('A jornada semanal inserida está incorreta, verifique.');
  end;

  if lValor > 44 then //
  begin
    raise EJornadaSemanalNaoPermitidaLei.Create('A jornada semanal informada não é aceita pela Lei, verifique...');
  end;

  FJornadaSemanal := pValor;
end;

procedure TFolhaPontoSemanalSingleton.CalcularTempoAdmissao;
var
  lDataNascimento: TDateTime;
  lAnos, lMeses, lSemanas, lDias: Integer;
begin
  FTempoAdmissao := EmptyStr;

  if TStringHelpers.VerificarCampoVazio(DataAdmissao) then
  begin
    FTempoAdmissao := '-> anos; meses; semanas; dias;';
    Exit;
  end;

  lDataNascimento := StrToDate(DataAdmissao);

  lAnos    := YearsBetween(lDataNascimento, Now);
  lMeses   := MonthsBetween(IncYear(lDataNascimento, lAnos), Now);

  if lMeses = 12 then
  begin
    lMeses := 0;
    Inc(lAnos);
  end;

  lSemanas := WeeksBetween(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), Now);
  lDias    := DaysBetween(IncWeek(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), lSemanas), Now);

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

  case TStringHelpers.VerificarCampoVazio(FTempoAdmissao) of
    True: FTempoAdmissao := 'Primeiro dia.';
    else FTempoAdmissao := Copy(FTempoAdmissao, 1, Length(FTempoAdmissao) - 2) + '.';
  end;
end;

initialization

finalization
  FreeAndNil(FFolhaPontoSemanal);

end.
