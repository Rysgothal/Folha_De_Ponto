program FolhaPontoSemanal;

uses
  Vcl.Forms,
  PontoSemanal.Forms.Principal in 'Forms\PontoSemanal.Forms.Principal.pas' {frmPrincipal},
  PontoSemanal.DataModules.Principal in 'DataModules\PontoSemanal.DataModules.Principal.pas' {dtmPrincipal: TDataModule},
  PontoSemanal.Helpers.Strings in 'Helpers\PontoSemanal.Helpers.Strings.pas',
  PontoSemanal.Helpers.Componentes in 'Helpers\PontoSemanal.Helpers.Componentes.pas',
  PontoSemanal.Classes.Singleton.Principal in 'Classes\Singleton\PontoSemanal.Classes.Singleton.Principal.pas',
  PontoSemanal.Helpers.Exceptions in 'Helpers\PontoSemanal.Helpers.Exceptions.pas',
  PontoSemanal.Classes.Base.Configuracoes in 'Classes\Base\PontoSemanal.Classes.Base.Configuracoes.pas',
  PontoSemanal.Frames.DadosFuncionario in 'Frames\PontoSemanal.Frames.DadosFuncionario.pas' {frmDadosFuncionario: TFrame},
  PontoSemanal.Frames.HorarioDiaUtil in 'Frames\PontoSemanal.Frames.HorarioDiaUtil.pas' {frmHorariosDia: TFrame},
  PontoSemanal.Interfaces.Observer.Observador in 'Interfaces\Observer\PontoSemanal.Interfaces.Observer.Observador.pas',
  PontoSemanal.Interfaces.Observer.Sujeito in 'Interfaces\Observer\PontoSemanal.Interfaces.Observer.Sujeito.pas',
  PontoSemanal.Classes.Base.Horarios in 'Classes\Base\PontoSemanal.Classes.Base.Horarios.pas',
  PontoSemanal.Helpers.TiposAuxiliares in 'Helpers\PontoSemanal.Helpers.TiposAuxiliares.pas',
  PontoSemanal.Frames.SaldoHorasDia in 'Frames\PontoSemanal.Frames.SaldoHorasDia.pas' {frmSaldoHorasDia: TFrame},
  PontoSemanal.Classes.Base.Desempenho in 'Classes\Base\PontoSemanal.Classes.Base.Desempenho.pas',
  PontoSemanal.Interfaces.Bridge.Converter in 'Interfaces\Bridge\PontoSemanal.Interfaces.Bridge.Converter.pas',
  PontoSemanal.Classes.Bridge.Converter in 'Classes\Bridge\PontoSemanal.Classes.Bridge.Converter.pas',
  PontoSemanal.Interfaces.Builder.FolhaDePonto in 'Interfaces\Builder\PontoSemanal.Interfaces.Builder.FolhaDePonto.pas',
  PontoSemanal.Classes.Builder.Diretor in 'Classes\Builder\PontoSemanal.Classes.Builder.Diretor.pas',
  PontoSemanal.Classes.Builder.Construtor in 'Classes\Builder\PontoSemanal.Classes.Builder.Construtor.pas',
  PontoSemanal.Helpers.Constantes in 'Helpers\PontoSemanal.Helpers.Constantes.pas',
  PontoSemanal.Classes.Builder.Layout in 'Classes\Builder\PontoSemanal.Classes.Builder.Layout.pas',
  PontoSemanal.Forms.Configuracoes in 'Forms\PontoSemanal.Forms.Configuracoes.pas' {frmConfiguracoes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.Run;
end.
