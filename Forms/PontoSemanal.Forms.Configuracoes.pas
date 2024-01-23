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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkHorarioAlmocoSabadoClick(Sender: TObject);
    procedure chkAutoCompletarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCargaSemanalMaxChange(Sender: TObject);
    procedure edtCargaSemanalMaxExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal,
  PontoSemanal.Classes.Base.Configuracoes, PontoSemanal.Helpers.Componentes;

{$R *.dfm}

procedure TfrmConfiguracoes.chkAutoCompletarClick(Sender: TObject);
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;
  lConfiguracoes.AutoCompletar := chkAutoCompletar.Checked;
end;

procedure TfrmConfiguracoes.chkHorarioAlmocoSabadoClick(Sender: TObject);
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;
  lConfiguracoes.PossuiAlmocoSabado := chkHorarioAlmocoSabado.Checked;
end;

procedure TfrmConfiguracoes.edtCargaSemanalMaxChange(Sender: TObject);
begin
  edtCargaSemanalMax.AceitarSomenteNumeros;
end;

procedure TfrmConfiguracoes.edtCargaSemanalMaxExit(Sender: TObject);
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;
  lConfiguracoes.MaxJornadaSemanalLei := edtCargaSemanalMax.Text;
end;

procedure TfrmConfiguracoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ActiveControl := nil;
  Action := TCloseAction.caFree;
  frmConfiguracoes := nil;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
var
  lConfiguracoes: TConfiguracao;
begin
  lConfiguracoes := TFolhaPontoSemanalSingleton.ObterInstancia.Configuracao;

  chkHorarioAlmocoSabado.Checked := lConfiguracoes.PossuiAlmocoSabado;
  chkAutoCompletar.Checked := lConfiguracoes.AutoCompletar;
  edtCargaSemanalMax.Text := lConfiguracoes.MaxJornadaSemanalLei;
end;

end.
