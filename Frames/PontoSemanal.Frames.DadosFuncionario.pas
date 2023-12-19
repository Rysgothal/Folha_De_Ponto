unit PontoSemanal.Frames.DadosFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmDadosFuncionario = class(TFrame)
    lblTempoExtenso: TLabel;
    edtIntervaloAlmoco: TEdit;
    lblIntervaloAlmoco: TLabel;
    lblJornadaSemanal: TLabel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblAdmissao: TLabel;
    edtAdmissao: TEdit;
    edtNome: TEdit;
    edtCodigo: TEdit;
    lblAnosMesesSemanasDias: TLabel;
    lblHoras: TLabel;
    edtJornadaSemanal: TEdit;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure edtAdmissaoChange(Sender: TObject);
    procedure edtAdmissaoExit(Sender: TObject);
    procedure edtJornadaSemanalChange(Sender: TObject);
    procedure edtJornadaSemanalExit(Sender: TObject);
    procedure edtIntervaloAlmocoChange(Sender: TObject);
    procedure edtIntervaloAlmocoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, PontoSemanal.Helpers.Componentes,
  PontoSemanal.Helpers.Strings;

{$R *.dfm}

procedure TfrmDadosFuncionario.edtAdmissaoChange(Sender: TObject);
begin
  edtAdmissao.FormatarData(edtAdmissao);
end;

procedure TfrmDadosFuncionario.edtAdmissaoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.DataAdmissao := edtAdmissao.Text;
  edtAdmissao.Text := lFolhaPonto.DataAdmissao;
  lblAnosMesesSemanasDias.Caption := lFolhaPonto.TempoAdmissao;
end;

procedure TfrmDadosFuncionario.edtCodigoChange(Sender: TObject);
begin
  edtCodigo.DigitarSomenteNumeros(edtCodigo);
end;

procedure TfrmDadosFuncionario.edtCodigoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.ID := edtCodigo.Text;
  edtCodigo.Text := lFolhaPonto.ID;
end;

procedure TfrmDadosFuncionario.edtIntervaloAlmocoChange(Sender: TObject);
begin
  edtIntervaloAlmoco.FormatarHorario(edtIntervaloAlmoco);
end;

procedure TfrmDadosFuncionario.edtIntervaloAlmocoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  edtIntervaloAlmoco.FormatarIntervalo(edtIntervaloAlmoco);

  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.IntervaloAlmoco := edtIntervaloAlmoco.Text;
  lblTempoExtenso.Caption := TStringHelpers.IntervaloPorExtenso(lFolhaPonto.IntervaloAlmoco);
end;

procedure TfrmDadosFuncionario.edtJornadaSemanalChange(Sender: TObject);
begin
  edtJornadaSemanal.DigitarSomenteNumeros(edtJornadaSemanal);
end;

procedure TfrmDadosFuncionario.edtJornadaSemanalExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.JornadaSemanal := edtJornadaSemanal.Text;
end;

procedure TfrmDadosFuncionario.edtNomeChange(Sender: TObject);
begin
  edtNome.DigitarSomenteLetras(edtNome);
end;

procedure TfrmDadosFuncionario.edtNomeExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
  lFolhaPonto.Nome := edtNome.Text;
end;

end.
