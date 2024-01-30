unit PontoSemanal.Helpers.Componentes;

interface

uses
  Vcl.StdCtrls, Vcl.Controls, System.SysUtils;

type
  TComponenteHelpers = class abstract
  public
    class function VerificarTodosCamposVazio(const pEdits: TArray<TCustomEdit>): Boolean;
    class function VerificarEditVazio(const pEdits: TArray<TCustomEdit>): TCustomEdit;
    class procedure Focar(const pEdit: TWinControl);
  end;

  TMemoHelper = class Helper for TMemo
  public
    procedure FocarCabecalho;
  end;

  TCustomEditHelper = class Helper for TCustomEdit
  public
    procedure AceitarSomenteNumeros;
    procedure AceitarSomenteLetras;
    procedure Completar(pQuantidade: Integer; pValorAPreencher: Char = ' ');
    procedure Repor(pValorAPreencher: Char = '0'; pValorAntigo: Char = '_');
    function CampoVazio: Boolean;
    procedure FormatarData;
    procedure MoverFinal;
    procedure FormatarIntervalo;
    procedure FormatarHorario;
  end;

implementation

uses
  PontoSemanal.Helpers.Strings;

{ TComponenteHelpers }

class procedure TComponenteHelpers.Focar(const pEdit: TWinControl);
begin
  if pEdit.CanFocus then
  begin
    pEdit.SetFocus;
  end;
end;

class function TComponenteHelpers.VerificarEditVazio(const pEdits: TArray<TCustomEdit>): TCustomEdit;
begin
  Result := nil;

  for var lComponente in pEdits do
  begin
    if not lComponente.CampoVazio then
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
    if lComponente.CampoVazio then
    begin
      Continue;
    end;

    Result := False;
    Break;
  end;
end;

{ TMemoHelper }

procedure TMemoHelper.FocarCabecalho;
begin
  SelStart := 1;
  SelLength := 1;
end;

{ TCustomEditHelper }

procedure TCustomEditHelper.AceitarSomenteLetras;
begin
  Text := TStringHelpers.DigitarSomenteLetras(Text);
end;

procedure TCustomEditHelper.AceitarSomenteNumeros;
begin
  Text := TStringHelpers.DigitarSomenteNumeros(Text);
end;

function TCustomEditHelper.CampoVazio: Boolean;
begin
  Result := TStringHelpers.VerificarCampoVazio(Text);
end;

procedure TCustomEditHelper.Completar(pQuantidade: Integer; pValorAPreencher: Char);
begin
  Text := TStringHelpers.Completar(Text, pQuantidade, pValorAPreencher);
end;

procedure TCustomEditHelper.FormatarData;
begin
  Text := TStringHelpers.FormatarData(Text);
  MoverFinal;
end;

procedure TCustomEditHelper.FormatarHorario;
begin
  Text := TStringHelpers.FormatarHorario(Text);
  MoverFinal;
end;

procedure TCustomEditHelper.FormatarIntervalo;
begin
  if CampoVazio then
  begin
    Exit;
  end;

  Completar(4, '0');
end;

procedure TCustomEditHelper.MoverFinal;
begin
  SelStart := Length(Text);
end;

procedure TCustomEditHelper.Repor(pValorAPreencher: Char = '0'; pValorAntigo: Char = '_');
begin
  Text := StringReplace(Text, pValorAntigo, pValorAPreencher, [rfReplaceAll]);
end;

end.
