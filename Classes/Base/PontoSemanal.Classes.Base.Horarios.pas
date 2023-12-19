unit PontoSemanal.Classes.Base.Horarios;

interface

uses
  PontoSemanal.Helpers.Enumerados, System.SysUtils,
  PontoSemanal.Helpers.Exceptions;

type
  THorariosDia = class
  private
    FTag: TDiaSemana;
    FEntrada: string;
    FSaidaAlmoco: string;
    FRetornoAlmoco: string;
    FSaidaFinal: string;
    procedure SetEntrada(const pValor: string);
    procedure SetRetornoAlmoco(const pValor: string);
    procedure SetSaidaAlmoco(const pValor: string);
    procedure SetSaidaFinal(const pValor: string);
    procedure CriarException(pException: ExceptClass; pMensagem: string);
  public
    constructor Create(pTag: TDiaSemana);
    property Tag: TDiaSemana read FTag write FTag;
    property Entrada: string read FEntrada write SetEntrada;
    property SaidaAlmoco: string read FSaidaAlmoco write SetSaidaAlmoco;
    property RetornoAlmoco: string read FRetornoAlmoco write SetRetornoAlmoco;
    property SaidaFinal: string read FSaidaFinal write SetSaidaFinal;
    procedure InserirEntrada(const pValor: string);
    procedure InserirSaidaAlmoco(const pValor: string);
    procedure InserirRetornoAlmoco(const pValor: string);
    procedure InserirSaidaFinal(const pValor: string);
  end;

implementation

uses
  PontoSemanal.Helpers.Strings;

{ TDiaHorarios }

constructor THorariosDia.Create(pTag: TDiaSemana);
begin
  FTag := pTag;
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

procedure THorariosDia.SetEntrada(const pValor: string);
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FEntrada := EmptyStr;
    Exit;
  end;

  if TExceptionHelpers.VerificarHorarioInvalido(pValor) then
  begin
    CriarException(EHorarioInvalido, 'O horário inserido é inválido, verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioZeradoNaoPermitido(pValor) then
  begin
    CriarException(EHorarioZeradoNaoPermitido, 'Não é permitido zerar o horário de "Entrada", verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaFinal(pValor, SaidaFinal) then
  begin
    CriarException(EHorarioAtualMaiorQueSaidaFinal, 'Esse horário está maior que "Saída-Final", verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioAtualMaiorQueSaidaAlmoco(pValor, SaidaAlmoco) then
  begin
    CriarException(EHorarioAtualMaiorQueSaidaAlmoco, 'Esse horário está maior que "Saída-Almoço", verifique.');
  end;

  if TExceptionHelpers.VerificarHorarioAtualMaiorQueRetornoAlmoco(pValor, RetornoAlmoco) then
  begin
    CriarException(EHorarioAtualMaiorQueRetornoAlmoco, 'Esse horário está maior que "Retorno-Almoço", verifique.');
  end;

  FEntrada := pValor;
end;

procedure THorariosDia.SetRetornoAlmoco(const pValor: string);
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FRetornoAlmoco := EmptyStr;
    Exit;
  end;

  FRetornoAlmoco := pValor;
end;

procedure THorariosDia.SetSaidaAlmoco(const pValor: string);
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FSaidaAlmoco := EmptyStr;
    Exit;
  end;

  FSaidaAlmoco := pValor;
end;

procedure THorariosDia.SetSaidaFinal(const pValor: string);
begin
  if TStringHelpers.VerificarCampoVazio(pValor) then
  begin
    FSaidaFinal := EmptyStr;
    Exit;
  end;

  FSaidaFinal := pValor;
end;

end.
