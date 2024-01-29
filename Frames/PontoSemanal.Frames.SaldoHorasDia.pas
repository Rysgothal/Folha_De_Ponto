unit PontoSemanal.Frames.SaldoHorasDia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Classes.Base.Desempenho, Vcl.Buttons;

type
  TfrmSaldoHorasDia = class(TFrame, IObservador)
    edtTotalHora: TEdit;
    edtSaldoHora: TEdit;
    lblDesempenho: TLabel;
    lblTotalHora: TLabel;
    btnMais: TSpeedButton;
    btnMenos: TSpeedButton;
    procedure btnMaisClick(Sender: TObject);
    procedure btnMenosClick(Sender: TObject);
  private
    { Private declarations }
    function RetornarDesempenhoDiaSemana: TDesempenho;
    procedure ConfigurarSaldoHorasPositivas;
    procedure ConfigurarSaldoHorasNeutra;
    procedure ConfigurarSaldoHorasNegativa;
    procedure ConfigurarComponentes(pCor: TColor; pLetraDesempenho, pLetraRosto: Char);
    procedure ConfigurarSaldoDeHoras(lDesempenho: TDesempenho);
    function RetornarDiaSemana: THorariosDia;
    procedure AdicionarHoraDiaria;
    procedure ReduzirHoraDiaria;
    procedure AjustarHoraDiaria(pValor: Integer);
  public
    { Public declarations }
    procedure Atualizar(const pValoresVazios: Boolean);
    procedure Limpar;
    procedure DefinirCorPadraoComponentes;
    procedure HabilitarAjusteHorario(pHabilitar: Boolean);
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal, PontoSemanal.Forms.Principal;

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

procedure TfrmSaldoHorasDia.HabilitarAjusteHorario(pHabilitar: Boolean);
begin
  btnMais.Visible := pHabilitar;
  btnMenos.Visible := pHabilitar;

  case pHabilitar of
    True: edtSaldoHora.Text := RetornarDiaSemana.Jornada.ToString.PadLeft(2, '0') + ':00';
    else edtSaldoHora.Text := RetornarDiaSemana.Desempenho.SaldoHoras;
  end;
end;

procedure TfrmSaldoHorasDia.ReduzirHoraDiaria;
begin
  AjustarHoraDiaria(Pred(RetornarDiaSemana.Jornada))
end;

procedure TfrmSaldoHorasDia.AdicionarHoraDiaria;
begin
  AjustarHoraDiaria(Succ(RetornarDiaSemana.Jornada))
end;


procedure TfrmSaldoHorasDia.AjustarHoraDiaria(pValor: Integer);
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lHorariosDia: THorariosDia;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lHorariosDia := RetornarDiaSemana;

  try
    if (pValor < 0) then
    begin
      Exit;
    end;

    lPontoSemanal.DistribuirHorarios(lHorariosDia.Tag, pValor);
    edtSaldoHora.Text := lHorariosDia.Jornada.ToString.PadLeft(2, '0') + ':00';
    frmPrincipal.frmDadosFuncionario.edtJornadaSemanal.Text := lPontoSemanal.JornadaSemanal;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message + sLineBreak + 'Distribua o horário corretamente'), 'Atenção', MB_OK +
        MB_ICONINFORMATION);
    end;
  end;
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

procedure TfrmSaldoHorasDia.btnMaisClick(Sender: TObject);
begin
  AdicionarHoraDiaria;
end;

procedure TfrmSaldoHorasDia.btnMenosClick(Sender: TObject);
begin
  ReduzirHoraDiaria;
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

function TfrmSaldoHorasDia.RetornarDiaSemana: THorariosDia;
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

end.
