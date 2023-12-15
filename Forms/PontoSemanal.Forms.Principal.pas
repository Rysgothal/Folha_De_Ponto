unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    gbxDadosFuncionario: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblAdmissao: TLabel;
    lblJornadaSemanal: TLabel;
    lblIntervaloAlmoco: TLabel;
    lblAnosMesesSemanasDias: TLabel;
    lblHoras: TLabel;
    lblTempoExtenso: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtAdmissao: TEdit;
    edtJornadaSemanal: TEdit;
    edtIntervaloAlmoco: TEdit;
    sttsbarSistemaInfo: TStatusBar;
    tmrHorario: TTimer;
    procedure tmrHorarioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtAdmissaoChange(Sender: TObject);
    procedure edtAdmissaoExit(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, PontoSemanal.Helpers.Componentes,
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmPrincipal.edtAdmissaoChange(Sender: TObject);
begin
  edtAdmissao.FormatarData(edtAdmissao);
end;

procedure TfrmPrincipal.edtAdmissaoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.DataAdmissao := edtAdmissao.Text;
  edtAdmissao.Text := lFolhaPonto.DataAdmissao;
  lblAnosMesesSemanasDias.Caption := lFolhaPonto.TempoAdmissao;
end;

procedure TfrmPrincipal.edtCodigoChange(Sender: TObject);
begin
  edtCodigo.DigitarSomenteNumeros(edtCodigo);
end;

procedure TfrmPrincipal.edtCodigoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.ID := edtCodigo.Text;
  edtCodigo.Text := lFolhaPonto.ID;
end;

procedure TfrmPrincipal.edtNomeChange(Sender: TObject);
begin
  edtNome.DigitarSomenteLetras(edtNome);
end;

procedure TfrmPrincipal.edtNomeExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.Nome := edtNome.Text;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tmrHorario.Enabled := True;
  sttsbarSistemaInfo.Panels[0].Text := FormatDateTime('ddddddd', Date);
end;

procedure TfrmPrincipal.AtualizarHorarioSistema;
var
  lHorarioAtual: string;
begin
  lHorarioAtual := FormatDateTime('hh:mm:ss', Now);
  sttsbarSistemaInfo.Panels[1].Text := lHorarioAtual;
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
