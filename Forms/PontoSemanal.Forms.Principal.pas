unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario,
  Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil;

type
  TfrmPrincipal = class(TForm)
    gbxDadosFuncionario: TGroupBox;
    sttsbarSistemaInfo: TStatusBar;
    tmrHorario: TTimer;
    frmDadosFuncionario: TfrmDadosFuncionario;
    gbxSeg: TGroupBox;
    frmSegunda: TfrmHorariosDiaUtil;
    procedure tmrHorarioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, PontoSemanal.Helpers.Enumerados;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tmrHorario.Enabled := True;
  sttsbarSistemaInfo.Panels[0].Text := FormatDateTime('ddddddd', Date);
  frmSegunda.FTag := dsSegunda;
end;

procedure TfrmPrincipal.AtualizarHorarioSistema;
var
  lHorarioAtual: string;
begin
  lHorarioAtual := FormatDateTime('hh:mm:ss', Now);
  sttsbarSistemaInfo.Panels[1].Text := lHorarioAtual;
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
