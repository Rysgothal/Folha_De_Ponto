unit Ex05.Classes.Horarios;

interface

uses
  System.SysUtils, Vcl.Graphics, Vcl.Dialogs, System.Generics.Collections;

type
  EHorarioMaiorProximo = class(Exception);
  EHorarioMenorAnterior = class(Exception);
  EHorarioAnteriorZerado = class(Exception);
  EHorarioAnteriorNaoZerado = class(Exception);
  EHorarioProximoZerado = class(Exception);
  EHorarioProximoNaoZerado = class(Exception);
  EHorarioInvalido = class(Exception);
  EHorarioZeradoNaoPermitido = class(Exception);

  TTipoHorario = (thEntrada, thSaidaAlmoco, thRetornoAlmoco, thSaidaFinal);
  TDesempenhoFuncionario = (dfAlto, dfBaixo, dfNormal);

  THorario = record
    Horas: Integer;
    Minutos: Integer;
  end;

  TTotalHoras = class
  private
    FHorasTrabalhadas: string;
    FHorasDevedoras: string;
    FDesempenho: TDesempenhoFuncionario;
    procedure VerificarDesempenho(pJornada: Integer);
    procedure CalcularHorasTrabalhadas(const pEntrada, pSaidaAlmoco, pRetornoAlmoco, pSaidaFinal: string;
      pJornada: Integer); overload;
    procedure CalcularHorasTrabalhadas(const pEntrada, pSaidaFinal: string; pJornada: Integer); overload;
  public
    property HorasTrabalhadas: string read FHorasTrabalhadas write FHorasTrabalhadas;
    property HorasAcumuladas: string read FHorasDevedoras write FHorasDevedoras;
    property Desempenho: TDesempenhoFuncionario read FDesempenho write FDesempenho;
  end;

  THorarioBase = class abstract
  private
    FEntrada: string;
    FSaidaFinal: string;
    FCargoHoras: TTotalHoras;
    FJornadaDiaria: Integer;
    procedure SetEntrada(const pValor: string); virtual;
    procedure SetSaidaFinal(const pValor: string); virtual;
    function VerificarHorarioPosterior(pHoraAtual, pHoraPosterior: string): Boolean;
    function VerificarHorarioAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
  public
    constructor Create;
    property JornadaDiaria: Integer read FJornadaDiaria write FJornadaDiaria;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    property CargoHoras: TTotalHoras read FCargoHoras write FCargoHoras;
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
    FCargoHoras: TTotalHoras;
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
    property CargoHoras: TTotalHoras read FCargoHoras write FCargoHoras;
    procedure CalcularHorasTotaisSemana;
  end;

implementation

uses
  Avaliacao.Helpers.Funcoes, System.DateUtils, System.StrUtils, System.Math;

{ TPontoSemanal }

procedure TPontoSemanal.CalcularHorasTotaisSemana;
var
  vSegunda, vTerca, vQuarta, vQuinta, vSexta, vSabado, vTotal: THorario;
  vHorasAcumuladas: Integer;
begin
  vTotal := RetornarHorasEMinutosSeparados;
  vSegunda := RetornarHorasEMinutosSeparados(FSegunda.CargoHoras.HorasTrabalhadas);
  vTerca := RetornarHorasEMinutosSeparados(FTerca.CargoHoras.HorasTrabalhadas);
  vQuarta := RetornarHorasEMinutosSeparados(FQuarta.CargoHoras.HorasTrabalhadas);
  vQuinta := RetornarHorasEMinutosSeparados(FQuinta.CargoHoras.HorasTrabalhadas);
  vSexta := RetornarHorasEMinutosSeparados(FSexta.CargoHoras.HorasTrabalhadas);
  vSabado := RetornarHorasEMinutosSeparados(FSabado.CargoHoras.HorasTrabalhadas);

  vSegunda.Minutos := vSegunda.Horas * 60 + vSegunda.Minutos;
  vTerca.Minutos := vTerca.Horas * 60 + vTerca.Minutos;
  vQuarta.Minutos := vQuarta.Horas * 60 + vQuarta.Minutos;
  vQuinta.Minutos := vQuinta.Horas * 60 + vQuinta.Minutos;
  vSexta.Minutos := vSexta.Horas * 60 + vSexta.Minutos;
  vSabado.Minutos := vSabado.Horas * 60 + vSabado.Minutos;

  vTotal.Minutos := vSegunda.Minutos + vTerca.Minutos + vQuarta.Minutos + vQuinta.Minutos + vSexta.Minutos +
    vSabado.Minutos;

  vTotal.Horas := vTotal.Minutos div 60;
  vTotal.Minutos := vTotal.Minutos mod 60;
  vHorasAcumuladas := Abs((vTotal.Horas - JornadaSemanal));

  CargoHoras.HorasTrabalhadas := vTotal.Horas.ToString.PadLeft(2, '0') + ':' + vTotal.Minutos.ToString.PadLeft(2, '0');
  CargoHoras.HorasAcumuladas  := IntToStr(vHorasAcumuladas).PadLeft(2, '0') + ':' +
    vTotal.Minutos.ToString.PadLeft(2, '0');

  CargoHoras.VerificarDesempenho(JornadaSemanal);
end;

constructor TPontoSemanal.Create;
begin
  FSegunda := THorarioDiaUtil.Create;
  FTerca := THorarioDiaUtil.Create;
  FQuarta := THorarioDiaUtil.Create;
  FQuinta := THorarioDiaUtil.Create;
  FSexta := THorarioDiaUtil.Create;
  FSabado := THorarioSabado.Create;
  FCargoHoras := TTotalHoras.Create;
end;

function TPontoSemanal.RetornarHorasEMinutosSeparados(pHorario: string): THorario;
begin
  if pHorario = EmptyStr then
  begin
    Result.Horas := 0;
    Result.Minutos := 0;
  end else
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

  if pValor.Trim = ':' then
  begin
    Exit;
  end;

  if VerificarHorarioPosterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  if VerificarHorarioPosterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  FEntrada := pValor;
end;

procedure THorarioDiaUtil.SetSaidaAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if pValor.Trim = ':' then
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
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
  end;

  FSaidaAlmoco := pValor;
end;

procedure THorarioDiaUtil.SetRetornoAlmoco(const pValor: string);
var
  vTime: TDateTime;
begin
  if pValor.Trim = ':' then
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
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0) then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) and (StrToTime(pValor) <> 0) then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
  end;

  FRetornoAlmoco := pValor;
end;

procedure THorarioDiaUtil.SetSaidaFinal(const pValor: string);
begin
  inherited;
  FSaidaFinal := EmptyStr;

  if pValor.Trim = ':' then
  begin
    Exit;
  end;

  if VerificarHorarioAnterior(pValor, RetornoAlmoco) and (StrToTime(RetornoAlmoco) <> 0) then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
  end;

  if VerificarHorarioAnterior(pValor, SaidaAlmoco) and (StrToTime(SaidaAlmoco) <> 0)then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
  end;

  FSaidaFinal := pValor;
end;

{ THorarioBase }

procedure THorarioBase.CalcularHorasTrabalhadas;
begin
  FCargoHoras.CalcularHorasTrabalhadas(Entrada, SaidaFinal, JornadaDiaria);
end;

constructor THorarioBase.Create;
begin
  FCargoHoras := TTotalHoras.Create;
end;

procedure THorarioBase.SetEntrada(const pValor: string);
var
  vTime: TDateTime;
begin
  if pValor.Trim = ':' then
  begin
    FEntrada := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('hh', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Não pode colocar zero na Entrada');
  end;

  if VerificarHorarioPosterior(pValor, SaidaFinal) then
  begin
    raise EHorarioMaiorProximo.Create('Esse horario esta maior que o Proximo');
  end;

  FEntrada := pValor;
end;

procedure THorarioBase.SetSaidaFinal(const pValor: string);
var
  vTime: TDateTime;
begin
  if pValor.Trim = ':' then
  begin
    FSaidaFinal := EmptyStr;
    Exit;
  end;

  if not TryStrToTime(pValor, vTime) then
  begin
    raise EHorarioInvalido.Create('Horario invalido');
  end;

  if FormatDateTime('hh', vTime) = '0' then
  begin
    raise EHorarioZeradoNaoPermitido.Create('Não pode colocar zero na Saida Final');
  end;

  if VerificarHorarioAnterior(pValor, Entrada) then
  begin
    raise EHorarioMenorAnterior.Create('Esse horario esta menor que o Anterior');
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

procedure TTotalHoras.CalcularHorasTrabalhadas(const pEntrada: string; const pSaidaAlmoco: string;
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

  HorasTrabalhadas := FormatDateTime('hh:mm',vHorasTrabalhadas);
  HorasAcumuladas := FormatDateTime('hh:mm', vHorasAcumuladas);
  VerificarDesempenho(pJornada);
end;

procedure TTotalHoras.CalcularHorasTrabalhadas(const pEntrada: string; const pSaidaFinal: string; pJornada: Integer);
var
  vEntrada, vSaida: TTime;
begin
  vEntrada := StrToTime(IfThen(pEntrada = EmptyStr, '0', pEntrada));
  vSaida := StrToTime(IfThen(pSaidaFinal = EmptyStr, '0', pSaidaFinal));

  HorasTrabalhadas := FormatDateTime('hh:mm', vSaida - vEntrada);

  if (vEntrada = 0) or (vSaida = 0) then
  begin
    HorasTrabalhadas := '00:00';
  end;

  HorasAcumuladas := FormatDateTime('hh:mm', StrToTime(HorasTrabalhadas) - StrToTime(IntToStr(pJornada)));
  VerificarDesempenho(pJornada);
end;

procedure TTotalHoras.VerificarDesempenho(pJornada: Integer);
var
  vHorasJornada: Integer;
  vHorasTrabalhadas: THorario;
begin
  Desempenho := dfNormal;

  vHorasJornada := pJornada;
  vHorasTrabalhadas.Horas := SplitString(HorasTrabalhadas, ':')[0].ToInteger;
  vHorasTrabalhadas.Minutos := SplitString(HorasTrabalhadas, ':')[1].ToInteger;

  if (vHorasTrabalhadas.Horas > vHorasJornada) or ((vHorasTrabalhadas.Horas = vHorasJornada) and
    (vHorasTrabalhadas.Minutos > 0)) then
  begin
    Desempenho := dfAlto;
  end else
  if vHorasTrabalhadas.Horas < vHorasJornada then
  begin
    Desempenho := dfBaixo;
  end;
end;

end.
