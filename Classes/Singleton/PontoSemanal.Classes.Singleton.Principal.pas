unit PontoSemanal.Classes.Singleton.Principal;

interface

uses
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  System.Generics.Collections, PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Desempenho,
  PontoSemanal.Interfaces.Bridge.Converter;

type
  TFolhaPontoSemanalSingleton = class
  private
    FID: string;
    FNome: string;
    FDataAdmissao: string;
    FTempoAdmissao: string;
    FJornadaSemanal: string;
    FIntervaloAlmoco: string;
    FDesempenho: TDesempenho;
    FSegunda: THorariosDia;
    FTerca: THorariosDia;
    FQuarta: THorariosDia;
    FQuinta: THorariosDia;
    FSexta: THorariosDia;
    FSabado: THorariosDia;
    FObservers: TDictionary<TDiaSemana, IObservador>;
    FConverterHora: IConverter;
    FIntervaloAlmocoExtenso: string;
    constructor Create;
    procedure SetID(const pValor: string);
    procedure SetDataAdmissao(const pValor: string);
    procedure SetJornadaSemanal(const pValor: string);
    procedure SetIntervaloAlmoco(const pValor: string);
    procedure DistribuirHorarios(pValor: Integer);
  public
    class function ObterInstancia: TFolhaPontoSemanalSingleton;
    destructor Destroy; override;
    property ID: string read FID write SetID;
    property Nome: string read FNome write FNome;
    property DataAdmissao: string read FDataAdmissao write SetDataAdmissao;
    property TempoAdmissao: string read FTempoAdmissao;
    property JornadaSemanal: string read FJornadaSemanal write SetJornadaSemanal;
    property IntervaloAlmoco: string read FIntervaloAlmoco write SetIntervaloAlmoco;
    property IntervaloAlmocoExtenso: string read FIntervaloAlmocoExtenso;
    property Desempenho: TDesempenho read FDesempenho write FDesempenho;
    property Segunda: THorariosDia read FSegunda write FSegunda;
    property Terca: THorariosDia read FTerca write FTerca;
    property Quarta: THorariosDia read FQuarta write FQuarta;
    property Quinta: THorariosDia read FQuinta write FQuinta;
    property Sexta: THorariosDia read FSexta write FSexta;
    property Sabado: THorariosDia read FSabado write FSabado;
    property Observers: TDictionary<TDiaSemana, IObservador> read FObservers;
    property ConverterHora: IConverter read FConverterHora write FConverterHora;
    procedure AdicionarObservador(pDiaSemana: TDiaSemana; pObservador: IObservador);
    procedure CalcularTempoAdmissao;
    procedure CalcularDesempenho;
    procedure Limpar;
  end;

var
  FFolhaPontoSemanal: TFolhaPontoSemanalSingleton;

implementation

uses
  System.SysUtils, PontoSemanal.Helpers.Strings, System.DateUtils,
  PontoSemanal.Helpers.Exceptions, PontoSemanal.Classes.Bridge.Converter;

{ TFolhaPontoSemanalSingleton }

constructor TFolhaPontoSemanalSingleton.Create;
begin
  FID := EmptyStr;
  FNome := EmptyStr;
  FDataAdmissao := EmptyStr;
  FJornadaSemanal := '0';
  FTempoAdmissao := '-> anos; meses; semanas; dias;';
  FIntervaloAlmoco := EmptyStr;
  FIntervaloAlmocoExtenso := '"x" horas e "y" minutos';
  FDesempenho := TDesempenho.Create;

  FSegunda := THorariosDia.Create(dsSegunda);
  FTerca := THorariosDia.Create(dsTerca);
  FQuarta := THorariosDia.Create(dsQuarta);
  FQuinta := THorariosDia.Create(dsQuinta);
  FSexta := THorariosDia.Create(dsSexta);
  FSabado := THorariosDia.Create(dsSabado);

  FObservers := TDictionary<TDiaSemana, IObservador>.Create;
  FConverterHora := TConverter.Create;
end;

class function TFolhaPontoSemanalSingleton.ObterInstancia: TFolhaPontoSemanalSingleton;
begin
  if not Assigned(FFolhaPontoSemanal) then
  begin
    FFolhaPontoSemanal := TFolhaPontoSemanalSingleton.Create;
  end;

  Result := FFolhaPontoSemanal;
end;

destructor TFolhaPontoSemanalSingleton.Destroy;
begin
  FreeAndNil(FSegunda);
  FreeAndNil(FTerca);
  FreeAndNil(FQuarta);
  FreeAndNil(FQuinta);
  FreeAndNil(FSexta);
  FreeAndNil(FSabado);
  FreeAndNil(FDesempenho);
  FreeAndNil(FObservers);

  inherited;
end;

procedure TFolhaPontoSemanalSingleton.DistribuirHorarios(pValor: Integer);
var
  lJornadaDiaria: Integer;
begin
  lJornadaDiaria := pValor div 5;

  Segunda.Jornada := lJornadaDiaria;
  Terca.Jornada := lJornadaDiaria;
  Quarta.Jornada := lJornadaDiaria;
  Quinta.Jornada := lJornadaDiaria;
  Sexta.Jornada := lJornadaDiaria;
  Sabado.Jornada := pValor mod 5;
end;

procedure TFolhaPontoSemanalSingleton.Limpar;
begin
  FID := EmptyStr;
  FNome := EmptyStr;
  FDataAdmissao := EmptyStr;
  FJornadaSemanal := '0';
  FTempoAdmissao := '-> anos; meses; semanas; dias;';
  FIntervaloAlmoco := EmptyStr;
  FIntervaloAlmocoExtenso := EmptyStr;

  FDesempenho.Limpar;
  FSegunda.Limpar;
  FTerca.Limpar;
  FQuarta.Limpar;
  FQuinta.Limpar;
  FSexta.Limpar;
  FSabado.Limpar;

  FObservers.Clear;
end;

procedure TFolhaPontoSemanalSingleton.SetDataAdmissao(const pValor: string);
var
  lData: TDateTime;
begin
  FDataAdmissao := EmptyStr;

  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
//    CalcularTempoAdmissao;
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
//  CalcularTempoAdmissao;
end;

procedure TFolhaPontoSemanalSingleton.SetID(const pValor: string);
begin
  FID := pValor;

  if TStringHelpers.VerificarCampoVazio(FID) then
  begin
    Exit;
  end;

  if FID.ToInteger = 0 then
  begin
    FID := '1';
  end;

  FID := TStringHelpers.Completar(FID, 7, '0');
end;

procedure TFolhaPontoSemanalSingleton.SetIntervaloAlmoco(const pValor: string);
var
  lValor: TDateTime;
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FIntervaloAlmoco := EmptyStr;
    FIntervaloAlmocoExtenso := '"x" horas e "y" minutos';
    Exit;
  end;

  if not TryStrToTime(pValor, lValor) then
  begin
    raise EIntervaloAlmocoInvalido.Create('O intervalo de almoço inserido está incorreto, verifique.');
  end;

  FIntervaloAlmoco := pValor;
  FIntervaloAlmocoExtenso := TStringHelpers.IntervaloPorExtenso(pValor);
end;

procedure TFolhaPontoSemanalSingleton.SetJornadaSemanal(const pValor: string);
var
  lValor: Integer;
begin
  FJornadaSemanal := '0';

  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    Exit;
  end;

  if not TryStrToInt(pValor, lValor) then
  begin
    raise EJornadaSemanalInvalida.Create('A jornada semanal inserida está incorreta, verifique.');
  end;

  if lValor > 44 then // Fazer Confg
  begin
    raise EJornadaSemanalNaoPermitidaLei.Create('A jornada semanal informada não é aceita pela Lei, verifique...');
  end;

  FJornadaSemanal := pValor;
  DistribuirHorarios(lValor);
end;

procedure TFolhaPontoSemanalSingleton.AdicionarObservador(pDiaSemana: TDiaSemana; pObservador: IObservador);
begin
  FObservers.Add(pDiaSemana, pObservador);
end;

procedure TFolhaPontoSemanalSingleton.CalcularDesempenho;
var
  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado, lTotalMinutos, lTotalHoras: Integer;
  lSaldoHoras: THorarioSeparado;
  lTotalTrabalhadas, lTotalSaldoHoras: string;
begin
  lSegunda := ConverterHora.ParaMinutos(Segunda.Desempenho.TotalTrabalhado);
  lTerca := ConverterHora.ParaMinutos(Terca.Desempenho.TotalTrabalhado);
  lQuarta := ConverterHora.ParaMinutos(Quarta.Desempenho.TotalTrabalhado);
  lQuinta := ConverterHora.ParaMinutos(Quinta.Desempenho.TotalTrabalhado);
  lSexta := ConverterHora.ParaMinutos(Sexta.Desempenho.TotalTrabalhado);
  lSabado := ConverterHora.ParaMinutos(Sabado.Desempenho.TotalTrabalhado);

  lTotalMinutos := lSegunda + lTerca + lQuarta + lQuinta + lSexta + lSabado;
  lTotalHoras := lTotalMinutos div 60;

  lSaldoHoras.Minutos := Abs(FJornadaSemanal.ToInteger * 60 - lTotalMinutos) mod 60;

  lTotalMinutos := lTotalMinutos mod 60;
  lSaldoHoras.Horas := Abs(JornadaSemanal.ToInteger - lTotalHoras);

  if (lTotalHoras < JornadaSemanal.ToInteger) and (lSaldoHoras.Minutos <> 0) then
  begin
    lSaldoHoras.Horas := Abs(Pred(lSaldoHoras.Horas));
  end else
  if lTotalHoras >= JornadaSemanal.ToInteger then
  begin
    lSaldoHoras.Minutos := lTotalMinutos;
  end;

  lTotalTrabalhadas := lTotalHoras.ToString.PadLeft(2, '0') + ':' + lTotalMinutos.ToString.PadLeft(2, '0');
  lTotalSaldoHoras := IntToStr(lSaldoHoras.Horas).PadLeft(2, '0') + ':' + lSaldoHoras.Minutos.ToString.PadLeft(2, '0');

  Desempenho.TotalTrabalhado := lTotalTrabalhadas;
  Desempenho.SaldoHoras := lTotalSaldoHoras;
  Desempenho.AtualizarCumprimento(JornadaSemanal.ToInteger);
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

  lAnos := YearsBetween(lDataNascimento, Now);
  lMeses := MonthsBetween(IncYear(lDataNascimento, lAnos), Now);

  if lMeses = 12 then
  begin
    lMeses := 0;
    Inc(lAnos);
  end;

  lSemanas := WeeksBetween(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), Now);
  lDias := DaysBetween(IncWeek(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), lSemanas), Now);

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
