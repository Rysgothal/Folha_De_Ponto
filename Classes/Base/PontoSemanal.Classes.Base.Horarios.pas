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
  public
    constructor Create(pTag: TDiaSemana);
    property Tag: TDiaSemana read FTag write FTag;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaAlmoco: string read FSaidaAlmoco write SetSaidaAlmoco;
    property RetornoAlmoco: string read FRetornoAlmoco write SetRetornoAlmoco;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    property Desempenho: TDesempenho read FDesempenho write FDesempenho;
    property Jornada: Integer read FJornada write FJornada;
    procedure InserirEntrada(const pValor: string);
    procedure InserirSaidaAlmoco(const pValor: string);
    procedure InserirRetornoAlmoco(const pValor: string);
    procedure InserirSaidaFinal(const pValor: string);
    procedure CalcularHorasTrabalhadas;
  end;

implementation

uses
  PontoSemanal.Helpers.Strings;

{ TDiaHorarios }

procedure THorariosDia.CalcularHorasTrabalhadas;
var
  lHorasTrabalhadas, lSaldoHoras: TTime;
  lVerificarPeriodoDaManha, lVerificarPeriodoTarde, lVerificarPeriodoIntegral: Boolean;
begin
  lHorasTrabalhadas := 0;

  lVerificarPeriodoDaManha := (FEntrada <> EmptyStr) and (FSaidaAlmoco <> EmptyStr) and (FSaidaAlmoco <> '00:00');
  lVerificarPeriodoTarde := (FRetornoAlmoco <> EmptyStr) and (FRetornoAlmoco <> '00:00') and (FSaidaFinal <> EmptyStr);
  lVerificarPeriodoIntegral := lVerificarPeriodoDaManha and lVerificarPeriodoTarde;

  if lVerificarPeriodoDaManha then
  begin
    lHorasTrabalhadas := StrToTime(FSaidaAlmoco) - StrToTime(FEntrada);
  end;

  if lVerificarPeriodoTarde then
  begin
    lHorasTrabalhadas := lHorasTrabalhadas + StrToTime(FRetornoAlmoco) - StrToTime(FSaidaFinal);
  end;

  if (FEntrada <> EmptyStr) and (FSaidaFinal <> EmptyStr) and (lHorasTrabalhadas = 0) then
  begin
    lHorasTrabalhadas :=  StrToTime(FSaidaFinal) - StrToTime(FEntrada);
  end;

  if lVerificarPeriodoIntegral then
  begin
    lHorasTrabalhadas := StrToTime(FSaidaAlmoco) - StrToTime(FEntrada) + StrToTime(FSaidaFinal) -
      StrToTime(FRetornoAlmoco);
  end;

  if (FEntrada = EmptyStr) and (FSaidaFinal = EmptyStr) then
  begin
    lHorasTrabalhadas := 0;
  end;

  lSaldoHoras := lHorasTrabalhadas - StrToTime(IntToStr(Jornada));

  Desempenho.TotalTrabalhado := FormatDateTime('hh:mm', lHorasTrabalhadas);
  Desempenho.SaldoHoras := FormatDateTime('hh:mm', lSaldoHoras);
  FDesempenho.AtualizarCumprimento(Jornada);
end;

constructor THorariosDia.Create(pTag: TDiaSemana);
begin
  FTag := pTag;
  FDesempenho := TDesempenho.Create;
  FJornada := 0;
end;

procedure THorariosDia.CriarException(pException: ExceptClass; pMensagem: string);
begin
  raise pException.Create(pMensagem);
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
  AbortarCasoHorarioZeradoNaoPermitido(pValor);
  AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);

  if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioAtualMaiorQueSaidaAlmoco, 'O hor�rio atual est� maior que "Sa�da-Almo�o", verifique.');
  end;

  AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);

  FEntrada := pValor;
end;

procedure THorariosDia.SetRetornoAlmoco(const pValor: string);
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FRetornoAlmoco := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);

  if TExceptionHelpers.VerificarHorarioSaidaAlmocoNaoZerado(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioSaidaAlmocoNaoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Sa�da-Almo�o"' +
      ' n�o est� zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioSaidaAlmocoZerado(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioSaidaAlmocoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Sa�da-Almo�o"' +
      ' est� zerado, verifique.');
  end;

  AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);
  AbortarCasoHorarioAtualMenorQueEntrada(pValor);

  FRetornoAlmoco := pValor;
end;

procedure THorariosDia.SetSaidaAlmoco(const pValor: string);
begin
  if VerificarHorarioVazio(pValor) then
  begin
    FSaidaAlmoco := EmptyStr;
    Exit;
  end;

  AbortarCasoHorarioInvalido(pValor);

  if TExceptionHelpers.VerificarHorarioRetornoAlmocoNaoZerado(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioRetornoAlmocoNaoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Retorno-Almo�o"' +
      ' n�o est� zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioRetornoAlmocoZerado(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioRetornoAlmocoZerado, 'O hor�rio atual n�o pode ser aceito, j� que o hor�rio "Retorno-Almo�o"' +
      ' est� zerado, verifique.');
  end;

  AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);
  AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  AbortarCasoHorarioAtualMenorQueEntrada(pValor);

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
  AbortarCasoHorarioZeradoNaoPermitido(pValor);
  AbortarCasoHorarioAtualMenorQueEntrada(pValor);

  if TExceptionHelpers.VerificarHorarioAtualMenorQueRetornoAlmoco(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioAtualMenorQueRetornoAlmoco, 'O hor�rio atual est� menor que o hor�rio "Retorno-Almo�o"' +
      ', verifique.');
  end;

  AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);

  FSaidaFinal := pValor;
end;

function THorariosDia.VerificarHorarioVazio(const pValor: string): Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(pValor) or (pValor = '__:__');
end;

end.