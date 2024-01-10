unit PontoSemanal.Frames.HorarioDiaUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Interfaces.Observer.Sujeito, PontoSemanal.Frames.SaldoHorasDia, 
  PontoSemanal.Helpers.Componentes, System.RegularExpressions, System.StrUtils;

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
  private
    { Private declarations }
    procedure TratarExcecoes(pE: Exception);
    procedure SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia; pEdit: TCustomEdit);
    function RetornarDiaSemana: THorariosDia;
    procedure Notificar;
  public
    procedure AtivarEventosOnExit;
    function VerificarSePossuiValoresAnotados: Boolean;
    function VerificarTodosValoresAnotados: Boolean;
    procedure Limpar;
    procedure DefinirCorPadraoComponentes;
    procedure PreencherValoresHorarios(pGroup: TGroup; pGroupCollection: TGroupCollection);
    { Public declarations }
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

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

procedure TfrmHorariosDia.SairCampo(pProcInserirHorario: TProcInserirHorario; pDiaSemana: THorariosDia;
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

procedure TfrmHorariosDia.TratarExcecoes(pE: Exception);
begin
  Application.MessageBox(pChar(pE.Message), 'ATENÇÃO', MB_ICONINFORMATION + MB_OK);
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

procedure TfrmHorariosDia.PreencherValoresHorarios(pGroup: TGroup; pGroupCollection: TGroupCollection);
begin
  if TDiaSemana(Self.Tag) = dsSabado then
  begin
    medSaidaAlmoco.Text := pGroupCollection[7].Value;
    medRetornoAlmoco.Text := pGroupCollection[8].Value;
    Exit;
  end;

  medEntrada.Text := pGroupCollection[2].Value;
  medSaidaAlmoco.Text := pGroupCollection[3].Value;
  medRetornoAlmoco.Text := pGroupCollection[4].Value;
  medSaidaFinal.Text := pGroupCollection[5].Value;
end;

end.
