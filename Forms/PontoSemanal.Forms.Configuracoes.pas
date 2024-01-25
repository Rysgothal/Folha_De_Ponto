unit PontoSemanal.Forms.Configuracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmConfiguracoes = class(TForm)
    lblCargaSemanalMax: TLabel;
    chkHorarioAlmocoSabado: TCheckBox;
    chkAutoCompletar: TCheckBox;
    edtCargaSemanalMax: TEdit;
    btnDistribuirHorarios: TButton;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCargaSemanalMaxChange(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDistribuirHorariosClick(Sender: TObject);
  private
    procedure CarregarConfiguracoes;
    procedure SalvarConfiguracoes;
    procedure AjustarTelaParaConfigurarHorarios;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal,
  PontoSemanal.Classes.Base.Configuracoes, PontoSemanal.Helpers.Componentes,
  PontoSemanal.Forms.Principal;

{$R *.dfm}

procedure TfrmConfiguracoes.btnConfirmarClick(Sender: TObject);
begin
  SalvarConfiguracoes;
  Close;
end;

procedure TfrmConfiguracoes.btnDistribuirHorariosClick(Sender: TObject);
begin
  AjustarTelaParaConfigurarHorarios;
end;

procedure TfrmConfiguracoes.AjustarTelaParaConfigurarHorarios;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  AlphaBlend := not AlphaBlend;

  case AlphaBlend of
    True: btnDistribuirHorarios.Caption := 'Confirmar';
    else btnDistribuirHorarios.Caption := 'Distribuir Horários';
  end;

  AlphaBlendValue := 200;
  btnConfirmar.Enabled := not AlphaBlend;
  btnCancelar.Enabled := not AlphaBlend;
  edtCargaSemanalMax.Enabled := not AlphaBlend;
  chkHorarioAlmocoSabado.Enabled := not AlphaBlend;
  chkAutoCompletar.Enabled := not AlphaBlend;

  frmPrincipal.frmSegunda.HabilitarAjusteHorario(AlphaBlend);
  frmPrincipal.frmTerca.HabilitarAjusteHorario(AlphaBlend);
  frmPrincipal.frmQuarta.HabilitarAjusteHorario(AlphaBlend);
  frmPrincipal.frmQuinta.HabilitarAjusteHorario(AlphaBlend);
  frmPrincipal.frmSexta.HabilitarAjusteHorario(AlphaBlend);
  frmPrincipal.frmSabado.HabilitarAjusteHorario(AlphaBlend);

  frmPrincipal.frmDadosFuncionario.edtJornadaSemanal.Text := lPontoSemanal.JornadaSemanal;
end;

procedure TfrmConfiguracoes.btnCancelarClick(Sender: TObject);
begin
  CarregarConfiguracoes;
  Close;
end;

procedure TfrmConfiguracoes.CarregarConfiguracoes;
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;

  chkHorarioAlmocoSabado.Checked := lConfiguracoes.PossuiAlmocoSabado;
  chkAutoCompletar.Checked := lConfiguracoes.AutoCompletar;
  edtCargaSemanalMax.Text := lConfiguracoes.MaxJornadaSemanalLei;
end;

procedure TfrmConfiguracoes.SalvarConfiguracoes;
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;

  lConfiguracoes.AutoCompletar := chkAutoCompletar.Checked;
  lConfiguracoes.PossuiAlmocoSabado := chkHorarioAlmocoSabado.Checked;
  lConfiguracoes.MaxJornadaSemanalLei := edtCargaSemanalMax.Text;
end;

procedure TfrmConfiguracoes.edtCargaSemanalMaxChange(Sender: TObject);
begin
  edtCargaSemanalMax.AceitarSomenteNumeros;
end;

procedure TfrmConfiguracoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ActiveControl := nil;
  Action := TCloseAction.caFree;
  frmConfiguracoes := nil;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  CarregarConfiguracoes;
end;

end.
