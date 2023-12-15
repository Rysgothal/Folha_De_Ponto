unit PontoSemanal.Helpers.Strings;

interface

uses
  System.SysUtils;

type
  TStringHelpers = class abstract
  private
    class function DigitarSomente(const pValor: string; pCharSet: TSysCharSet): string;
  public
    class function DigitarSomenteNumeros(const pValor: string): string;
    class function DigitarSomenteLetras(const pValor: string): string;
    class function Completar(const pValor: string; pQuantidade: Integer; pValorAPreencher: Char = ' '): string;
    class function VerificarCampoVazio(const pValor: string): Boolean;
  end;

implementation

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
  DigitarSomente(pValor, ['a'..'z', 'A'..'Z', #32]);
end;

class function TStringHelpers.DigitarSomenteNumeros(const pValor: string): string;
begin
  DigitarSomente(pValor, ['0'..'9']);
end;

class function TStringHelpers.VerificarCampoVazio(const pValor: string): Boolean;
begin
  Result := pValor.Trim = EmptyStr;
end;

end.
