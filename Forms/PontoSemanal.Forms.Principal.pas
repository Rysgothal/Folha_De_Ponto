unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario, Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil,
  PontoSemanal.Frames.SaldoHorasDia, PontoSemanal.Helpers.TiposAuxiliares, System.Classes, System.ImageList,
  Vcl.ImgList, PontoSemanal.DataModules.Principal,
  PontoSemanal.Helpers.Componentes, PontoSemanal.Classes.Base.Horarios;

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
    procedure LimparFormulario;
    procedure SalvarHistorico;
    function VerificarPossuiValoresPreenchidos: Boolean;
    procedure Salvar;
    procedure PreencherDadosNoMemo;
    procedure PreencherDadosNoMemoLinha;
    procedure PreencherDadosNoMemoDiaSemana(pDia: THorariosDia);
    procedure PreencherDadosNoMemoRodape;
    procedure AdicionarHashArquivo;
    procedure PreencherDadosNoMemoHashHorarios(pDia: string; pHashEntrada: string; pHashSaidaFinal: string;
      pHashSaidaAlmoco: string = ''; pHashRetornoAlmoco: string = '');
    function ConcatenarHorarios(pDia: THorariosDia): string;

    const HASH_SALTING = '3175634@0733b$66ç723464335&d5d5*b5d5ód~2d5b2d3d5b';
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, PontoSemanal.Classes.Singleton.Principal, System.StrUtils,
  System.Generics.Collections, PontoSemanal.Interfaces.Observer.Observador,
  PontoSemanal.Helpers.Strings;

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

function TfrmPrincipal.ConcatenarHorarios(pDia: THorariosDia): string;
begin
  Result := pDia.Entrada + pDia.SaidaAlmoco + pDia.RetornoAlmoco + pDia.SaidaFinal;
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

procedure TfrmPrincipal.AdicionarHashArquivo;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  lSegunda := ConcatenarHorarios(lPontoSemanal.Segunda);
  lTerca := ConcatenarHorarios(lPontoSemanal.Terca);
  lQuarta := ConcatenarHorarios(lPontoSemanal.Quarta);
  lQuinta := ConcatenarHorarios(lPontoSemanal.Quinta);
  lSexta := ConcatenarHorarios(lPontoSemanal.Sexta);
  lSabado := ConcatenarHorarios(lPontoSemanal.Sabado);

  memHistHorario.Lines.Add('[Folha]: ' + TStringHelpers.HashMD5(memHistHorario.Text, HASH_SALTING));
  memHistHorario.Lines.Add('[Segunda]: ' + TStringHelpers.HashMD5(lSegunda, HASH_SALTING));
  memHistHorario.Lines.Add('[Terca]: ' + TStringHelpers.HashMD5(lTerca, HASH_SALTING));
  memHistHorario.Lines.Add('[Quarta]: ' + TStringHelpers.HashMD5(lQuarta, HASH_SALTING));
  memHistHorario.Lines.Add('[Quinta]: ' + TStringHelpers.HashMD5(lQuinta, HASH_SALTING));
  memHistHorario.Lines.Add('[Sexta]: ' + TStringHelpers.HashMD5(lSexta, HASH_SALTING));
  memHistHorario.Lines.Add('[Sabado]: ' + TStringHelpers.HashMD5(lSabado, HASH_SALTING));

  AdicionarHashDiaSemana(Segunda.Nome, MD5(Segunda.Entrada), MD5(Segunda.SaidaFinal), MD5(Segunda.SaidaAlmoco),
    MD5(Segunda.RetornoAlmoco));

  AdicionarHashDiaSemana(Terca.Nome, MD5(Terca.Entrada), MD5(Terca.SaidaFinal), MD5(Terca.SaidaAlmoco),
  MD5(Terca.RetornoAlmoco));

  AdicionarHashDiaSemana(Quarta.Nome, MD5(Quarta.Entrada), MD5(Quarta.SaidaFinal), MD5(Quarta.SaidaAlmoco),
    MD5(Quarta.RetornoAlmoco));

  AdicionarHashDiaSemana(Quinta.Nome, MD5(Quinta.Entrada), MD5(Quinta.SaidaFinal), MD5(Quinta.SaidaAlmoco),
    MD5(Quinta.RetornoAlmoco));

  AdicionarHashDiaSemana(Sexta.Nome, MD5(Sexta.Entrada), MD5(Sexta.SaidaFinal), MD5(Sexta.SaidaAlmoco),
    MD5(Sexta.RetornoAlmoco));

   AdicionarHashDiaSemana(Sabado.Nome, MD5(Sabado.Entrada), MD5(Sabado.SaidaFinal));
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
var
  lPossuiValoresPreenchidos: Boolean;
begin
  lPossuiValoresPreenchidos := VerificarPossuiValoresPreenchidos;

  if lPossuiValoresPreenchidos and (Application.MessageBox('Ainda existem valores anotados na Folha de Ponto, ' +
    'ao criar um novo registro os dados serão sobrescritos.' + sLineBreak + sLineBreak + '> Deseja realmente ' +
    'criar um novo registro?', 'ATENÇÃO', MB_YESNO + MB_ICONWARNING) = ID_NO) then
  begin
    Exit;
  end;

  LimparFormulario;
  TComponenteHelpers.Focar(frmDadosFuncionario.edtCodigo);
end;

procedure TfrmPrincipal.PreencherDadosNoMemo;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  memHistHorario.Clear;
  memHistHorario.Lines.Add(' =====================================');
  memHistHorario.Lines.Add(' Registro de Ponto Semanal - Histórico');
  memHistHorario.Lines.Add(' =====================================');
  memHistHorario.Lines.Add(' ');
  memHistHorario.Lines.Add(' Código...........: ' + lPontoSemanal.ID);
  memHistHorario.Lines.Add(' Funcionário......: ' + lPontoSemanal.Nome);
  memHistHorario.Lines.Add(' Admissão.........: ' + lPontoSemanal.DataAdmissao + ' ' + lPontoSemanal.TempoAdmissao);
  memHistHorario.Lines.Add(' Jornada semanal..: ' + lPontoSemanal.JornadaSemanal + ' horas');
  memHistHorario.Lines.Add(' Intervalo almoço.: ' + lPontoSemanal.IntervaloAlmoco + ' -> ' + frmDadosFuncionario.lblTempoExtenso.Caption);
  memHistHorario.Lines.Add(' ');
  memHistHorario.Lines.Add('  ______________________________________________________________________________________');
  memHistHorario.Lines.Add(' /                |         |              |                |             |             \ ');
  memHistHorario.Lines.Add(' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ');
  memHistHorario.Lines.Add(' |                |         |              |                |             |             | ');
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Segunda);
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Terca);
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Quarta);
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Quinta);
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Sexta);
  PreencherDadosNoMemoLinha;
  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Sabado);
  PreencherDadosNoMemoLinha;
  memHistHorario.Lines.Add(' |                                                                                      | ');
  PreencherDadosNoMemoRodape;
  memHistHorario.Lines.Add(' |                                                                                      | ');
  memHistHorario.Lines.Add(' \______________________________________________________________________________________/');
end;

procedure TfrmPrincipal.PreencherDadosNoMemoDiaSemana(pDia: THorariosDia);
var
  lDiaNome, lSaidaAlmoco, lRetornoAlmoco, lHorariosNoMemo: string;
begin
  case TDiaSemana(pDia.Tag) of
    dsSegunda: lDiaNome := 'Segunda-Feira';
    dsTerca: lDiaNome := 'Terça-Feira';
    dsQuarta: lDiaNome := 'Quarta-Feira';
    dsQuinta: lDiaNome := 'Quinta-Feira';
    dsSexta: lDiaNome := 'Sexta-Feira';
    dsSabado: lDiaNome := 'Sábado';
  end;

  lSaidaAlmoco := IfThen(pDia.SaidaAlmoco.Trim = EmptyStr, '00:00', pDia.SaidaAlmoco).PadRight(10, ' ').PadLeft(14, ' ');
  lRetornoAlmoco := IfThen(pDia.RetornoAlmoco.Trim = EmptyStr, '00:00', pDia.RetornoAlmoco).PadRight(11, ' ').PadLeft(16, ' ');

  lHorariosNoMemo := lDiaNome.PadRight(15, ' ') + '|   ' + pDia.Entrada + ' |' + lSaidaAlmoco + '|' + lRetornoAlmoco +
    '|    ' + pDia.SaidaFinal + '    |    ' + pDia.Desempenho.TotalTrabalhado;

  memHistHorario.Lines.Add(' | ' + lHorariosNoMemo + '    | ');
end;

procedure TfrmPrincipal.PreencherDadosNoMemoHashHorarios(pDia, pHashEntrada, pHashSaidaFinal, pHashSaidaAlmoco,
  pHashRetornoAlmoco: string);
begin
  memHistHorario.Lines.Add('[' + pDia + '-Entrada]: ' + pHashEntrada);

  if not (pHashSaidaAlmoco.Trim = EmptyStr) and not VerificarCampoVazio(pHashSaidaF) then
  begin
    memHistHorario.Lines.Add('[' + pDia + '-SaidaAlmoco]: ' + pHashSaidaA);
    memHistHorario.Lines.Add('[' + pDia + '-RetornoAlmoco]: ' + pHashRetornoA);
  end;

  memHistHorario.Lines.Add('[' + pDia + '-SaidaFinal]: ' + pHashSaidaF);
end;

procedure TfrmPrincipal.PreencherDadosNoMemoLinha;
begin
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
end;

procedure TfrmPrincipal.PreencherDadosNoMemoRodape;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lHorasTrabalhadas, lSaldoHoras, lFraseHorasFaltantes, lFraseHorasExcedentes: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lHorasTrabalhadas := lPontoSemanal.Desempenho.TotalTrabalhado;
  lSaldoHoras := lPontoSemanal.Desempenho.SaldoHoras.PadRight(9, ' ');

  lFraseHorasFaltantes := 'Horas/minutos faltantes:      -      '.PadLeft(86, ' ');
  lFraseHorasExcedentes := 'Horas/minutos excedentes:      -      '.PadLeft(86, ' ');

  case lPontoSemanal.Desempenho.CumprimentoHorario of
    chAcima: lFraseHorasExcedentes := 'Horas/minutos excedentes:    '.PadLeft(77, ' ') + lSaldoHoras;
    chAbaixo: lFraseHorasFaltantes := 'Horas/minutos faltantes:    '.PadLeft(77, ' ') + lSaldoHoras;
  end;

  memHistHorario.Lines.Add(' |' + 'Total de horas trabalhadas na semana:    '.PadLeft(77, ' ') + lHorasTrabalhadas +
    '    | ');
  memHistHorario.Lines.Add(' |' + lFraseHorasFaltantes + '| ');
  memHistHorario.Lines.Add(' |' + lFraseHorasExcedentes + '| ');
end;

procedure TfrmPrincipal.Salvar;
begin
  PreencherDadosNoMemo;
  AdicionarHashArquivo;
end;

procedure TfrmPrincipal.SalvarHistorico;
var
  lTodosCamposPreenchidos: Boolean;
begin
  lTodosCamposPreenchidos := frmDadosFuncionario.VerificarTodosValoresAnotados and
    frmSegunda.VerificarTodosValoresAnotados and frmTerca.VerificarTodosValoresAnotados and
    frmQuarta.VerificarTodosValoresAnotados and frmQuinta.VerificarTodosValoresAnotados and
    frmSexta.VerificarTodosValoresAnotados and frmSabado.VerificarTodosValoresAnotados;

  if lTodosCamposPreenchidos then
  begin
    Salvar;
    Exit;
  end;

  Application.MessageBox('Existem valores que não foram anotados na Folha de Ponto, verifique.' + sLineBreak,
    'ATENÇÃO', MB_OK + MB_ICONINFORMATION);
end;

function TfrmPrincipal.VerificarPossuiValoresPreenchidos: Boolean;
begin
  Result := False;

  if frmDadosFuncionario.VerificarSePossuiValoresAnotados then
  begin
    Exit(True);
  end;

  for var I := 0 to Pred(Self.ComponentCount) do
  begin
    if Result then
    begin
      Break;
    end;

    if not (Self.Components[I] is TfrmHorariosDia) then
    begin
      Continue;
    end;

    Result := TfrmHorariosDia(Self.Components[I]).VerificarSePossuiValoresAnotados;
  end;
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
