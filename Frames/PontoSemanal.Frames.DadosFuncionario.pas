unit PontoSemanal.Frames.DadosFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.RegularExpressions;

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
    function VerificarDadoAlterado(pValorNovo, pValorAntes: string): Boolean;
  public
    { Public declarations }
    FDadoAlterado: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; overload;

    procedure Limpar;
    function VerificarSePossuiValoresAnotados: Boolean;
    function VerificarTodosValoresAnotados: Boolean;
    procedure DefinirCorPadraoComponentes;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, PontoSemanal.Helpers.Componentes,
  PontoSemanal.Helpers.Strings, System.Generics.Collections;

{$R *.dfm}

constructor TfrmDadosFuncionario.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDadoAlterado := False;
end;

procedure TfrmDadosFuncionario.DefinirCorPadraoComponentes;
begin
  for var I := 0 to Pred(ComponentCount) do
  begin
    if Components[I] is TEdit then
    begin
      TEdit(Components[I]).Color := clWhite;
      TEdit(Components[I]).Font.Color := clWindowText;
    end;
  end;
end;

procedure TfrmDadosFuncionario.edtAdmissaoChange(Sender: TObject);
begin
  edtAdmissao.FormatarData;
end;

procedure TfrmDadosFuncionario.edtAdmissaoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  try
    lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
    FDadoAlterado := VerificarDadoAlterado(edtAdmissao.Text, lFolhaPonto.DataAdmissao);

    lFolhaPonto.DataAdmissao := edtAdmissao.Text;
    lFolhaPonto.CalcularTempoAdmissao;
    lblAnosMesesSemanasDias.Caption := lFolhaPonto.TempoAdmissao;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção', MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(edtAdmissao);
    end;
  end;
end;

procedure TfrmDadosFuncionario.edtCodigoChange(Sender: TObject);
begin
  edtCodigo.AceitarSomenteNumeros;
end;

procedure TfrmDadosFuncionario.edtCodigoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
   try
    lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
    FDadoAlterado := VerificarDadoAlterado(edtCodigo.Text, lFolhaPonto.ID);
    lFolhaPonto.ID := edtCodigo.Text;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção', MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(edtCodigo);
    end;
  end;
end;

procedure TfrmDadosFuncionario.edtIntervaloAlmocoChange(Sender: TObject);
begin
  edtIntervaloAlmoco.FormatarHorario;
end;

procedure TfrmDadosFuncionario.edtIntervaloAlmocoExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  try
    lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
    edtIntervaloAlmoco.FormatarIntervalo;

    FDadoAlterado := VerificarDadoAlterado(edtIntervaloAlmoco.Text, lFolhaPonto.IntervaloAlmoco);
    lFolhaPonto.IntervaloAlmoco := edtIntervaloAlmoco.Text;
    lblTempoExtenso.Caption := lFolhaPonto.IntervaloAlmocoExtenso;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção', MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(edtIntervaloAlmoco);
    end;
  end;
end;

procedure TfrmDadosFuncionario.edtJornadaSemanalChange(Sender: TObject);
begin
  edtJornadaSemanal.AceitarSomenteNumeros;
end;

procedure TfrmDadosFuncionario.edtJornadaSemanalExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  try
    lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;

    FDadoAlterado := VerificarDadoAlterado(edtJornadaSemanal.Text, lFolhaPonto.JornadaSemanal);
    lFolhaPonto.JornadaSemanal := edtJornadaSemanal.Text;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção', MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(edtJornadaSemanal);
    end;
  end;
end;

procedure TfrmDadosFuncionario.edtNomeChange(Sender: TObject);
begin
  edtNome.AceitarSomenteLetras;
end;

procedure TfrmDadosFuncionario.edtNomeExit(Sender: TObject);
var
  lFolhaPonto: TFolhaPontoSemanalSingleton;
begin
  try
    lFolhaPonto := TFolhaPontoSemanalSingleton.ObterInstancia;
    FDadoAlterado := VerificarDadoAlterado(edtNome.Text, lFolhaPonto.Nome);
    lFolhaPonto.Nome := edtNome.Text;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção', MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(edtNome);
    end;
  end;
end;

procedure TfrmDadosFuncionario.Limpar;
begin
  edtIntervaloAlmoco.Clear;
  edtAdmissao.Clear;
  edtNome.Clear;
  edtCodigo.Clear;
  edtJornadaSemanal.Clear;
  lblAnosMesesSemanasDias.Caption := '-> anos; meses; semanas; dias.';
  lblTempoExtenso.Caption := '"x" horas e "y" minutos';
end;

function TfrmDadosFuncionario.VerificarDadoAlterado(pValorNovo, pValorAntes: string): Boolean;
begin
  Result := True;

  if FDadoAlterado then
  begin
    Exit;
  end;

  Result := TStringHelpers.VerificarDiferenca(pValorNovo, pValorAntes);
end;

function TfrmDadosFuncionario.VerificarSePossuiValoresAnotados: Boolean;
var
  lEdits: TArray<TCustomEdit>;
begin
  lEdits := [edtCodigo, edtNome, edtAdmissao, edtJornadaSemanal, edtIntervaloALmoco];
  Result := not TComponenteHelpers.VerificarTodosCamposVazio(lEdits);
end;

function TfrmDadosFuncionario.VerificarTodosValoresAnotados: Boolean;
var
  lEdits: TArray<TCustomEdit>;
begin
  lEdits := [edtCodigo, edtNome, edtAdmissao, edtJornadaSemanal, edtIntervaloALmoco];
  Result := TComponenteHelpers.VerificarEditVazio(lEdits) = nil;
end;

end.
