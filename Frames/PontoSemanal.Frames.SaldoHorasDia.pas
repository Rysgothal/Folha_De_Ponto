unit PontoSemanal.Frames.SaldoHorasDia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Classes.Base.Desempenho;

type
  TfrmSaldoHorasDia = class(TFrame, IObservador)
    edtTotalHora: TEdit;
    edtSaldoHora: TEdit;
    lblDesempenho: TLabel;
    lblTotalHora: TLabel;
  private
    { Private declarations }
    function RetornarDesempenhoDiaSemana: TDesempenho;
    procedure ConfigurarSaldoHorasPositivas;
    procedure ConfigurarSaldoHorasNeutra;
    procedure ConfigurarSaldoHorasNegativa;
    procedure ConfigurarComponentes(pCor: TColor; pLetraDesempenho, pLetraRosto: Char);
    procedure ConfigurarSaldoDeHoras(lDesempenho: TDesempenho);
  public
    { Public declarations }
    procedure Atualizar(const pValoresVazios: Boolean);
    procedure Limpar;
    procedure DefinirCorPadraoComponentes;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

{ TfrmSaldoHorasDia }

procedure TfrmSaldoHorasDia.Atualizar(const pValoresVazios: Boolean);
var
  lDesempenho: TDesempenho;
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lDiaSemana: TDiaSemana;
begin
  lDiaSemana := TDiaSemana(Tag);
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  if ((lPontoSemanal.JornadaSemanal.ToInteger = 0) and (TDiaSemana(Tag) = dsNenhum)) or
    (pValoresVazios and (lDiaSemana <> dsNenhum)) then
  begin
    Limpar;
    Exit;
  end;

  lDesempenho := RetornarDesempenhoDiaSemana;
  edtTotalHora.Text := lDesempenho.TotalTrabalhado;
  edtSaldoHora.Text := lDesempenho.SaldoHoras;

  ConfigurarSaldoDeHoras(lDesempenho);
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasNegativa;
begin
  ConfigurarComponentes($303497, 'ê','L');
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasNeutra;
begin
  ConfigurarComponentes(clGreen, 'ü','K');
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasPositivas;
begin
  ConfigurarComponentes($ff0000, 'é','J');
end;

procedure TfrmSaldoHorasDia.DefinirCorPadraoComponentes;
begin
  edtTotalHora.Color := clInfoBk;
  edtSaldoHora.Color := clInfoBk;
end;

procedure TfrmSaldoHorasDia.Limpar;
begin
  ConfigurarComponentes(clWindowText, #0, #0);
  edtTotalHora.Text := ':';
  edtSaldoHora.Clear;
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoDeHoras(lDesempenho: TDesempenho);
begin
  case lDesempenho.CumprimentoHorario of
    chAcima: ConfigurarSaldoHorasPositivas;
    chRegular: ConfigurarSaldoHorasNeutra;
    chAbaixo: ConfigurarSaldoHorasNegativa;
  end;
end;

procedure TfrmSaldoHorasDia.ConfigurarComponentes(pCor: TColor; pLetraDesempenho: Char; pLetraRosto: Char);
begin
  lblDesempenho.Caption := pLetraDesempenho;
  lblDesempenho.Font.Color := pCor;
  edtSaldoHora.Font.Color := pCor;
  edtTotalHora.Font.Color := pCor;

  if lblTotalHora.Font.Name = 'Wingdings' then
  begin
    lblTotalHora.Caption := pLetraRosto;
    lblTotalHora.Font.Color := pCor;
  end;
end;

function TfrmSaldoHorasDia.RetornarDesempenhoDiaSemana: TDesempenho;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  case TDiaSemana(Self.Tag) of
    dsSegunda: Result := lPontoSemanal.Segunda.Desempenho;
    dsTerca: Result := lPontoSemanal.Terca.Desempenho;
    dsQuarta: Result := lPontoSemanal.Quarta.Desempenho;
    dsQuinta: Result := lPontoSemanal.Quinta.Desempenho;
    dsSexta: Result := lPontoSemanal.Sexta.Desempenho;
    dsSabado: Result := lPontoSemanal.Sabado.Desempenho;
    else Result := lPontoSemanal.Desempenho;
  end;
end;

end.
