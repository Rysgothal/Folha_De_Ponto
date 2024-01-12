unit PontoSemanal.Helpers.Strings;

interface

uses
  System.SysUtils, System.Classes, PontoSemanal.Helpers.Constantes;

type
  TPositions = array of Integer;
  TChars = array of Char;

  TStringHelpers = class abstract
  private
    class function DigitarSomente(const pValor: string; pCharSet: TSysCharSet): string;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChar: Char); overload;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChars: TChars); overload;
    class procedure InsertChar(var pValor: string; const pPos: Integer; const pChar: Char); overload;
  public
    class function DigitarSomenteNumeros(const pValor: string): string;
    class function DigitarSomenteLetras(const pValor: string): string;
    class function Completar(const pValor: string; pQuantidade: Integer; pValorAPreencher: Char = ' '): string;
    class function VerificarCampoVazio(const pValor: string): Boolean;
    class function FormatarData(const pValor: string): string;
    class function IntervaloPorExtenso(const pValor: string): string;
    class function FormatarHorario(const pValor: string): string;
    class function HashMD5(pValor: string): string;
    class function VerificarDiferenca(pValor, pValorCompara: string): Boolean;
  end;

implementation

uses
  System.Math, System.StrUtils, System.Hash;

{ TStringHelpers }

class function TStringHelpers.Completar(const pValor: string; pQuantidade: Integer; pValorAPreencher: Char): string;
begin
  Result := pValor.PadLeft(pQuantidade, pValorAPreencher);
end;

class function TStringHelpers.DigitarSomente(const pValor: string; pCharSet: TSysCharSet): string;
begin
  for var lChar in pValor do
  begin
    if CharInSet(lChar, pCharSet) then
    begin
      Result := Result + lChar;
    end;
  end;
end;

class function TStringHelpers.DigitarSomenteLetras(const pValor: string): string;
begin
  Result := DigitarSomente(pValor, ['a'..'z', 'A'..'Z', #32]);
end;

class function TStringHelpers.DigitarSomenteNumeros(const pValor: string): string;
begin
  Result := DigitarSomente(pValor, ['0'..'9']);
end;

class function TStringHelpers.FormatarData(const pValor: string): string;
begin
  Result := DigitarSomenteNumeros(pValor).Substring(0, 14);
  InsertChars(Result, [4, 2], '/')
end;

class function TStringHelpers.FormatarHorario(const pValor: string): string;
begin
  Result := DigitarSomenteNumeros(pValor).Substring(0,8);
  InsertChars(Result, [2], ':')
end;

class function TStringHelpers.HashMD5(pValor: string): string;
var
  lHash: THashMD5;
begin
  lHash := THashMD5.Create;
  Result := lHash.GetHashString(pValor + TConstantes.HASH_SALTING);
end;

class procedure TStringHelpers.InsertChars(var pValor: string; const pPos: TPositions; const pChar: Char);
begin
  InsertChars(pValor, pPos, [pChar]);
end;

class procedure TStringHelpers.InsertChars(var pValor: string; const pPos: TPositions; const pChars: TChars);
var
  I, vPosCount, vCharsCount: Integer;
  pChar: Char;
begin
  vPosCount := Length(pPos);
  for I := 0 to Pred(vPosCount) do
  begin
    vCharsCount := Pred(Length(pChars));
    pChar := pChars[Min(vCharsCount, I)];
    InsertChar(pValor, pPos[i], pChar);
  end;
end;

class function TStringHelpers.IntervaloPorExtenso(const pValor: string): string;
var
  lHoras, lMinutos: Integer;
  lIntervalo: TDateTime;
begin
  Result := '"x" horas e "y" minutos';

  if not TryStrToTime(pValor, lIntervalo) then
  begin
    Exit;
  end;

  lHoras := SplitString(pValor, ':')[0].ToInteger;
  lMinutos := SplitString(pValor, ':')[1].ToInteger;

  case lHoras of
    0: ;
    1: Result := lHoras.ToString + ' hora' + IfThen(lMinutos.ToString > '0', ' e ');
    else Result := lHoras.ToString + ' horas' + IfThen(lMinutos.ToString > '0', ' e ');
  end;

  case lMinutos of
    0: ;
    1: Result := Result + lMinutos.ToString + ' minuto';
    else Result := Result + lMinutos.ToString + ' minutos';
  end;
end;

class procedure TStringHelpers.InsertChar(var pValor: string; const pPos: Integer; const pChar: Char);
begin
  if pValor.Length > pPos then
  begin
    pValor.Insert(pPos, pChar);
  end;
end;

class function TStringHelpers.VerificarCampoVazio(const pValor: string): Boolean;
var
  lValor: string;
begin
  lValor := StringReplace(pValor.Trim, '_', EmptyStr, [rfReplaceAll]);
  lValor := StringReplace(lValor.Trim, ':', EmptyStr, [rfReplaceAll]);
  Result := lValor.Trim = EmptyStr;
end;

class function TStringHelpers.VerificarDiferenca(pValor, pValorCompara: string): Boolean;
begin
  Result := pValor <> pValorCompara;
end;

end.

