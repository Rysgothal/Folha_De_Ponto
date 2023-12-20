unit PontoSemanal.Frames.SaldoHorasDia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Classes.Base.Horarios;

type
  TfrmSaldoHorasDia = class(TFrame, IObservador)
    edtTotalHora: TEdit;
    edtSaldoHora: TEdit;
    lblDesempenho: TLabel;
    lblTotalHora: TLabel;
  private
    { Private declarations }
    function RetornarDiaSemana: THorariosDia;
    procedure ConfigurarSaldoHorasPositivas;
    procedure ConfigurarSaldoHorasNeutra;
    procedure ConfigurarSaldoHorasNegativa;
  public
    { Public declarations }
    procedure Atualizar;
  end;

implementation

uses
  PontoSemanal.Classes.Singleton.Principal,
  PontoSemanal.Helpers.TiposAuxiliares, PontoSemanal.Classes.Base.Desempenho;

{$R *.dfm}

{ TfrmSaldoHorasDia }

procedure TfrmSaldoHorasDia.Atualizar;
var
  lDesempenho: TDesempenho;
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  case TDiaSemana(Self.Tag) = dsNenhum of
    True: lDesempenho := lPontoSemanal.Desempenho;
    else lDesempenho := RetornarDiaSemana.Desempenho;
  end;

  edtTotalHora.Text := lDesempenho.TotalTrabalhado;
  edtSaldoHora.Text := lDesempenho.SaldoHoras;

  case lDesempenho.CumprimentoHorario of
    chAcima: ConfigurarSaldoHorasPositivas;
    chRegular: ConfigurarSaldoHorasNeutra;
    chAbaixo: ConfigurarSaldoHorasNegativa;
  end;
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasNegativa;
begin
  lblDesempenho.Caption := 'ê';
  lblDesempenho.Font.Color := $303497;
  edtSaldoHora.Font.Color := $303497;
  edtTotalHora.Font.Color := $303497;
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasNeutra;
begin
  lblDesempenho.Caption := 'ü';
  lblDesempenho.Font.Color := clGreen;
  edtSaldoHora.Font.Color := clGreen;
  edtTotalHora.Font.Color := clGreen;
end;

procedure TfrmSaldoHorasDia.ConfigurarSaldoHorasPositivas;
begin
  lblDesempenho.Caption := 'é';
  lblDesempenho.Font.Color := $ff0000;
  edtSaldoHora.Font.Color := $ff0000;
  edtTotalHora.Font.Color := $ff0000;
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
    dsSabado: Result := lPontoSemanal.Sabado;
    else Result := nil;
  end;
end;

end.
