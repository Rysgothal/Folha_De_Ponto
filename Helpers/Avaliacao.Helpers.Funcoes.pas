unit Avaliacao.Helpers.Funcoes;

interface

uses
  System.SysUtils, Vcl.StdCtrls, System.Math, System.StrUtils;

type
  TPositions = array of Integer;
  TChars = array of Char;

  TFuncoes = class abstract
    class procedure MoverInicio(const pEdit: TCustomEdit);
    class procedure MoverFinal(const pEdit: TCustomEdit);
    class function SomenteNumeros(const pValor: string): string;
    class function SomenteLetrasComEspaco(const pValor: string): string;
    class function FormatarMoeda(const pValor: string): string; overload;
    class procedure FormatarMoeda(const pEdit: TCustomEdit); overload;
    class function CalcularJurosCompostos(const pValorOriginal: Currency;
      const pTaxa: Single; const pTempo: Integer): Currency;
    class function CalcularJurosSimples(const pValorOriginal: Currency;
      const pTaxa: Single; const pTempo: Integer): Currency;
    class function FormatarCep(const pValor: string): string; overload;
    class procedure FormatarCep(const pEdit: TCustomEdit); overload;
    class function FormatarCpf(const pValor: string): string; overload;
    class procedure FormatarCpf(const pEdit: TCustomEdit); overload;
    class function FormatarCnpj(const pValor: string): string; overload;
    class procedure FormatarCnpj(const pEdit: TCustomEdit); overload;
    class function FormatarData(const pValor: string): string; overload;
    class function FormatarHorario(const pValor: string): string;
    class function FormatarCpfCnpj(const pValue: string): string; overload;
    class procedure FormatarCpfCnpj(const pEdit: TCustomEdit); overload;
    class procedure FormatarData(const pEdit: TCustomEdit); overload;
    class procedure InsertChar(var pValor: string; const pPos: Integer; const pChar: Char); overload;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChars: TChars); overload;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChar: Char); overload;
  end;

implementation

{ TFuncoes }

class function TFuncoes.CalcularJurosCompostos(const pValorOriginal: Currency;
  const pTaxa: Single; const pTempo: Integer): Currency;
begin
  Result := pValorOriginal * Power(1 + pTaxa / 100, pTempo);
end;

class function TFuncoes.CalcularJurosSimples(const pValorOriginal: Currency;
  const pTaxa: Single; const pTempo: Integer): Currency;
begin
  Result := pValorOriginal + (pValorOriginal * pTaxa * pTempo / 100);
end;

class function TFuncoes.FormatarCep(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).Substring(0, 8);
  InsertChar(Result, 5, '-');
end;

class procedure TFuncoes.FormatarCep(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarCep(pEdit.Text);
  MoverFinal(pEdit);
end;

class procedure TFuncoes.FormatarCpf(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarCpf(pEdit.Text);
  MoverFinal(pEdit);
end;

class function TFuncoes.FormatarCpfCnpj(const pValue: string): string;
begin
  case Length(pValue) > 14 of
    True: Result := TFuncoes.FormatarCnpj(pValue);
    else Result := TFuncoes.FormatarCpf(pValue);
  end;
end;

class procedure TFuncoes.FormatarCpfCnpj(const pEdit: TCustomEdit);
begin
  case Length(pEdit.Text) > 14 of
    True: TFuncoes.FormatarCnpj(pEdit);
    else TFuncoes.FormatarCpf(pEdit);
  end;
end;

class procedure TFuncoes.FormatarData(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarData(pEdit.Text).Substring(0, 10);
  MoverFinal(pEdit);
end;

class function TFuncoes.FormatarHorario(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).Substring(0, 14);
  InsertChars(Result, [1], ':')
end;

class procedure TFuncoes.FormatarMoeda(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarMoeda(pEdit.Text);
  MoverFinal(pEdit);
end;

class function TFuncoes.FormatarData(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).Substring(0, 14);
  InsertChars(Result, [4, 2], '/')
end;

class function TFuncoes.FormatarCpf(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).Substring(0, 11);
  InsertChars(Result, [9, 6, 3], ['-', '.', '.'])
end;

class procedure TFuncoes.FormatarCnpj(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarCnpj(pEdit.Text);
  MoverFinal(pEdit);
end;

class function TFuncoes.FormatarCnpj(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).Substring(0, 14);
  InsertChars(Result, [12, 8, 5, 2], ['-', '/', '.', '.'])
end;

class function TFuncoes.FormatarMoeda(const pValor: string): string;
begin
  Result := SomenteNumeros(pValor).PadLeft(3, '0').Substring(0, 16);
  Result.Insert(Result.Length - 2, ',');
  Result := FormatCurr(',0.00', StrToCurrDef(Result, 0));
end;

class procedure TFuncoes.MoverFinal(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := Length(pEdit.Text);
end;

class procedure TFuncoes.MoverInicio(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := 0;
end;

class function TFuncoes.SomenteLetrasComEspaco(const pValor: string): string;
begin
  for var vChar in pValor do
  begin
    if CharInSet(vChar, ['A'..'Z', #32]) then
    begin
      Result := Result + vChar;
    end;
  end;
end;

class function TFuncoes.SomenteNumeros(const pValor: string): string;
begin
  for var vChar in pValor do
  begin
    if CharInSet(vChar, ['0'..'9']) then
    begin
      Result := Result + vChar;
    end;
  end;
end;

class procedure TFuncoes.InsertChar(var pValor: string; const pPos: Integer; const pChar: Char);
begin
  if pValor.Length > pPos then
  begin
    pValor.Insert(pPos, pChar);
  end;
end;

class procedure TFuncoes.InsertChars(var pValor: string;
  const pPos: TPositions; const pChar: Char);
begin
   InsertChars(pValor, pPos, [pChar]);
end;

class procedure TFuncoes.InsertChars(var pValor: string; const pPos: TPositions;
  const pChars: TChars);
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

end.
