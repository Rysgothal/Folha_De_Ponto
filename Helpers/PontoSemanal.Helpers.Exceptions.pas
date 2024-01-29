unit PontoSemanal.Helpers.Exceptions;

interface

uses
  System.SysUtils;

type
  { Data de Admissão }
  EDataInvalida = class(Exception);
  EDataUltrapassada = class(Exception);
  EDataAlemDosDiasAtuais = class(Exception);

  { Horas Jornada Semanal }
  EJornadaSemanalInvalida = class(Exception);
  EJornadaSemanalNaoPermitidaLei = class(Exception);

  { Intervalo de Almoço }
  EIntervaloAlmocoInvalido = class(Exception);

  { Horarios - Maior que}
  EHorarioAtualMaiorQueSaidaAlmoco = class(Exception);
  EHorarioAtualMaiorQueRetornoAlmoco = class(Exception);
  EHorarioAtualMaiorQueSaidaFinal = class(Exception);

  { Horarios - Menor que }
  EHorarioAtualMenorQueEntrada = class(Exception);
  EHorarioAtualMenorQueSaidaAlmoco = class(Exception);
  EHorarioAtualMenorQueRetornoAlmoco = class(Exception);

  { Horarios Zerados }
  EHorarioSaidaAlmocoZerado = class(Exception);
  EHorarioSaidaAlmocoNaoZerado = class(Exception);
  EHorarioRetornoAlmocoZerado = class(Exception);
  EHorarioRetornoAlmocoNaoZerado = class(Exception);
  EHorarioInvalido = class(Exception);
  EHorarioZeradoNaoPermitido = class(Exception);

  { Geral }
  ETotalTrabalhadoMaisDeUmDia = class(Exception);

  TExceptionHelpers = class abstract
  private
    class function VerificarHorarioAtualMaiorQuePosterior(pHoraAtual, pHoraPosterior: string): Boolean;
    class function VerificarHorarioAtualMenorQueAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
  public
    class function VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor, pSaidaAlmoco: string): Boolean;
    class function VerificarHorarioAtualMaiorQueRetornoAlmoco(pValor, pRetornoAlmoco: string): Boolean;
    class function VerificarHorarioAtualMaiorQueSaidaFinal(pValor, pSaidaFinal: string): Boolean;
    class function VerificarHorarioAtualMenorQueEntrada(pValor, pEntrada: string): Boolean;
    class function VerificarHorarioAtualMenorQueSaidaAlmoco(pValor, pSaidaAlmoco: string): Boolean;
    class function VerificarHorarioAtualMenorQueRetornoAlmoco(pValor, pRetornoAlmoco: string): Boolean;
    class function VerificarHorarioSaidaAlmocoNaoZerado(pValor, pSaidaAlmoco: string): Boolean;
    class function VerificarHorarioSaidaAlmocoZerado(pValor, pSaidaAlmoco: string): Boolean;
    class function VerificarHorarioRetornoAlmocoNaoZerado(pValor, pRetornoAlmoco: string): Boolean;
    class function VerificarHorarioRetornoAlmocoZerado(pValor, pRetornoAlmoco: string): Boolean;
    class function VerificarHorarioInvalido(pValor: string): Boolean;
    class function VerificarHorarioZeradoNaoPermitido(pValor: string): Boolean;
  end;

implementation

{ TExceptionHelpers }

class function TExceptionHelpers.VerificarHorarioSaidaAlmocoNaoZerado(pValor: string; pSaidaAlmoco: string): Boolean;
begin
  Result := (StrToTime(pValor) = 0) and (pSaidaAlmoco <> '00:00') and (pSaidaAlmoco <> EmptyStr);
end;

class function TExceptionHelpers.VerificarHorarioSaidaAlmocoZerado(pValor: string; pSaidaAlmoco: string): Boolean;
begin
  Result := (StrToTime(pValor) <> 0) and (pSaidaAlmoco = '00:00');
end;

class function TExceptionHelpers.VerificarHorarioAtualMaiorQueRetornoAlmoco(pValor: string; pRetornoAlmoco: string): Boolean;
begin
  Result := VerificarHorarioAtualMaiorQuePosterior(pValor, pRetornoAlmoco) and (StrToTime(pRetornoAlmoco) <> 0);
end;

class function TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor: string; pSaidaAlmoco: string): Boolean;
begin
  Result := VerificarHorarioAtualMaiorQuePosterior(pValor, pSaidaAlmoco) and (StrToTime(pSaidaAlmoco) <> 0);
end;

class function TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaFinal(pValor: string; pSaidaFinal: string): Boolean;
begin
  Result := VerificarHorarioAtualMaiorQuePosterior(pValor, pSaidaFinal);
end;

class function TExceptionHelpers.VerificarHorarioAtualMenorQueEntrada(pValor: string; pEntrada: string): Boolean;
begin
  Result := VerificarHorarioAtualMenorQueAnterior(pValor, pEntrada) and (StrToTime(pValor) <> 0);
end;

class function TExceptionHelpers.VerificarHorarioAtualMenorQueRetornoAlmoco(pValor: string; pRetornoAlmoco: string): Boolean;
begin
  Result := VerificarHorarioAtualMenorQueAnterior(pValor, pRetornoAlmoco) and (StrToTime(pRetornoAlmoco) <> 0);
end;

class function TExceptionHelpers.VerificarHorarioAtualMenorQueSaidaAlmoco(pValor: string; pSaidaAlmoco: string): Boolean;
begin
  Result := VerificarHorarioAtualMenorQueAnterior(pValor, pSaidaAlmoco) and (StrToTime(pSaidaAlmoco) <> 0);
end;

class function TExceptionHelpers.VerificarHorarioInvalido(pValor: string): Boolean;
var
  lTime: TDateTime;
begin
  Result := not TryStrToTime(pValor, lTime);
end;

class function TExceptionHelpers.VerificarHorarioRetornoAlmocoNaoZerado(pValor: string; pRetornoAlmoco: string): Boolean;
begin
  Result := (StrToTime(pValor) = 0) and (pRetornoAlmoco <> '00:00') and (pRetornoAlmoco <> EmptyStr);
end;

class function TExceptionHelpers.VerificarHorarioRetornoAlmocoZerado(pValor: string; pRetornoAlmoco: string): Boolean;
begin
  Result := (StrToTime(pValor) <> 0) and (pRetornoAlmoco = '00:00') and (pRetornoAlmoco <> EmptyStr);
end;

class function TExceptionHelpers.VerificarHorarioZeradoNaoPermitido(pValor: string): Boolean;
begin
  Result := FormatDateTime('hh:mm', StrToTime(pValor)) = '00:00';
end;

class function TExceptionHelpers.VerificarHorarioAtualMenorQueAnterior(pHoraAtual, pHoraAnterior: string): Boolean;
begin
  Result := (pHoraAnterior <> EmptyStr) and (StrToTime(pHoraAtual) < StrToTime(pHoraAnterior));
end;

class function TExceptionHelpers.VerificarHorarioAtualMaiorQuePosterior(pHoraAtual, pHoraPosterior: string): Boolean;
begin
  Result := (pHoraPosterior <> EmptyStr) and (StrToTime(pHoraAtual) > StrToTime(pHoraPosterior));
end;

end.
