unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.Enumerados,
  PontoSemanal.Interfaces.Observer.Sujeito;

type
  TProcInserirHorario = procedure(const pValor: string) of object;

  TfrmHorariosDiaUtil = class(TFrame, ISujeito)
    lbeEntrada: TLabeledEdit;
    edtSaldoHora: TEdit;
    lblDesempenho: TLabel;
    edtTotalHora: TEdit;
    lblTotalHora: TLabel;
    lbeSaidaAlmoco: TLabeledEdit;
    lbeRetornoAlmoco: TLabeledEdit;
    lbeSaidaFinal: TLabeledEdit;
    bvlDivisorTotalHoras: TBevel;
    procedure lbeEntradaChange(Sender: TObject);
    procedure lbeSaidaAlmocoChange(Sender: TObject);
    procedure lbeSaidaFinalChange(Sender: TObject);
    procedure lbeRetornoAlmocoChange(Sender: TObject);
    procedure lbeEntradaExit(Sender: TObject);
    procedure lbeRetornoAlmocoExit(Sender: TObject);
    procedure lbeSaidaAlmocoExit(Sender: TObject);
    procedure lbeSaidaFinalExit(Sender: TObject);
  private
    { Private declarations }
    procedure TratarExcecoes(pE: Exception);
    procedure SairCampo(pProcedure: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
    function RetornarDiaSemana: THorariosDia;
    procedure Notificar;
  public
    FTag: TDiaSemana;
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Helpers.Componentes, PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmHorariosDiaUtil.lbeEntradaChange(Sender: TObject);
begin
  lbeEntrada.FormatarHorario(lbeEntrada);
end;

procedure TfrmHorariosDiaUtil.lbeEntradaExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lbeEntrada.Completar(lbeEntrada, 5, '0');
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirEntrada, lDiaSemana, lbeEntrada);
end;

procedure TfrmHorariosDiaUtil.lbeRetornoAlmocoChange(Sender: TObject);
begin
  lbeRetornoAlmoco.FormatarHorario(lbeRetornoAlmoco);
end;

procedure TfrmHorariosDiaUtil.lbeRetornoAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, lbeRetornoAlmoco);
end;

procedure TfrmHorariosDiaUtil.lbeSaidaAlmocoChange(Sender: TObject);
begin
  lbeSaidaAlmoco.FormatarHorario(lbeSaidaAlmoco);
end;

procedure TfrmHorariosDiaUtil.lbeSaidaAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, lbeSaidaAlmoco);
end;

procedure TfrmHorariosDiaUtil.lbeSaidaFinalChange(Sender: TObject);
begin
  lbeSaidaFinal.FormatarHorario(lbeSaidaFinal);
end;

procedure TfrmHorariosDiaUtil.lbeSaidaFinalExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaFinal, lDiaSemana, lbeSaidaFinal);
end;

procedure TfrmHorariosDiaUtil.Notificar;
var
  lDiaSemana: THorariosDia;
begin

end;

function TfrmHorariosDiaUtil.RetornarDiaSemana: THorariosDia;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  case Self.FTag of
    dsSegunda: Result := lPontoSemanal.Segunda;
    dsTerca: Result := lPontoSemanal.Terca;
    dsQuarta: Result := lPontoSemanal.Quarta;
    dsQuinta: Result := lPontoSemanal.Quinta;
    dsSexta: Result := lPontoSemanal.Sexta;
    else Result := lPontoSemanal.Sabado;
  end;
end;

procedure TfrmHorariosDiaUtil.SairCampo(pProcedure: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
begin
  try
    pProcedure(pEdit.Text);
  except
    on E: Exception do
    begin
      TratarExcecoes(E);
    end;
  end;
end;

procedure TfrmHorariosDiaUtil.TratarExcecoes(pE: Exception);
begin
  Application.MessageBox(pChar(pE.Message), 'ATENÇÃO', MB_ICONINFORMATION + MB_OK);
end;

end.
