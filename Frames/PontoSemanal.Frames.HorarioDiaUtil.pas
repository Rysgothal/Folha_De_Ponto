unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Interfaces.Observer.Sujeito, PontoSemanal.Frames.SaldoHorasDia, 
  PontoSemanal.Helpers.Componentes;

type
  TProcInserirHorario = procedure(const pValor: string) of object;

  TfrmHorariosDiaUtil = class(TFrame, ISujeito)
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
  private
    { Private declarations }
    procedure TratarExcecoes(pE: Exception);
    procedure SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
    function RetornarDiaSemana: THorariosDia;
    procedure Notificar;
  public
    procedure AtivarEventosOnExit;
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmHorariosDiaUtil.AtivarEventosOnExit;
begin
  medEntrada.OnExit(medEntrada);
  medSaidaAlmoco.OnExit(medSaidaAlmoco);
  medRetornoAlmoco.OnExit(medRetornoAlmoco);
  medSaidaFinal.OnExit(medSaidaFinal);
end;

procedure TfrmHorariosDiaUtil.medEntradaExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirEntrada, lDiaSemana, medEntrada);
end;

procedure TfrmHorariosDiaUtil.medRetornoAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirRetornoAlmoco, lDiaSemana, medRetornoAlmoco);
end;

procedure TfrmHorariosDiaUtil.medSaidaAlmocoExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaAlmoco, lDiaSemana, medSaidaAlmoco);
end;

procedure TfrmHorariosDiaUtil.medSaidaFinalExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  lDiaSemana := RetornarDiaSemana;
  SairCampo(lDiaSemana.InserirSaidaFinal, lDiaSemana, medSaidaFinal);
end;

procedure TfrmHorariosDiaUtil.Notificar;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lValoresVazios: Boolean;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lValoresVazios := TComponenteHelpers.VerificarCampoVazio(
    [medEntrada, medSaidaAlmoco, medRetornoAlmoco, medSaidaFinal]
  );
  
  for var lObservador in lPontoSemanal.Observers do
  begin
    if (lObservador.Key <> TDiaSemana(Self.Tag)) and (lObservador.Key <> dsNenhum) then
    begin
      Continue;
    end;
    
    lObservador.Value.Atualizar(lValoresVazios);
  end;
end;

function TfrmHorariosDiaUtil.RetornarDiaSemana: THorariosDia;
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

procedure TfrmHorariosDiaUtil.SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia;
  pEdit: TCustomEdit);
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  try
    pProcInserirHorario(pEdit.Text);
    pDiaSemana.CalcularHorasTrabalhadas;
    lPontoSemanal.CalcularDesempenho;
    Notificar;
  except
    on E: Exception do
    begin
      TratarExcecoes(E);
      TComponenteHelpers.Focar(pEdit);
    end;
  end;
end;

procedure TfrmHorariosDiaUtil.TratarExcecoes(pE: Exception);
begin
  Application.MessageBox(pChar(pE.Message), 'ATENÇÃO', MB_ICONINFORMATION + MB_OK);
end;

end.
