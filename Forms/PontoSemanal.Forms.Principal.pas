unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario,
  Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil, PontoSemanal.Frames.SaldoHorasDia;

type
  TfrmPrincipal = class(TForm)
    gbxDadosFuncionario: TGroupBox;
    sttsbarSistemaInfo: TStatusBar;
    tmrHorario: TTimer;
    gbxSeg: TGroupBox;
    frmSegunda: TfrmHorariosDiaUtil;
    frmDadosFuncionario: TfrmDadosFuncionario;
    gbxHorasTrabalhadas: TGroupBox;
    frmHorasTrabalhadasSemana: TfrmSaldoHorasDia;
    procedure tmrHorarioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
    procedure ConfigurarObservadores;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, PontoSemanal.Helpers.TiposAuxiliares,
  PontoSemanal.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tmrHorario.Enabled := True;
  sttsbarSistemaInfo.Panels[0].Text := FormatDateTime('ddddddd', Date);
  ConfigurarObservadores;
end;

procedure TfrmPrincipal.AtualizarHorarioSistema;
var
  lHorarioAtual: string;
begin
  lHorarioAtual := FormatDateTime('hh:mm:ss', Now);
  sttsbarSistemaInfo.Panels[1].Text := lHorarioAtual;
end;

procedure TfrmPrincipal.ConfigurarObservadores;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  frmSegunda.Tag := Ord(dsSegunda);
  frmSegunda.frmSaldoHorasDia.Tag := Ord(dsSegunda);
  frmHorasTrabalhadasSemana.Tag := Ord(dsNenhum);

  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lPontoSemanal.AdicionarObservador(frmSegunda.frmSaldoHorasDia);
  lPontoSemanal.AdicionarObservador(frmHorasTrabalhadasSemana);
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
