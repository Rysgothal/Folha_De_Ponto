unit PontoSemanal.Helpers.Componentes;

interface

uses
  Vcl.StdCtrls, Vcl.Controls;

type
  TComponenteHelpers = class abstract
  public
    class procedure DigitarSomenteNumeros(const pEdit: TCustomEdit);
    class procedure DigitarSomenteLetras(const pEdit: TCustomEdit);
    class procedure Completar(const pEdit: TCustomEdit; pQuantidade: Integer; pValorAPreencher: Char = ' ');
    class function VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
    class function VerificarTodosCamposVazio(const pEdits: TArray<TCustomEdit>): Boolean;
    class function VerificarEditVazio(const pEdits: TArray<TCustomEdit>): TCustomEdit;
    class procedure FormatarData(const pEdit: TCustomEdit);
    class procedure MoverFinal(const pEdit: TCustomEdit);
    class procedure FormatarIntervalo(const pEdit: TCustomEdit);
    class procedure FormatarHorario(const pEdit: TCustomEdit);
    class procedure Focar(const pEdit: TWinControl);
  end;

  TMemoHelper = class Helper for TMemo
  public
    procedure FocarCabecalho;
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

class procedure TComponenteHelpers.Focar(const pEdit: TWinControl);
begin
  if pEdit.CanFocus then
  begin
    pEdit.SetFocus;
  end;
end;

class procedure TComponenteHelpers.FormatarData(const pEdit: TCustomEdit);
begin
  pEdit.Text := TStringHelpers.FormatarData(pEdit.Text);
  MoverFinal(pEdit);
end;

class procedure TComponenteHelpers.FormatarHorario(const pEdit: TCustomEdit);
begin
  pEdit.Text := TStringHelpers.FormatarHorario(pEdit.Text);
  MoverFinal(pEdit);
end;

class procedure TComponenteHelpers.FormatarIntervalo(const pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(pEdit) then
  begin
    Exit;
  end;

  Completar(pEdit, 4, '0');
end;

class procedure TComponenteHelpers.MoverFinal(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := Length(pEdit.Text);
end;

class function TComponenteHelpers.VerificarEditVazio(const pEdits: TArray<TCustomEdit>): TCustomEdit;
begin
  Result := nil;

  for var lComponente in pEdits do
  begin
    if not VerificarCampoVazio(lComponente) then
    begin
      Continue;
    end;

    Result := lComponente;
    Break;
  end;
end;

class function TComponenteHelpers.VerificarTodosCamposVazio(const pEdits: TArray<TCustomEdit>): Boolean;
begin
  Result := True;

  for var lComponente in pEdits do
  begin
    if VerificarCampoVazio(lComponente) then
    begin
      Continue;
    end;

    Result := False;
    Break;
  end;
end;

class function TComponenteHelpers.VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(pEdit.Text);
end;

{ TMemoHelper }

procedure TMemoHelper.FocarCabecalho;
begin
  SelStart := 1;
  SelLength := 1;
end;

end.
