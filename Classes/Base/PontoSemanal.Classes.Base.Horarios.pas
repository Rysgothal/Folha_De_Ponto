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
    destructor Destroy; override;
    property Tag: TDiaSemana read FTag;
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
    procedure Limpar;
    function PegarNomeDaSemana(pNomeCompleto: Boolean = False; pCaracterEspecial: Boolean = False): string;
  end;

implementation

uses
  PontoSemanal.Helpers.Strings;

{ TDiaHorarios }

procedure THorariosDia.CalcularHorasTrabalhadas;
var
  lHorasTrabalhadas, lSaldoHoras: TTime;
  lVerificarPeriodoManha, lVerificarPeriodoTarde, lSemAlmoco, lSaidaAlmocoNulo, lRetornoAlmocoNulo: Boolean;
begin
  lHorasTrabalhadas := 0;

  lSaidaAlmocoNulo := (SaidaAlmoco = EmptyStr) or (SaidaAlmoco = '00:00');
  lRetornoAlmocoNulo := (RetornoAlmoco = EmptyStr) or (RetornoAlmoco = '00:00');

  lVerificarPeriodoManha := (Entrada <> EmptyStr) and not lSaidaAlmocoNulo;
  lVerificarPeriodoTarde := (SaidaFinal <> EmptyStr) and not lRetornoAlmocoNulo;
  lSemAlmoco := (Entrada <> EmptyStr) and (SaidaFinal <> EmptyStr) and lSaidaAlmocoNulo and lRetornoAlmocoNulo;

  if lVerificarPeriodoManha then
  begin
    lHorasTrabalhadas := StrToTime(SaidaAlmoco) - StrToTime(Entrada);
  end;

  if lVerificarPeriodoTarde then
  begin
    lHorasTrabalhadas := lHorasTrabalhadas + (StrToTime(SaidaFinal) - StrToTime(RetornoAlmoco));
  end;

  if lSemAlmoco then
  begin
    lHorasTrabalhadas :=  StrToTime(FSaidaFinal) - StrToTime(FEntrada);
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
  FJornada := 0;
end;

function THorariosDia.PegarNomeDaSemana(pNomeCompleto: Boolean = False; pCaracterEspecial: Boolean = False): string;
var
  lNome: string;
begin
  case FTag of
    dsNenhum: lNome := EmptyStr;
    dsSegunda: lNome := 'Segunda-Feira';
    dsTerca: lNome := 'Terça-Feira';
    dsQuarta: lNome := 'Quarta-Feira';
    dsQuinta: lNome := 'Quinta-Feira';
    dsSexta: lNome := 'Sexta-Feira'; 
    dsSabado: lNome := 'Sábado'; 
  end;

  if not pNomeCompleto then
  begin  
    lNome := lNome.Replace('-Feira', EmptyStr, [rfReplaceAll]);
  end;

  if not pCaracterEspecial then
  begin
    lNome := lNome.Replace('ç', 'c', [rfReplaceAll]);
    lNome := lNome.Replace('á', 'a', [rfReplaceAll]);
  end;

  Result := lNome;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMenorQueSaidaAlmoco(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMenorQueSaidaAlmoco(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioAtualMenorQueSaidaAlmoco, 'O horário inserido está menor que o horário "Saída-Almoço"'+
      ', verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioZeradoNaoPermitido(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioZeradoNaoPermitido(pValor) then
  begin
    CriarException(EHorarioZeradoNaoPermitido, 'Não é permitido zerar o horário atual, verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMaiorQueRetornoAlmoco(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioAtualMaiorQueRetornoAlmoco, 'O horário inserido está maior que o horário "Retorno-Almoço"' +
      ', verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMenorQueEntrada(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMenorQueEntrada(pValor, Entrada) then
  begin
    CriarException(EHorarioAtualMenorQueEntrada, 'O horário inserido está menor que o horário "Entrada", verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioAtualMaiorQueSaidaFinal(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaFinal(pValor, SaidaFinal) then
  begin
    CriarException(EHorarioAtualMaiorQueSaidaFinal, 'O Horário inserido está maior que o horário "Saída-Final", ' +
      'verifique.');
  end;
end;

procedure THorariosDia.AbortarCasoHorarioInvalido(const pValor: string);
begin
  if TExceptionHelpers.VerificarHorarioInvalido(pValor) then
  begin
    CriarException(EHorarioInvalido, 'O horário inserido é inválido, verifique.');
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

  if (FJornada <> 0) then
  begin
    AbortarCasoHorarioZeradoNaoPermitido(pValor);
    AbortarCasoHorarioAtualMaiorQueSaidaFinal(pValor);
  end;

  if FTag <> dsSabado then
  begin
    if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor, SaidaAlmoco) then
    begin
      CriarException(EHorarioAtualMaiorQueSaidaAlmoco, 'O horário atual está maior que "Saída-Almoço", verifique.');
    end;

    AbortarCasoHorarioAtualMaiorQueRetornoAlmoco(pValor);
  end;

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
    CriarException(EHorarioSaidaAlmocoNaoZerado, 'O horário atual não pode ser aceito, já que o horário "Saída-Almoço"' +
      ' não está zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioSaidaAlmocoZerado(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioSaidaAlmocoZerado, 'O horário atual não pode ser aceito, já que o horário "Saída-Almoço"' +
      ' está zerado, verifique.');
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
    CriarException(EHorarioRetornoAlmocoNaoZerado, 'O horário atual não pode ser aceito, já que o horário "Retorno-Almoço"' +
      ' não está zerado, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioRetornoAlmocoZerado(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioRetornoAlmocoZerado, 'O horário atual não pode ser aceito, já que o horário "Retorno-Almoço"' +
      ' está zerado, verifique.');
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

  if (FJornada <> 0) then
  begin
    AbortarCasoHorarioZeradoNaoPermitido(pValor);
    AbortarCasoHorarioAtualMenorQueEntrada(pValor);
  end;

  if FTag <> dsSabado then
  begin
    if TExceptionHelpers.VerificarHorarioAtualMenorQueRetornoAlmoco(pValor, RetornoAlmoco) then
    begin
      CriarException(EHorarioAtualMenorQueRetornoAlmoco, 'O horário atual está menor que o horário "Retorno-Almoço"' +
        ', verifique.');
    end;

    AbortarCasoHorarioAtualMenorQueSaidaAlmoco(pValor);
  end;

  FSaidaFinal := pValor;
end;

function THorariosDia.VerificarHorarioVazio(const pValor: string): Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(pValor);
end;

end.
