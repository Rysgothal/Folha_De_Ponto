program RegistroPontoSemanal;

uses
  Vcl.Forms,
  Exercicio05.Forms.Principal in 'Forms\Exercicio05.Forms.Principal.pas' {frmPrincipal},
  Exercicio05.Classes.Horarios in 'Classes\Exercicio05.Classes.Horarios.pas',
  Exercicio05.Helpers.Funcoes in 'Helpers\Exercicio05.Helpers.Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
