unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Interfaces.Observer.Sujeito, PontoSemanal.Frames.SaldoHorasDia, 
  PontoSemanal.Helpers.Componentes, System.RegularExpressions, System.StrUtils,
  System.Generics.Collections, PontoSemanal.Helpers.Strings, Vcl.Buttons;

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
    function VerificarDadoAlterado(pValorNovo, pValorAntes: string): Boolean;
  public
    FDadoAlterado: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; overload;
    procedure AtivarEventosOnExit;
    function VerificarSePossuiValoresAnotados: Boolean;
    function VerificarTodosValoresAnotados: Boolean;
    procedure Limpar;
    procedure DefinirCorPadraoComponentes;
    procedure PreencherValoresHorarios(pGroupCollection: TGroupCollection);
    procedure AlterarEditHorarioViolado(pHorario: TRegistroHorario);
    function ProcurarHorarioIncorreto: Boolean;
    function RetornarEditsNaoVerificados: TArray<TMaskEdit>;
    procedure HabilitarAjusteHorario(pHabilitar: Boolean);
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

  lEdit.Color := $006969D6;
end;

procedure TfrmHorariosDia.AtivarEventosOnExit;
begin
  medEntrada.OnExit(medEntrada);
  medSaidaAlmoco.OnExit(medSaidaAlmoco);
  medRetornoAlmoco.OnExit(medRetornoAlmoco);
  medSaidaFinal.OnExit(medSaidaFinal);
end;

constructor TfrmHorariosDia.Create(AOwner: TComponent);
begin
  Create(AOwner);
  FDadoAlterado := False;
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

procedure TfrmHorariosDia.HabilitarAjusteHorario(pHabilitar: Boolean);
var
  lDiaSemana: THorariosDia;
begin
  Limpar;
  lDiaSemana := RetornarDiaSemana;
  frmSaldoHorasDia.HabilitarAjusteHorario(pHabilitar);

  if not pHabilitar then
  begin
    medEntrada.Text := lDiaSemana.Entrada;
    medSaidaAlmoco.Text := lDiaSemana.SaidaAlmoco;
    medRetornoAlmoco.Text := lDiaSemana.RetornoAlmoco;
    medSaidaFinal.Text := lDiaSemana.SaidaFinal;
    AtivarEventosOnExit;
  end;
end;

procedure TfrmHorariosDia.FrameExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;

//  if TComponenteHelpers.VerificarTodosCamposVazio([medSaidaAlmoco, medRetornoAlmoco]) and
//    not TComponenteHelpers.VerificarTodosCamposVazio([medEntrada, medSaidaFinal]) then
//  begin
//    medSaidaAlmoco.Text := '00:00';
//    medRetornoAlmoco.text := '00:00';
//    SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, medSaidaAlmoco);
//    SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, medRetornoAlmoco);
//  end;
//
  if (lDiaSemana.Tag = dsSabado) and (lDiaSemana.Jornada = 0) and
    TComponenteHelpers.VerificarTodosCamposVazio([medEntrada, medSaidaFinal]) then
  begin
    medEntrada.Text := '00:00';
    medSaidaFinal.text := '00:00';
    SairCampo(lDiaSemana.InserirEntrada, lDiaSemana, medEntrada);
    SairCampo(lDiaSemana.InserirSaidaFinal, lDiaSemana, medSaidaFinal);
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

  FDadoAlterado := VerificarDadoAlterado(medEntrada.Text, lDiaSemana.Entrada);
  SairCampo(lDiaSemana.InserirEntrada, lDiaSemana, medEntrada);
end;

procedure TfrmHorariosDia.medRetornoAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  FDadoAlterado := VerificarDadoAlterado(medRetornoAlmoco.Text, lDiaSemana.RetornoAlmoco);
  SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, medRetornoAlmoco);
end;

procedure TfrmHorariosDia.medSaidaAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  FDadoAlterado := VerificarDadoAlterado(medSaidaAlmoco.Text, lDiaSemana.SaidaAlmoco);
  SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, medSaidaAlmoco);
end;

procedure TfrmHorariosDia.medSaidaFinalExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  FDadoAlterado := VerificarDadoAlterado(medSaidaFinal.Text, lDiaSemana.SaidaFinal);
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
    if lPontoSemanal.Configuracao.AutoCompletar then
    begin
      lEdit.Repor;
    end;

    pProcInserirHorario(lEdit.Text);

//    for var lComponente in RetornarEditsNaoVerificados do
//    begin
//      if lComponente = lEdit then
//      begin
    lEdit.Color := clWindow;
//      end;
//    end;

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
      pProcInserirHorario(EmptyStr);
      frmSaldoHorasDia.Limpar;
    end;
  end;
end;

function TfrmHorariosDia.VerificarDadoAlterado(pValorNovo, pValorAntes: string): Boolean;
begin
  Result := True;

  if FDadoAlterado then
  begin
    Exit;
  end;

  Result := TStringHelpers.VerificarDiferenca(pValorNovo, pValorAntes);
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
  medEntrada.Text := pGroupCollection[1].Value;

  if TDiaSemana(Self.Tag) = dsSabado then
  begin
    medSaidaFinal.Text := pGroupCollection[2].Value;
    Exit;
  end;

  medSaidaAlmoco.Text := pGroupCollection[2].Value;
  medRetornoAlmoco.Text := pGroupCollection[3].Value;
  medSaidaFinal.Text := pGroupCollection[4].Value;
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
