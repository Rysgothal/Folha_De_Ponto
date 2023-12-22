unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario, Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil,
  PontoSemanal.Frames.SaldoHorasDia, PontoSemanal.Helpers.TiposAuxiliares, System.Classes, System.ImageList,
  Vcl.ImgList, PontoSemanal.DataModules.Principal,
  PontoSemanal.Helpers.Componentes;

type
  TfrmPrincipal = class(TForm)
    gbxDadosFuncionario: TGroupBox;
    sttsbarSistemaInfo: TStatusBar;
    tmrHorario: TTimer;
    gbxSeg: TGroupBox;
    frmSegunda: TfrmHorariosDia;
    frmDadosFuncionario: TfrmDadosFuncionario;
    gbxHorasTrabalhadas: TGroupBox;
    frmHorasTrabalhadasSemana: TfrmSaldoHorasDia;
    gbxTer: TGroupBox;
    gbxQua: TGroupBox;
    gbxQui: TGroupBox;
    gbxSex: TGroupBox;
    gbxSab: TGroupBox;
    frmTerca: TfrmHorariosDia;
    frmQuarta: TfrmHorariosDia;
    frmQuinta: TfrmHorariosDia;
    frmSexta: TfrmHorariosDia;
    frmSabado: TfrmHorariosDia;
    memHistHorario: TMemo;
    btnNovoRegistro: TButton;
    btnCarregarHist: TButton;
    btnGerSalHist: TButton;
    procedure tmrHorarioTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frmDadosFuncionarioedtJornadaSemanalExit(Sender: TObject);
    procedure btnNovoRegistroClick(Sender: TObject);
    procedure btnGerSalHistClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
    procedure ConfigurarObservadores;
    procedure AplicarTagFrame(pFrame: TfrmHorariosDia; pTag: TDiaSemana);
    procedure NovoRegistro;
    function VerificarTodosCamposVazios: Boolean;
    procedure LimparFormulario;
    procedure SalvarHistorico;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, PontoSemanal.Classes.Singleton.Principal,
  System.Generics.Collections, PontoSemanal.Interfaces.Observer.Observador;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tmrHorario.Enabled := True;
  sttsbarSistemaInfo.Panels[0].Text := FormatDateTime('ddddddd', Date);
  ConfigurarObservadores;
end;

procedure TfrmPrincipal.frmDadosFuncionarioedtJornadaSemanalExit(Sender: TObject);
begin
  frmDadosFuncionario.edtJornadaSemanalExit(Sender);
  frmSegunda.AtivarEventosOnExit;
  frmTerca.AtivarEventosOnExit;
  frmQuarta.AtivarEventosOnExit;
  frmQuinta.AtivarEventosOnExit;
  frmSexta.AtivarEventosOnExit;
  frmSabado.AtivarEventosOnExit;
end;

procedure TfrmPrincipal.LimparFormulario;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lPontoSemanal.Limpar;

  frmDadosFuncionario.Limpar;
  frmHorasTrabalhadasSemana.Limpar;
  frmSegunda.Limpar;
  frmTerca.Limpar;
  frmQuarta.Limpar;
  frmQuinta.Limpar;
  frmSexta.Limpar;
  frmSabado.Limpar;
  memHistHorario.Clear;
end;

procedure TfrmPrincipal.AtualizarHorarioSistema;
var
  lHorarioAtual: string;
begin
  lHorarioAtual := FormatDateTime('hh:mm:ss', Now);
  sttsbarSistemaInfo.Panels[1].Text := lHorarioAtual;
end;

procedure TfrmPrincipal.btnGerSalHistClick(Sender: TObject);
begin
  SalvarHistorico;
end;

procedure TfrmPrincipal.btnNovoRegistroClick(Sender: TObject);
begin
  NovoRegistro;
end;

procedure TfrmPrincipal.ConfigurarObservadores;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  AplicarTagFrame(frmSegunda, dsSegunda);
  AplicarTagFrame(frmTerca, dsTerca);
  AplicarTagFrame(frmQuarta, dsQuarta);
  AplicarTagFrame(frmQuinta, dsQuinta);
  AplicarTagFrame(frmSexta, dsSexta);
  AplicarTagFrame(frmSabado, dsSabado);
  frmHorasTrabalhadasSemana.Tag := Ord(dsNenhum);

  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lPontoSemanal.AdicionarObservador(dsNenhum, frmHorasTrabalhadasSemana);
end;

procedure TfrmPrincipal.AplicarTagFrame(pFrame: TfrmHorariosDia; pTag: TDiaSemana);
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  pFrame.Tag := Ord(pTag);
  pFrame.frmSaldoHorasDia.Tag := Ord(pTag);

  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lPontoSemanal.AdicionarObservador(pTag, pFrame.frmSaldoHorasDia);
end;

procedure TfrmPrincipal.NovoRegistro;
begin
  if not VerificarTodosCamposVazios and (Application.MessageBox('Ainda existem valores anotados na Folha de Ponto, ' +
    'ao criar um novo registro os dados serão sobrescritos.' + sLineBreak + sLineBreak + '> Deseja realmente ' +
    'criar um novo registro?', 'ATENÇÃO', MB_YESNO + MB_ICONWARNING) = ID_NO) then
  begin
    Exit;
  end;

  LimparFormulario;
  TComponenteHelpers.Focar(frmDadosFuncionario.edtCodigo);
end;

procedure TfrmPrincipal.SalvarHistorico;
begin
  if VerificarTodosCamposVazios then
  
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

function TfrmPrincipal.VerificarTodosCamposVazios: Boolean;
begin
  Result := not frmDadosFuncionario.VerificarTodosValoresPreenchidos;


  for var I := 0 to Pred(Self.ComponentCount) do
  begin
    if not Result then
    begin
      Break;
    end;

    if not (Self.Components[I] is TfrmHorariosDia) then
    begin
      Continue;
    end;

    Result := not TfrmHorariosDia(Self.Components[I]).VerificarTodosHorariosPreenchidos;
  end;
end;

end.
