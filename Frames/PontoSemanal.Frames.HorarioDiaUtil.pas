unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Interfaces.Observer.Sujeito, PontoSemanal.Frames.SaldoHorasDia;

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
    procedure SairCampo(pProcedure: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
    function RetornarDiaSemana: THorariosDia;
    procedure Notificar;
  public
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Helpers.Componentes, PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmHorariosDiaUtil.medEntradaExit(Sender: TObject);
var
  lDiaSemana: THorariosDia;
begin
  medEntrada.Completar(medEntrada, 5, '0');
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
  lDia: THorariosDia;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lDia := RetornarDiaSemana;

  for var lObservador in lPontoSemanal.Observers do
  begin
    if (TDiaSemana(Self.Tag) <> lDia.Tag) or (Self.Tag <> 0) then
    begin
      Continue;
    end;

    lObservador.Atualizar;
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

procedure TfrmHorariosDiaUtil.SairCampo(pProcedure: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  try
    pProcedure(pEdit.Text);
    pDiaSemana.CalcularHorasTrabalhadas;
    lPontoSemanal.CalcularDesempenho;
    Notificar;
  except
    on E: Exception do
    begin
      TratarExcecoes(E);
    end;
  end;
end;

procedure TfrmHorariosDiaUtil.TratarExcecoes(pE: Exception);
begin
  Application.MessageBox(pChar(pE.Message), 'ATEN��O', MB_ICONINFORMATION + MB_OK);
end;

end.