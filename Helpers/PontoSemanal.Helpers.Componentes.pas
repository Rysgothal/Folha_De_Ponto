unit PontoSemanal.Helpers.Componentes;

interface

uses
  Vcl.StdCtrls;

type
  TComponenteHelpers = class Helper for TCustomEdit
  public
    class procedure DigitarSomenteNumeros(const pEdit: TCustomEdit);
    class procedure DigitarSomenteLetras(const pEdit: TCustomEdit);
    class procedure Completar(const pEdit: TCustomEdit; pQuantidade: Integer; pValorAPreencher: Char = ' ');
    class function VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
    class procedure FormatarData(const pEdit: TCustomEdit);
    class procedure MoverFinal(const pEdit: TCustomEdit);
  end;

implementation

uses
  PontoSemanal.Helpers.Strings;

{ TComponenteHelpers }

class procedure TComponenteHelpers.Completar(const pEdit: TCustomEdit; pQuantidade: Integer; pValorAPreencher: Char = ' ');
begin
  pEdit.Text := TStringHelpers.Completar(pEdit.Text, pQuantidade, pValorAPreencher);
end;

class procedure TComponenteHelpers.DigitarSomenteLetras(const pEdit: TCustomEdit);
begin
  pEdit.Text := TStringHelpers.DigitarSomenteLetras(pEdit.Text);
end;

class procedure TComponenteHelpers.DigitarSomenteNumeros(const pEdit: TCustomEdit);
begin
  pEdit.Text := TStringHelpers.DigitarSomenteNumeros(pEdit.Text);
end;

class procedure TComponenteHelpers.FormatarData(const pEdit: TCustomEdit);
begin
  pEdit.Text := TStringHelpers.FormatarData(pEdit.Text);
  MoverFinal(pEdit);
end;

class procedure TComponenteHelpers.MoverFinal(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := Length(pEdit.Text);
end;

class function TComponenteHelpers.VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(pEdit.Text);
end;

end.
