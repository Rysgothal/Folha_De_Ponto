unit Unit1;

interface

uses
  System.SysUtils, Vcl.Graphics, Vcl.Dialogs, System.Generics.Collections;

type
  EHorarioAtualMaiorQueSaidaAlmoco = class(Exception);
  EHorarioAtualMaiorQueRetornoAlmoco = class(Exception);
  EHorarioAtualMaiorQueSaidaFinal = class(Exception);
  EHorarioAtualMenorQueEntrada = class(Exception);
  EHorarioAtualMenorQueSaidaAlmoco = class(Exception);
  EHorarioAtualMenorQueRetornoAlmoco = class(Exception);



  EHorarioAnteriorZerado = class(Exception);
  EHorarioAnteriorNaoZerado = class(Exception);
  EHorarioProximoZerado = class(Exception);
  EHorarioProximoNaoZerado = class(Exception);
  EHorarioInvalido = class(Exception);
  EHorarioZeradoNaoPermitido = class(Exception);

  TTipoHorario = (thEntrada, thSaidaAlmoco, thRetornoAlmoco, thSaidaFinal);
  TDiaSemana = (dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado);
  TCumprimentoHoraririo = (chAcima, chAbaixo, chRegular);

  THorario = record
    Horas: Integer;
    Minutos: Integer;
  end;

  TCargoHoras = class
  private
    FTotalTrabalhadas: string;
    FSaldoDeHoras: string;
    FCumprimento: TCumprimentoHoraririo;
    procedure VerificarDesempenho(pJornada: Integer);
    procedure CalcularHorasTrabalhadas(const pEntrada, pSaidaAlmoco, pRetornoAlmoco, pSaidaFinal: string;
      pJornada: Integer); overload;
    procedure CalcularHorasTrabalhadas(const pEntrada, pSaidaFinal: string; pJornada: Integer); overload;
  public
    property TotalTrabalhadas: string read FTotalTrabalhadas write FTotalTrabalhadas;
    property SaldoDeHoras: string read FSaldoDeHoras write FSaldoDeHoras;
    property Cumprimento: TCumprimentoHoraririo read FCumprimento write FCumprimento;
  end;

  TDiaHorarios = class
  private
    FNome: TDiaSemana;
    FEntrada: string;
    FSaidaAlmoco: string;
    FRetornoAlmoco: string;
    FSaidaFinal: string;
    FCargoHoras: TCargoHoras;
    FJornadaDiaria: Integer;
    procedure SetEntrada(const pValor: string);
    procedure SetRetornoAlmoco(const pValor: string);
    procedure SetSaidaAlmoco(const pValor: string);
    procedure SetSaidaFinal(const pValor: string);
    procedure CalculoTotalHorasSabado;
    procedure CalculoTotalHoras(pDia: TDiaHorarios);
  public
    constructor Create(Dia: TDiaSemana);
    property Nome: TDiaSemana read FNome write FNome;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaAlmoco: string read FSaidaAlmoco write SetSaidaAlmoco;
    property RetornoAlmoco: string read FRetornoAlmoco write SetRetornoAlmoco;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    property CargoHoras: TCargoHoras read FCargoHoras write FCargoHoras;
    property JornadaDiaria: Integer read FJornadaDiaria write FJornadaDiaria;
    function VerificarHorarioPosterior(pHoraAtual, pHoraPosterior: string): Boolean;
    function VerificarHorarioAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
    procedure CalcularHorasTrabalhadas(pDia: TDiaHorarios);
  end;

  THorarioBase = class abstract
  private
    FEntrada: string;
    FSaidaFinal: string;
    FCargoHoras: TCargoHoras;
    FJornadaDiaria: Integer;
    FNome: TDiaSemana;
    procedure SetEntrada(const pValor: string); virtual;
    procedure SetSaidaFinal(const pValor: string); virtual;
    function VerificarHorarioPosterior(pHoraAtual, pHoraPosterior: string): Boolean;
    function VerificarHorarioAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
  public
    constructor Create(Dia: TDiaSemana);
    property JornadaDiaria: Integer read FJornadaDiaria write FJornadaDiaria;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    property CargoHoras: TCargoHoras read FCargoHoras write FCargoHoras;
    property Nome: TDiaSemana read FNome write FNome;
    procedure CalcularHorasTrabalhadas;
  end;

  THorarioDiaUtil = class(THorarioBase)
  private
    FSaidaAlmoco: string;
    FRetornoAlmoco: string;
    procedure SetEntrada(const pValor: string); override;
    procedure SetSaidaFinal(const pValor: string); override;
    procedure SetRetornoAlmoco(const pValor: string);
    procedure SetSaidaAlmoco(const pValor: string);
  public
    property SaidaAlmoco: string read FSaidaAlmoco write SetSaidaAlmoco;
    property RetornoAlmoco: string read FRetornoAlmoco write SetRetornoAlmoco;
    procedure CalcularTotalDeHoras;
  end;

  THorarioSabado = class(THorarioBase);

  TPontoSemanal = class
  private
    FSegunda: THorarioDiaUtil;
    FTerca: THorarioDiaUtil;
    FQuarta: THorarioDiaUtil;
    FQuinta: THorarioDiaUtil;
    FSexta: THorarioDiaUtil;
    FSabado: THorarioSabado;
    FJornadaSemanal: Integer;
    FCargoHoras: TCargoHoras;
    procedure SetJornadaSemanal(const pValor: Integer);
    function RetornarHorasEMinutosSeparados(pHorario: string = ''): THorario;
  public
    constructor Create;
    property Segunda: THorarioDiaUtil read FSegunda write FSegunda;
    property Terca: THorarioDiaUtil read FTerca write FTerca;
    property Quarta: THorarioDiaUtil read FQuarta write FQuarta;
    property Quinta: THorarioDiaUtil read FQuinta write FQuinta;
    property Sexta: THorarioDiaUtil read FSexta write FSexta;
    property Sabado: THorarioSabado read FSabado write FSabado;
    property JornadaSemanal: Integer read FJornadaSemanal write SetJornadaSemanal;
    property CargoHoras: TCargoHoras read FCargoHoras write FCargoHoras;
    procedure CalcularHorasTotaisSemana;
  end;

implementation

uses
  Exercicio05.Helpers.Funcoes, System.DateUtils, System.StrUtils, System.Math;

{ TPontoSemanal }

procedure TPontoSemanal.CalcularHorasTotaisSemana;
var
  vSegunda, vTerca, vQuarta, vQuinta, vSexta, vSabado, vTotal, vHorasAcumuladas: THorario;
begin
  vTotal := RetornarHorasEMinutosSeparados;
  vSegunda := RetornarHorasEMinutosSeparados(FSegunda.CargoHoras.TotalTrabalhadas);
  vTerca := RetornarHorasEMinutosSeparados(FTerca.CargoHoras.TotalTrabalhadas);
  vQuarta := RetornarHorasEMinutosSeparados(FQuarta.CargoHoras.TotalTrabalhadas);
  vQuinta := RetornarHorasEMinutosSeparados(FQuinta.CargoHoras.TotalTrabalhadas);
  vSexta := RetornarHorasEMinutosSeparados(FSexta.CargoHoras.TotalTrabalhadas);
  vSabado := RetornarHorasEMinutosSeparados(FSabado.CargoHoras.TotalTrabalhadas);

  vSegunda.Minutos := vSegunda.Horas * 60 + vSegunda.Minutos;
  vTerca.Minutos := vTerca.Horas * 60 + vTerca.Minutos;
  vQuarta.Minutos := vQuarta.Horas * 60 + vQuarta.Minutos;
  vQuinta.Minutos := vQuinta.Horas * 60 + vQuinta.Minutos;
  vSexta.Minutos := vSexta.Horas * 60 + vSexta.Minutos;
  vSabado.Minutos := vSabado.Horas * 60 + vSabado.Minutos;

  vTotal.Minutos := vSegunda.Minutos + vTerca.Minutos + vQuarta.Minutos + vQuinta.Minutos + vSexta.Minutos +
    vSabado.Minutos;

  vTotal.Horas := vTotal.Minutos div 60;
  vHorasAcumuladas.Minutos := Abs(JornadaSemanal * 60 - vTotal.Minutos) mod 60;


  vTotal.Minutos := vTotal.Minutos mod 60;
  vHorasAcumuladas.Horas := Abs(JornadaSemanal - vTotal.Horas);

  if (vTotal.Horas < JornadaSemanal) and (vHorasAcumuladas.Minutos <> 0) then
  begin
    vHorasAcumuladas.Horas := Abs(vHorasAcumuladas.Horas -1);
  end else

  if vTotal.Horas >= JornadaSemanal then
  begin
    vHorasAcumuladas.Horas := Abs(JornadaSemanal - vTotal.Horas);
    vHorasAcumuladas.Minutos := vTotal.Minutos;
  end;

  CargoHoras.TotalTrabalhadas := vTotal.Horas.ToString.PadLeft(2, '0') + ':' + vTotal.Minutos.ToString.PadLeft(2, '0');
  CargoHoras.SaldoDeHoras  := IntToStr(vHorasAcumuladas.Horas).PadLeft(2, '0') + ':' +
    vHorasAcumuladas.Minutos.ToString.PadLeft(2, '0');

  CargoHoras.VerificarDesempenho(JornadaSemanal);
end;

constructor TPontoSemanal.Create;
begin
  FSegunda := THorarioDiaUtil.Create(dsSegunda);
  FTerca := THorarioDiaUtil.Create(dsTerca);
  FQuarta := THorarioDiaUtil.Create(dsQuarta);
  FQuinta := THorarioDiaUtil.Create(dsQuinta);
  FSexta := THorarioDiaUtil.Create(dsSexta);
  FSabado := THorarioSabado.Create(dsSabado);
  FCargoHoras := TCargoHoras.Create;
end;

function TPontoSemanal.RetornarHorasEMinutosSeparados(pHorario: string): THorario;
begin
  Result.Horas := 0;
  Result.Minutos := 0;

  if pHorario <> EmptyStr then
  begin
    Result.Horas := SplitString(pHorario, ':')[0].ToInteger;
    Result.Minutos := SplitString(pHorario, ':')[1].ToInteger;
  end;
end;

procedure TPontoSemanal.SetJornadaSemanal(const pValor: Integer);
var
  vDiaUtil, vSabado: Integer;
begin
  FJornadaSemanal := pValor;
  vDiaUtil := pValor div 5;
  vSabado := pValor mod 5;

  Segunda.JornadaDiaria := vDiaUtil;
  Terca.JornadaDiaria := vDiaUtil;
  Quarta.JornadaDiaria := vDiaUtil;
  Quinta.JornadaDiaria := vDiaUtil;
  Sexta.JornadaDiaria := vDiaUtil;
  Sabado.JornadaDiaria := vSabado;
end;

{ THorarioDiaUtil }

procedure THorarioDiaUtil.CalcularTotalDeHoras;
begin
  CargoHoras.CalcularHorasTrabalhadas(Entrada, SaidaAlmoco, RetornoAlmoco, SaidaFinal, JornadaDiaria);
end;

procedure THorarioDiaUtil.SetEntrada(const pValor: string);
begin
  inherited;
  FEntrada := EmptyStr;

  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    Exit;
  end;

  if VerificarHorarioPosterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueSaidaAlmoco.Create('Esse horario esta maior que Saida-Almoco');
  end;

  if VerificarHorarioPosterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueRetornoAlmoco.Create('Esse horario esta maior que Retorno-Almoco');
  end;

  FEntrada := pValor;
end;

procedure THorarioDiaUtil.SetSaidaAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FSaidaAlmoco := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if (StrToTime(pValor) = 0) and (RetornoAlmoco <> '00:00') and (RetornoAlmoco <> EmptyStr) then
  begin
    raise EHorarioProximoNaoZerado.Create('retorno almoço nao esta zerado');
  end;

  if (StrToTime(pValor) = 0) and ((RetornoAlmoco = '00:00') or (RetornoAlmoco = EmptyStr)) then
  begin
    FSaidaAlmoco := '00:00';
    Exit;
  end;

  if (StrToTime(pValor) <> 0) and (RetornoAlmoco = '00:00') and (RetornoAlmoco <> EmptyStr) then
  begin
    raise EHorarioProximoZerado.Create('retorno almoço zerado');
  end;

  if VerificarHorarioPosterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueRetornoAlmoco.Create('Esse horario esta maior que Retorno Almoco');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  FSaidaAlmoco := pValor;
end;

procedure THorarioDiaUtil.SetRetornoAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FRetornoAlmoco := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if (StrToTime(pValor) = 0) and (SaidaAlmoco <> '00:00') and (SaidaAlmoco <> EmptyStr) then
  begin
    raise EHorarioAnteriorNaoZerado.Create('saida almoço nao esta zerado');
  end;

  if (StrToTime(pValor) = 0) and ((SaidaAlmoco = '00:00') or (SaidaAlmoco = EmptyStr)) then
  begin
    FRetornoAlmoco := '00:00';
    Exit;
  end;

  if (StrToTime(pValor) <> 0) and (SaidaAlmoco = '00:00') then
  begin
    raise EHorarioAnteriorZerado.Create('saida almoço zerado');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) and (StrToTime(pValor) <> 0) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioAtualMenorQueSaidaAlmoco.Create('Esse horario esta menor que Saida Almoco');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) and (StrToTime(pValor) <> 0) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  FRetornoAlmoco := pValor;
end;

procedure THorarioDiaUtil.SetSaidaFinal(const pValor: string);
begin
  inherited;
  FSaidaFinal := EmptyStr;

  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    Exit;
  end;

  if VerificarHorarioAnterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMenorQueRetornoAlmoco.Create('Esse horario esta menor que Retorno Almoco');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0)then
  begin
    raise EHorarioAtualMenorQueSaidaAlmoco.Create('Esse horario esta menor que Saida Almoco');
  end;

  FSaidaFinal := pValor;
end;

{ THorarioBase }

procedure THorarioBase.CalcularHorasTrabalhadas;
begin
  FCargoHoras.CalcularHorasTrabalhadas(Entrada, SaidaFinal, JornadaDiaria);
end;

constructor THorarioBase.Create(Dia: TDiaSemana);
begin
  FCargoHoras := TCargoHoras.Create;
  FNome := Dia;
end;

procedure THorarioBase.SetEntrada(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FEntrada := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('h', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Não pode colocar zero na Entrada');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida Final');
  end;

  FEntrada := pValor;
end;

procedure THorarioBase.SetSaidaFinal(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FSaidaFinal := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('h', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Não pode colocar zero na Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  FSaidaFinal := pValor;
end;

function THorarioBase.VerificarHorarioAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
begin
  Result := (pHoraAnterior <> EmptyStr) and (StrToTime(pHoraAtual) < StrToTime(pHoraAnterior));
end;

function THorarioBase.VerificarHorarioPosterior(pHoraAtual, pHoraPosterior: string): Boolean;
begin
  Result := (pHoraPosterior <> EmptyStr) and (StrToTime(pHoraAtual) > StrToTime(pHoraPosterior));
end;

{ TTotalHoras }

procedure TCargoHoras.CalcularHorasTrabalhadas(const pEntrada: string; const pSaidaAlmoco: string;
  const pRetornoAlmoco: string; const pSaidaFinal: string; pJornada: Integer);
var
  vHorasTrabalhadas, vHorasAcumuladas: TTime;
begin
  vHorasTrabalhadas := 0;

  if (pEntrada <> EmptyStr) and (pSaidaAlmoco <> EmptyStr) and (pSaidaAlmoco <> '00:00') then
  begin
    vHorasTrabalhadas := StrToTime(pSaidaAlmoco) - StrToTime(pEntrada);
  end;

  if (pRetornoAlmoco <> EmptyStr) and (pRetornoAlmoco <> '00:00') and (pSaidaFinal <> EmptyStr) then
  begin
    vHorasTrabalhadas := vHorasTrabalhadas + StrToTime(pRetornoAlmoco) - StrToTime(pSaidaFinal);
  end;

  if (pEntrada <> EmptyStr) and (pSaidaFinal <> EmptyStr) and (vHorasTrabalhadas = 0) then
  begin
    vHorasTrabalhadas :=  StrToTime(pSaidaFinal) - StrToTime(pEntrada);
  end;

  if (pEntrada <> EmptyStr) and (pSaidaFinal <> EmptyStr) and (pSaidaAlmoco <> '00:00') and (pSaidaAlmoco <> EmptyStr)
    and (pRetornoAlmoco <> '00:00') and (pRetornoAlmoco <> EmptyStr) then
  begin
    vHorasTrabalhadas := StrToTime(pSaidaAlmoco) - StrToTime(pEntrada) + StrToTime(pSaidaFinal) -
      StrToTime(pRetornoAlmoco);
  end;

  if (pEntrada = EmptyStr) and (pSaidaFinal = EmptyStr) then
  begin
    vHorasTrabalhadas := 0;
  end;

  vHorasAcumuladas := vHorasTrabalhadas - StrToTime(IntToStr(pJornada));

  TotalTrabalhadas := FormatDateTime('hh:mm',vHorasTrabalhadas);
  SaldoDeHoras := FormatDateTime('hh:mm', vHorasAcumuladas);
  VerificarDesempenho(pJornada);
end;

procedure TCargoHoras.CalcularHorasTrabalhadas(const pEntrada: string; const pSaidaFinal: string; pJornada: Integer);
var
  vEntrada, vSaida: TTime;
begin
  vEntrada := StrToTime(IfThen(pEntrada = EmptyStr, '0', pEntrada));
  vSaida := StrToTime(IfThen(pSaidaFinal = EmptyStr, '0', pSaidaFinal));

  TotalTrabalhadas := FormatDateTime('hh:mm', vSaida - vEntrada);

  if (vEntrada = 0) or (vSaida = 0) then
  begin
    TotalTrabalhadas := '00:00';
  end;

  SaldoDeHoras := FormatDateTime('hh:mm', StrToTime(TotalTrabalhadas) - StrToTime(IntToStr(pJornada)));
  VerificarDesempenho(pJornada);
end;

procedure TCargoHoras.VerificarDesempenho(pJornada: Integer);
var
  vHorasJornada: Integer;
  vHorasTrabalhadas: THorario;
begin
  Cumprimento := chRegular;

  vHorasJornada := pJornada;
  vHorasTrabalhadas.Horas := SplitString(TotalTrabalhadas, ':')[0].ToInteger;
  vHorasTrabalhadas.Minutos := SplitString(TotalTrabalhadas, ':')[1].ToInteger;

  if (vHorasTrabalhadas.Horas > vHorasJornada) or ((vHorasTrabalhadas.Horas = vHorasJornada) and
      (vHorasTrabalhadas.Minutos > 0)) then
  begin
    Cumprimento := chAcima;
  end else
  if vHorasTrabalhadas.Horas < vHorasJornada then
  begin
    Cumprimento := chAbaixo;
  end;
end;

{ TDiasHorarios }

procedure TDiaHorarios.CalcularHorasTrabalhadas(pDia: TDiaHorarios);
begin
  case pDia.Nome of
    dsSabado: CalculoTotalHorasSabado;
    else CalculoTotalHoras(pDia);
  end;
end;

procedure TDiaHorarios.CalculoTotalHoras;
begin

end;

procedure TDiaHorarios.CalculoTotalHorasSabado;
var
  vEntrada, vSaida: TTime;
begin
  vEntrada := StrToTime(IfThen(Entrada = EmptyStr, '0', Entrada));
  vSaida := StrToTime(IfThen(SaidaFinal = EmptyStr, '0', SaidaFinal));

  CargoHoras.FTotalTrabalhadas := FormatDateTime('hh:mm', vSaida - vEntrada);

  if (vEntrada = 0) or (vSaida = 0) then
  begin
    CargoHoras.FTotalTrabalhadas := '00:00';
  end;

  CargoHoras.SaldoDeHoras := FormatDateTime('hh:mm', StrToTime(CargoHoras.FTotalTrabalhadas) - StrToTime(IntToStr(FJornadaDiaria)));
  CargoHoras.VerificarDesempenho(FJornadaDiaria);
end;

constructor TDiaHorarios.Create(Dia: TDiaSemana);
begin
  FCargoHoras := TCargoHoras.Create;
  FNome := Dia;
end;

procedure TDiaHorarios.SetEntrada(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FEntrada := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('h', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Nao pode colocar zero na Entrada');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida-Final');
  end;

  if VerificarHorarioPosterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueSaidaAlmoco.Create('Esse horario esta maior que Saida-Almoco');
  end;

  if VerificarHorarioPosterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueRetornoAlmoco.Create('Esse horario esta maior que Retorno-Almoco');
  end;

  FEntrada := pValor;
end;

procedure TDiaHorarios.SetRetornoAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FRetornoAlmoco := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if (StrToTime(pValor) = 0) and (SaidaAlmoco <> '00:00') and (SaidaAlmoco <> EmptyStr) then
  begin
    raise EHorarioAnteriorNaoZerado.Create('saida almoço nao esta zerado');
  end;

  if (StrToTime(pValor) = 0) and ((SaidaAlmoco = '00:00') or (SaidaAlmoco = EmptyStr)) then
  begin
    FRetornoAlmoco := '00:00';
    Exit;
  end;

  if (StrToTime(pValor) <> 0) and (SaidaAlmoco = '00:00') then
  begin
    raise EHorarioAnteriorZerado.Create('saida almoço zerado');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) and (StrToTime(pValor) <> 0) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioAtualMenorQueSaidaAlmoco.Create('Esse horario esta menor que Saida Almoco');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) and (StrToTime(pValor) <> 0) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  FRetornoAlmoco := pValor;
end;

procedure TDiaHorarios.SetSaidaAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FSaidaAlmoco := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if (StrToTime(pValor) = 0) and (RetornoAlmoco <> '00:00') and (RetornoAlmoco <> EmptyStr) then
  begin
    raise EHorarioProximoNaoZerado.Create('retorno almoço nao esta zerado');
  end;

  if (StrToTime(pValor) = 0) and ((RetornoAlmoco = '00:00') or (RetornoAlmoco = EmptyStr)) then
  begin
    FSaidaAlmoco := '00:00';
    Exit;
  end;

  if (StrToTime(pValor) <> 0) and (RetornoAlmoco = '00:00') and (RetornoAlmoco <> EmptyStr) then
  begin
    raise EHorarioProximoZerado.Create('retorno almoço zerado');
  end;

  if VerificarHorarioPosterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMaiorQueRetornoAlmoco.Create('Esse horario esta maior que Retorno Almoco');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioAtualMaiorQueSaidaFinal.Create('Esse horario esta maior que Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  FSaidaAlmoco := pValor;
end;

procedure TDiaHorarios.SetSaidaFinal(const pValor: string);
var
  vTime: TDateTime;
begin
  if (pValor.Trim = ':') or (pValor.Trim = EmptyStr) then
  begin
    FSaidaFinal := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('h', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Não pode colocar zero na Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioAtualMenorQueEntrada.Create('Esse horario esta menor que Entrada');
  end;

  if VerificarHorarioAnterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioAtualMenorQueRetornoAlmoco.Create('Esse horario esta menor que Retorno Almoco');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0)then
  begin
    raise EHorarioAtualMenorQueSaidaAlmoco.Create('Esse horario esta menor que Saida Almoco');
  end;

  FSaidaFinal := pValor;
end;

function TDiaHorarios.VerificarHorarioAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
begin
  Result := (pHoraAnterior <> EmptyStr) and (StrToTime(pHoraAtual) < StrToTime(pHoraAnterior));
end;

function TDiaHorarios.VerificarHorarioPosterior(pHoraAtual, pHoraPosterior: string): Boolean;
begin
  Result := (pHoraPosterior <> EmptyStr) and (StrToTime(pHoraAtual) > StrToTime(pHoraPosterior));
end;

end.
