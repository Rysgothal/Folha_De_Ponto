unit PontoSemanal.Forms.Configuracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmConfiguracoes = class(TForm)
    chkTurnosNoturnos: TCheckBox;
    chkExpedienteSabado: TCheckBox;
    edtCargaSemanalMax: TEdit;
    lblCargaSemanalMax: TLabel;
    chkHorarioAlmocoSabado: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

procedure TfrmConfiguracoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmConfiguracoes := nil;
end;

end.
