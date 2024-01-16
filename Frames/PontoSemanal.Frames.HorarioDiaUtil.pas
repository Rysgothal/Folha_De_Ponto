unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Interfaces.Observer.Sujeito, PontoSemanal.Frames.SaldoHorasDia, 
  PontoSemanal.Helpers.Componentes, System.RegularExpressions, System.StrUtils,
  System.Generics.Collections;

type
  TProcInserirHorario = procedure(const pValor: string) of object;

  TfrmHorariosDia = class(TFrame, ISujeito)
    bvlDivisorTotalHoras: TBevel;
    medEntrada: TMaskEdit;
    medSaidaAlmoco: TMaskEdit;
    medRetornoAlmoco: TMaskEdit;
    medSaidaFinal: TMaskEdit;
    lblSaidaFinal: TLabel;
    lblRetornoAlmoco: TLabel;
    lblSaidaAlmoco: TLabel;
    lblEntrada: TLabel;
    frmSaldoHorasDia: TfrmSaldoHorasDia;
    procedure medEntradaExit(Sender: TObject);
    procedure medRetornoAlmocoExit(Sender: TObject);
    procedure medSaidaAlmocoExit(Sender: TObject);
    procedure medSaidaFinalExit(Sender: TObject);
    procedure FrameExit(Sender: TObject);
  private
    { Private declarations }
    function MostrarMensagemDlg(const pMensagem: string; pMsgDlgType: TmsgDlgType; pBotoes: TMsgDlgButtons;
      pCaptionBotoes: array of string): Integer;
    procedure SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
    function RetornarDiaSemana: THorariosDia;
    procedure Notificar;
  public
    procedure AtivarEventosOnExit;
    function VerificarSePossuiValoresAnotados: Boolean;
    function VerificarTodosValoresAnotados: Boolean;
    procedure Limpar;
    procedure DefinirCorPadraoComponentes;
    procedure PreencherValoresHorarios(pGroupCollection: TGroupCollection);
    procedure AlterarEditHorarioViolado(pHorario: TRegistroHorario);
    function ProcurarHorarioIncorreto: Boolean;
    function RetornarEditsNaoVerificados: TArray<TMaskEdit>;
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmHorariosDia.AlterarEditHorarioViolado(pHorario: TRegistroHorario);
var
  lEdit: TMaskEdit;
begin
  case pHorario of
    rhEntrada: lEdit := medEntrada;
    rhSaidaAlmoco: lEdit := medSaidaAlmoco;
    rhRetornoAlmoco: lEdit := medRetornoAlmoco;
    rhSaidaFinal: lEdit := medSaidaFinal;
    else Exit;
  end;

  lEdit.Color := clSkyBlue;
end;

procedure TfrmHorariosDia.AtivarEventosOnExit;
begin
  medEntrada.OnExit(medEntrada);
  medSaidaAlmoco.OnExit(medSaidaAlmoco);
  medRetornoAlmoco.OnExit(medRetornoAlmoco);
  medSaidaFinal.OnExit(medSaidaFinal);
end;

procedure TfrmHorariosDia.DefinirCorPadraoComponentes;
begin
  for var I := 0 to Pred(ComponentCount) do
  begin
    if Components[I] is TMaskEdit then
    begin
      TMaskEdit(Components[I]).Color := clWhite;
      TMaskEdit(Components[I]).Font.Color := clWindowText;
      Continue;
    end;

    if Components[I] is TfrmSaldoHorasDia then
    begin
      TfrmSaldoHorasDia(Components[I]).DefinirCorPadraoComponentes;
    end;
  end;
end;

procedure TfrmHorariosDia.FrameExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  if TComponenteHelpers.VerificarTodosCamposVazio([medSaidaAlmoco, medRetornoAlmoco]) and
    not TComponenteHelpers.VerificarTodosCamposVazio([medEntrada, medSaidaFinal]) then
  begin
    lDiaSemana := RetornarDiaSemana;
    medSaidaAlmoco.Text := '00:00';
    medRetornoAlmoco.text := '00:00';
    SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, medSaidaAlmoco);
    SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, medRetornoAlmoco);
  end;
end;

procedure TfrmHorariosDia.Limpar;
begin
  medEntrada.Clear;
  medSaidaAlmoco.Clear;
  medRetornoAlmoco.Clear;
  medSaidaFinal.Clear;
  frmSaldoHorasDia.Limpar;
end;

procedure TfrmHorariosDia.medEntradaExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirEntrada, lDiaSemana, medEntrada);
end;

procedure TfrmHorariosDia.medRetornoAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, medRetornoAlmoco);
end;

procedure TfrmHorariosDia.medSaidaAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, medSaidaAlmoco);
end;

procedure TfrmHorariosDia.medSaidaFinalExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaFinal, lDiaSemana, medSaidaFinal);
end;

function TfrmHorariosDia.MostrarMensagemDlg(const pMensagem: string; pMsgDlgType: TmsgDlgType; pBotoes: TMsgDlgButtons;
  pCaptionBotoes: array of string): Integer;
var
  lMsgDialog: TForm;
  lDlgBotao: Tbutton;
  lCaptionIndex: Integer;
begin
  Screen.MessageFont.Size := 10;
  lMsgDialog := CreateMessageDialog(pMensagem, pMsgDlgType, pBotoes);
  lMsgDialog.Caption := 'Atenção!';
  lCaptionIndex := 0;

  for var I := 0 to lMsgDialog.ComponentCount - 1 Do
  begin
    if not (lMsgDialog.Components[I] is TButton) then
    begin
      Continue;
    end;

    lDlgBotao := TButton(lMsgDialog.Components[I]);
    lDlgBotao.Font.Height := -12;

    if lCaptionIndex <= High(pCaptionBotoes) then
    begin
      lDlgBotao.Caption := pCaptionBotoes[lCaptionIndex];
    end;

    Inc(lCaptionIndex);
  end;

  Result := lMsgDialog.Showmodal;
end;

procedure TfrmHorariosDia.Notificar;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lValoresVazios: Boolean;
  lEdits: TArray<TCustomEdit>;
begin
  lEdits := [medEntrada, medSaidaAlmoco, medRetornoAlmoco, medSaidaFinal];
  lValoresVazios := TComponenteHelpers.VerificarTodosCamposVazio(lEdits);

  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  for var lObservador in lPontoSemanal.Observers do
  begin
    if (lObservador.Key <> TDiaSemana(Self.Tag)) and (lObservador.Key <> dsNenhum) then
    begin
      Continue;
    end;
    
    lObservador.Value.Atualizar(lValoresVazios);
  end;
end;

function TfrmHorariosDia.RetornarDiaSemana: THorariosDia;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  case TDiaSemana(Self.Tag) of
    dsSegunda: Result := lPontoSemanal.Segunda;
    dsTerca: Result := lPontoSemanal.Terca;
    dsQuarta: Result := lPontoSemanal.Quarta;
    dsQuinta: Result := lPontoSemanal.Quinta;
    dsSexta: Result := lPontoSemanal.Sexta;
    else Result := lPontoSemanal.Sabado;
  end;
end;

function TfrmHorariosDia.RetornarEditsNaoVerificados: TArray<TMaskEdit>;
begin
  Result := [];

  for var lComponente in Self do
  begin
    if not (lComponente is TMaskEdit) then
    begin
      Continue;
    end;

    if (TMaskEdit(lComponente).Color = clGray) then
    begin
      Result := Result + [TMaskEdit(lComponente)];
    end;
  end;
end;

procedure TfrmHorariosDia.SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia;
  pEdit: TCustomEdit);
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lMensagemDlg: Integer;
  lEdit: TMaskEdit absolute pEdit;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  try
    pProcInserirHorario(lEdit.Text);

    for var lComponente in RetornarEditsNaoVerificados do
    begin
      if lComponente = lEdit then
      begin
        lComponente.Color := clWindow;
      end;
    end;

    if RetornarEditsNaoVerificados = nil then
    begin
      pDiaSemana.CalcularHorasTrabalhadas;
      lPontoSemanal.CalcularDesempenho;
      Notificar;
    end;
  except
    on E: Exception do
    begin
      lMensagemDlg := MostrarMensagemDlg(E.Message, TMsgDlgType.mtInformation, [mbYes, mbNo],
        ['Verificar agora', 'Verificar depois']);

      if lMensagemDlg = IDYES then
      begin
        TComponenteHelpers.Focar(lEdit);
        lEdit.Color := clWindow;
        Abort;
      end;

      lEdit.Color := clGray;
      frmSaldoHorasDia.Limpar;
    end;
  end;
end;

function TfrmHorariosDia.VerificarSePossuiValoresAnotados: Boolean;
var
  lEdits: TArray<TCustomEdit>;
begin
  lEdits := [medEntrada, medSaidaAlmoco, medRetornoAlmoco, medSaidaFinal];
  Result := not TComponenteHelpers.VerificarTodosCamposVazio(lEdits);
end;

function TfrmHorariosDia.VerificarTodosValoresAnotados: Boolean;
var
  lEdits: TArray<TCustomEdit>;
begin
  case TDiaSemana(Self.Tag) of
    dsSabado: lEdits := [medEntrada, medSaidaFinal];
    else lEdits := [medEntrada, medSaidaAlmoco, medRetornoAlmoco, medSaidaFinal];
  end;

  Result := TComponenteHelpers.VerificarEditVazio(lEdits) = nil;
end;

procedure TfrmHorariosDia.PreencherValoresHorarios(pGroupCollection: TGroupCollection);
begin
  if TDiaSemana(Self.Tag) = dsSabado then
  begin
    medEntrada.Text := pGroupCollection[7].Value;
    medSaidaFinal.Text := pGroupCollection[8].Value;
    Exit;
  end;

  medEntrada.Text := pGroupCollection[2].Value;
  medSaidaAlmoco.Text := pGroupCollection[3].Value;
  medRetornoAlmoco.Text := pGroupCollection[4].Value;
  medSaidaFinal.Text := pGroupCollection[5].Value;
end;

function TfrmHorariosDia.ProcurarHorarioIncorreto: Boolean;
begin
  Result := False;

  for var lComponente in self do
  begin
    if not (lComponente is TMaskEdit) then
    begin
      Continue;
    end;

    if TMaskEdit(lComponente).Color <> clWindow then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.
