unit PontoSemanal.Classes.Base.Horarios;

interface

uses
  PontoSemanal.Helpers.TiposAuxiliares, System.SysUtils, PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Helpers.Exceptions, System.Classes, System.Generics.Collections,
  PontoSemanal.Classes.Base.Desempenho;

type
  THorariosDia = class
  private
    FTag: TDiaSemana;
    FEntrada: string;
    FSaidaAlmoco: string;
    FRetornoAlmoco: string;
    FSaidaFinal: string;
    FDesempenho: TDesempenho;
    FJornada: Integer;
    FTurnoNoturno: Boolean;
    procedure SetEntrada(const pValor: string);
    procedure SetRetornoAlmoco(const pValor: string);
    procedure SetSaidaAlmoco(const pValor: string);
    procedure SetSaidaFinal(const pValor: string);
    procedure CriarException(pException: ExceptClass; pMensagem: string);
    procedure AbortarCasoHorarioInvalido(const pValor: string);
    procedure AbortarCasoHorarioAtualMaiorQueSaidaFinal(const pValor: string);
    procedure AbortarCasoHorarioAtualMenorQueEntrada(const pValor: string);
    procedure AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(const pValor: string);
    procedure AbortarCasoHorarioZeradoNaoPermitido(const pValor: string);
    procedure AbortarCasoHorarioAtualMenorQueSaidaAlmoco(const pValor: string);
    function VerificarHorarioVazio(const pValor: string): Boolean;
    procedure SetEntradaTurnoTradicional(const pValor: string);
    procedure SetRetornoAlmocoTurnoTradicional(const pValor: string);
    procedure SetSaidaAlmocoTurnoTradicional(const pValor: string);
    procedure SetSaidaFinalTurnoTradicional(const pValor: string);
    function RetornarHorario(pHorario: string): TDateTime;
  public
    constructor Create(pTag: TDiaSemana);
    destructor Destroy; override;
    property Tag: TDiaSemana read FTag;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaAlmoco: string read FSaidaAlmoco write SetSaidaAlmoco;
    property RetornoAlmoco: string read FRetornoAlmoco write SetRetornoAlmoco;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    property Desempenho: TDesempenho read FDesempenho write FDesempenho;
    property Jornada: Integer read FJornada write FJornada;
    property TurnoNoturno: Boolean read FTurnoNoturno write FTurnoNoturno;
    procedure InserirEntrada(const pValor: string);
    procedure InserirSaidaAlmoco(const pValor: string);
    procedure InserirRetornoAlmoco(const pValor: string);
    procedure InserirSaidaFinal(const pValor: string);
    procedure CalcularHorasTrabalhadas;
    procedure Limpar;
    function PegarNomeDaSemana(pNomeCompleto: Boolean = False; pCaracterEspecial: Boolean = False): string;
  end;

implementation

uses
  PontoSemanal.Helpers.Strings, System.DateUtils, System.StrUtils, System.Math;

{ TDiaHorarios }

procedure THorariosDia.CalcularHorasTrabalhadas;
var
  lHorasCalculo, lSaldoCalculo: THorarioSeparado;
  lEntrada, lSaidaAlmoco, lRetornoAlmoco, lSaidaFinal: TDateTime;
  lVerificarPeriodoManha, lVerificarPeriodoTarde, lSemAlmoco: Boolean;
begin
  lEntrada := RetornarHorario(Entrada);
  lSaidaAlmoco := RetornarHorario(SaidaAlmoco);
  lRetornoAlmoco := RetornarHorario(RetornoAlmoco);
  lSaidaFinal := RetornarHorario(SaidaFinal);

  lVerificarPeriodoManha := not Entrada.Trim.IsEmpty and not SaidaAlmoco.Trim.IsEmpty;
  lVerificarPeriodoTarde := not SaidaFinal.Trim.IsEmpty and not RetornoAlmoco.Trim.IsEmpty;
  lSemAlmoco := (Entrada <> EmptyStr) and (SaidaFinal <> EmptyStr) and (RetornoAlmoco = '00:00') and (SaidaAlmoco = '00:00');

  if (lEntrada > lSaidaAlmoco) and not SaidaAlmoco.Trim.IsEmpty and not Entrada.Trim.IsEmpty then
  begin
    lSaidaAlmoco := lSaidaAlmoco.IncDay;
    lRetornoAlmoco := lRetornoAlmoco.IncDay;
    lSaidaFinal := lSaidaFinal.IncDay;
  end;

  if (lSaidaAlmoco > lRetornoAlmoco) and not SaidaAlmoco.Trim.isEmpty and not RetornoAlmoco.Trim.isEmpty then
  begin
    lRetornoAlmoco := lRetornoAlmoco.IncDay;
    lSaidaFinal := lSaidaFinal.IncDay;
  end;

  if (lSemAlmoco and (lEntrada > lSaidaFinal)) or (not lSemAlmoco and (lRetornoAlmoco > lSaidaFinal)) then
  begin
    lSaidaFinal := lSaidaFinal.IncDay;
  end;

  if (DaysBetween(lSaidaFinal, lEntrada) = 1) and (lSaidaFinal > lEntrada) and lSemAlmoco then
  begin
    lSaidaFinal := lSaidaFinal.IncDay(-1);
  end;

  if (HoursBetween(lSaidaFinal, lEntrada) > 24) and not SaidaFinal.Trim.IsEmpty then
  begin
    raise ETotalTrabalhadoMaisDeUmDia.Create('Seus hor�rios do dia somam mais de 24 horas, verifique.');
  end;

  if lVerificarPeriodoManha then
  begin
    lHorasCalculo.Minutos := MinutesBetween(lSaidaAlmoco, lEntrada);
  end;

  if lVerificarPeriodoTarde then
  begin
    lHorasCalculo.Minutos := lHorasCalculo.Minutos + MinutesBetween(lSaidaFinal, lRetornoAlmoco);
  end;

  lHorasCalculo.Horas := lHorasCalculo.Minutos div 60;
  lHorasCalculo.Minutos := lHorasCalculo.Minutos mod 60;

  if (lEntrada = 0) and (lSaidaAlmoco = 0) and (lRetornoAlmoco = 0) and (lSaidaFinal = 0) then
  begin
    lHorasCalculo.Horas := 0;
    lHorasCalculo.Minutos := 0;
  end else
  if lSemAlmoco or ((lEntrada <> 0) and (lSaidaAlmoco = 0) and (lRetornoAlmoco = 0) and (lSaidaFinal <> 0)) then
  begin
    lEntrada := RetornarHorario(Entrada);
    lSaidaFinal := RetornarHorario(SaidaFinal);
    lSaidaFinal := IfThen(lEntrada >= lSaidaFinal, lSaidaFinal.IncDay, lSaidaFinal);

    lHorasCalculo.Horas := HoursBetween(lSaidaFinal, lEntrada);
    lHorasCalculo.Minutos := MinutesBetween(lSaidaFinal, lEntrada) mod 60;
  end;

  lSaldoCalculo.Minutos := ABS((Jornada * 60) - (lHorasCalculo.Horas * 60 + lHorasCalculo.Minutos));

  lSaldoCalculo.Horas := lSaldoCalculo.Minutos div 60;
  lSaldoCalculo.Minutos := lSaldoCalculo.Minutos mod 60;

  Desempenho.TotalTrabalhado := lHorasCalculo.Horas.ToString.PadLeft(2, '0') + ':' + lHorasCalculo.Minutos.ToString.PadLeft(2, '0');
  Desempenho.SaldoHoras := lSaldoCalculo.Horas.ToString.PadLeft(2, '0') + ':' + lSaldoCalculo.Minutos.ToString.PadLeft(2, '0');
  FDesempenho.AtualizarCumprimento(Jornada);
end;

constructor THorariosDia.Create(pTag: TDiaSemana);
begin
  FTag := pTag;
  FDesempenho := TDesempenho.Create;
  FEntrada := EmptyStr;
  FSaidaAlmoco := EmptyStr;
  FRetornoAlmoco := EmptyStr;
  FSaidaFinal := EmptyStr;
  FTurnoNoturno := True;
  FJornada := 0;
end;

procedure THorariosDia.CriarException(pException: ExceptClass; pMensagem: string);
begin
  raise pException.Create(pMensagem);
end;

destructor THorariosDia.Destroy;
begin
  FreeAndNil(FDesempenho);
  inherited;
end;

procedure THorariosDia.InserirEntrada(const pValor: string);
begin
  Entrada := pValor;
end;

procedure THorariosDia.InserirRetornoAlmoco(const pValor: string);
begin
  RetornoAlmoco := pValor;
end;

procedure THorariosDia.InserirSaidaAlmoco(const pValor: string);
begin
  SaidaAlmoco := pValor;
end;

procedure THorariosDia.InserirSaidaFinal(const pValor: string);
begin
  SaidaFinal := pValor;
end;

procedure THorariosDia.Limpar;
begin
  FEntrada := EmptyStr;
  FSaidaAlmoco := EmptyStr;
  FRetornoAlmoco := EmptyStr;
  FSaidaFinal := EmptyStr;
  FDesempenho.Limpar;
  FTurnoNoturno := True;
  FJornada := 0;
end;

function THorariosDia.PegarNomeDaSemana(pNomeCompleto: Boolean = False; pCaracterEspecial: Boolean = False): string;
var
  lNome: string;
begin
  case FTag of
    dsNenhum: lNome := EmptyStr;
    dsSegunda: lNome := 'Segunda-Feira';
    dsTerca: lNome := 'Ter�a-Feira';
    dsQuarta: lNome := 'Quarta-Feira';
    dsQuinta: lNome := 'Quinta-Feira';
    dsSexta: lNome := 'Sexta-Feira'; 
    dsSabado: lNome := 'S�bado'; 
  end;

  if not pNomeCompleto then
  begin  
    lNome := lNome.Replace('-Feira', EmptyStr, [rfReplaceAll]);
  end;

  if not pCaracterEspecial then
  begin
    lNome := lNome.Replace('�', 'c', [rfReplaceAll]);
    lNome := lNome.Replace('�', 'a', [rfReplaceAll]);
  end;

  Result := lNome;
end;

function THorariosDia.RetornarHorario(pHorario: string): TDateTime;
begin
  case pHorario.Trim <> EmptyStr of
    True: Result := StrToDateTime(pHorario);
    else Result := 0;
  end;
end;

procedure THorariosDia.SetSaidaFinalTurnoTradicional(const pValor: string);
begin
  if (FJornada <> 0) then
  begin
    AbortarCasoHorarioZeradoNaoPermitido(pValor);
    AbortarCasoHorarioAtualMenorQueEntrada(pValor);
  end;

  if FTag <> dsSabado then
  begin
    if TExceptionHelpers.VerificarHorarioAtualMenorQueRetornoAlmoco(pValor, RetornoAlmoco) then
    begin
      CriarException(EHorarioAtualMenorQueRetornoAlmoco, 'O hor�rio atual est� menor que o hor�rio "Retorno-Almo�o"' + ', verifique.');
    end;

    AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);
  end;
end;

procedure THorariosDia.SetSaidaAlmocoTurnoTradicional(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioRetornoAlmocoNaoZerado(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioRetornoAlmocoNaoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Retorno-Almo�o"' + ' n�o est� zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioRetornoAlmocoZerado(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioRetornoAlmocoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Retorno-Almo�o"' + ' est� zerado, verifique.');
  end;

  AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);
  AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  AbortarCasoHorarioAtualMenorQueEntrada(pValor);
end;

procedure THorariosDia.SetRetornoAlmocoTurnoTradicional(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioSaidaAlmocoNaoZerado(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioSaidaAlmocoNaoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Sa�da-Almo�o"' + ' n�o est� zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioSaidaAlmocoZerado(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioSaidaAlmocoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Sa�da-Almo�o"' + ' est� zerado, verifique.');
  end;

  AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);
  AbortarCasoHorarioAtualMenorQueEntrada(pValor);
end;

procedure THorariosDia.SetEntradaTurnoTradicional(const pValor: string);
begin
  if (FJornada <> 0) then
  begin
    AbortarCasoHorarioZeradoNaoPermitido(pValor);
    AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  end;

  if FTag <> dsSabado then
  begin
    if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor, SaidaAlmoco) then
    begin
      CriarException(EHorarioAtualMaiorQueSaidaAlmoco, 'O hor�rio atual est� maior que "Sa�da-Almo�o", verifique.');
    end;

    AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMenorQueSaidaAlmoco(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMenorQueSaidaAlmoco(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioAtualMenorQueSaidaAlmoco, 'O hor�rio inserido est� menor que o hor�rio "Sa�da-Almo�o"'+
      ', verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioZeradoNaoPermitido(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioZeradoNaoPermitido(pValor) then
  begin
    CriarException(EHorarioZeradoNaoPermitido, 'N�o � permitido zerar o hor�rio atual, verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMaiorQueRetornoAlmoco(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioAtualMaiorQueRetornoAlmoco, 'O hor�rio inserido est� maior que o hor�rio "Retorno-Almo�o"' +
      ', verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMenorQueEntrada(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMenorQueEntrada(pValor, Entrada) then
  begin
    CriarException(EHorarioAtualMenorQueEntrada, 'O hor�rio inserido est� menor que o hor�rio "Entrada", verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMaiorQueSaidaFinal(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaFinal(pValor, SaidaFinal) then
  begin
    CriarException(EHorarioAtualMaiorQueSaidaFinal, 'O Hor�rio inserido est� maior que o hor�rio "Sa�da-Final", ' +
      'verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioInvalido(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioInvalido(pValor) then
  begin
    CriarException(EHorarioInvalido, 'O hor�rio inserido � inv�lido, verifique.');
  end;
end;

procedure THorariosDia.SetEntrada(const pValor: string);
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FEntrada := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);

  if not TurnoNoturno then
  begin
    SetEntradaTurnoTradicional(pValor);
  end;

  FEntrada := pValor;
end;

procedure THorariosDia.SetRetornoAlmoco(const pValor: string);
var
  lValor, lSaidaAlmoco: TDateTime;
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FRetornoAlmoco := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);
  lValor := StrToDateTime(pValor);

  if not SaidaAlmoco.Trim.IsEmpty and TurnoNoturno then
  begin
    lSaidaAlmoco := StrToTime(SaidaAlmoco);
    lValor := IfThen(lSaidaAlmoco > lValor, lValor.IncDay, lValor);

    if HoursBetween(lValor, lSaidaAlmoco) > 5 then // Assim ele me comprova que ficou "Al�m do horario de almo�o"
    begin
      try
        AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);
      except
        CriarException(EHorarioAtualMenorQueSaidaAlmoco, 'O hor�rio inserido est� bem distante do hor�rio "Sa�da-Almo�o"'+
          ', verifique.');
      end;
    end;
  end;

  if not TurnoNoturno then
  begin
    SetRetornoAlmocoTurnoTradicional(pValor);
  end;

  FRetornoAlmoco := pValor;
end;

procedure THorariosDia.SetSaidaAlmoco(const pValor: string);
var
  lValor, lRetornoAlmoco: TDateTime;
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FSaidaAlmoco := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);
  lValor := StrToDateTime(pValor);

  if not RetornoAlmoco.Trim.IsEmpty and TurnoNoturno then
  begin
    lRetornoAlmoco := StrToTime(RetornoAlmoco);
    lRetornoAlmoco := IfThen(lRetornoAlmoco < lValor, lRetornoAlmoco.IncDay, lRetornoAlmoco);

    if HoursBetween(lValor, lRetornoAlmoco) > 5 then
    begin
      try
        AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);
      except
        CriarException(EHorarioAtualMaiorQueRetornoAlmoco, 'O hor�rio inserido est� bem distante do hor�rio "Retorno-Almo�o"' +
          ', verifique.');
      end;
    end;
  end;

  if not TurnoNoturno then
  begin
    SetSaidaAlmocoTurnoTradicional(pValor);
  end;

  FSaidaAlmoco := pValor;
end;

procedure THorariosDia.SetSaidaFinal(const pValor: string);
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FSaidaFinal := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);

  if not TurnoNoturno then
  begin
    SetSaidaFinalTurnoTradicional(pValor);
  end;

  FSaidaFinal := pValor;
end;

function THorariosDia.VerificarHorarioVazio(const pValor: string): Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(pValor);
end;

end.
