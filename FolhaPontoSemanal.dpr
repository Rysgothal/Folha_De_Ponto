program FolhaPontoSemanal;

uses
  Vcl.Forms,
  PontoSemanal.Forms.Principal in 'Forms\PontoSemanal.Forms.Principal.pas' {frmPrincipal},
  PontoSemanal.DataModules.Principal in 'DataModules\PontoSemanal.DataModules.Principal.pas' {dtmPrincipal: TDataModule},
  PontoSemanal.Helpers.Strings in 'Helpers\PontoSemanal.Helpers.Strings.pas',
  PontoSemanal.Helpers.Componentes in 'Helpers\PontoSemanal.Helpers.Componentes.pas',
  PontoSemanal.Classes.Singleton.Principal in 'Classes\Singleton\PontoSemanal.Classes.Singleton.Principal.pas',
  PontoSemanal.Helpers.Exceptions in 'Helpers\PontoSemanal.Helpers.Exceptions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.Run;
end.
