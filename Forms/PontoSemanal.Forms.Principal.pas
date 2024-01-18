unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario, Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil,
  PontoSemanal.Frames.SaldoHorasDia, PontoSemanal.Helpers.TiposAuxiliares, System.Classes, System.ImageList,
  Vcl.ImgList, PontoSemanal.DataModules.Principal, System.RegularExpressions,
  PontoSemanal.Helpers.Componentes, PontoSemanal.Classes.Base.Horarios,
  PontoSemanal.Classes.Builder.Diretor,
  PontoSemanal.Interfaces.Builder.FolhaDePonto,
  PontoSemanal.Classes.Builder.Construtor, PontoSemanal.Helpers.Constantes;

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
    procedure btnCarregarHistClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
    procedure AnalisarFolhaDePontoAlterada;
    procedure AnalisarDiaDaSemanaAlterado(pDiaSemana: THorariosDia);
    procedure AnalisarDadosFuncionarioAlterados;
    procedure AplicarTagFrame(pFrame: TfrmHorariosDia; pTag: TDiaSemana);
    procedure BuscarValoresRegEx;
    procedure BuscarValoresHorariosRegEx;
    procedure BuscarValoresDadosFuncionarioRegEx;
    procedure CarregarHistorico;
    procedure CarregarArquivoFolhaDePonto;
    procedure ConfigurarObservadores;
    function ConcatenarHorarios(pDia: THorariosDia): string;
    procedure DefinirCoresPadraoComponentes;
    procedure DestacarHorariosAlterados(pHorarios: THorariosDia; pDia: string);
    procedure DestacarDadosFuncionarioAlterados(pHashFolha, pHashAtual: string; pEdit: TCustomEdit);
    procedure GravarFolhaDePontoSemanal;
    procedure Limpar;
    function NovoRegistro(pCarregandoArquivo: Boolean = False): Boolean;
    procedure PreencherDadosNoMemo;
    procedure PreencherValoresHorariosRegEx(pDiaSemana: TDiaSemana);
    procedure PreencherValoresDadosFuncionario(pRegex: string; pEdit: TCustomEdit);
    function RetornarMatchesHorariosRegex(pDiaSemana: TDiaSemana): TMatchCollection;
//    function RetornarHashDentroArquivo(pPalavraChave: string): string;
    function RetornarFrameDia(pDia: TDiaSemana): TfrmHorariosDia;
    procedure Salvar;
    procedure SalvarHistorico;
    function VerificarPossuiValoresPreenchidos: Boolean;
    function VerificarViolacaoFolhaDePonto: Boolean;
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

procedure TfrmPrincipal.GravarFolhaDePontoSemanal;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lNomeFuncionario: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  try
    lNomeFuncionario := lPontoSemanal.ID + '_' + StringReplace(lPontoSemanal.Nome, ' ', '_', [rfReplaceAll]) + '.TXT';
    dtmPrincipal.SalvarArquivo.FileName := lNomeFuncionario.ToUpper;
    memHistHorario.FocarCabecalho;

    if not dtmPrincipal.SalvarArquivo.Execute then
    begin
      Exit;
    end;

    if (ExtractFileExt(dtmPrincipal.SalvarArquivo.FileName).ToUpper <> '.TXT') and
      (ExtractFileExt(dtmPrincipal.SalvarArquivo.FileName) <> EmptyStr) then
    begin
      Application.MessageBox('A folha de ponto não pode ser salva, a extensão selecionanda não é suportada.' +
        sLineBreak + 'Salve como ".TXT"', 'Atenção', MB_OK + MB_ICONINFORMATION);

      Exit;
    end;

    if FileExists(dtmPrincipal.SalvarArquivo.FileName) then
    begin
      if Application.MessageBox('O arquivo já existe. Deseja substitui-lo?', 'Atenção', MB_YESNO +
        MB_ICONINFORMATION) = ID_NO then
      begin
        Application.MessageBox('Arquivo não foi salvo!', 'Atenção', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
    end;

    memHistHorario.Lines.SaveToFile(dtmPrincipal.SalvarArquivo.FileName);
    Application.MessageBox('Arquivo foi salvo com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);

  except
    on E: Exception do
    begin
      Application.MessageBox('Houve uma falha inesperada, por favor verifique se está tudo em coerência' +
        ' e tente novamente!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TfrmPrincipal.Limpar;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
  lPontoSemanal.Limpar;

  for var lComponente in Self do
  begin
    if (lComponente is TfrmHorariosDia) then
    begin
      TfrmHorariosDia(lComponente).Limpar;
      TfrmHorariosDia(lComponente).DefinirCorPadraoComponentes;
    end;
  end;

  frmDadosFuncionario.Limpar;
  frmHorasTrabalhadasSemana.Limpar;
  memHistHorario.Clear;
  ConfigurarObservadores;
end;

procedure TfrmPrincipal.AtualizarHorarioSistema;
var
  lHorarioAtual: string;
begin
  lHorarioAtual := FormatDateTime('hh:mm:ss', Now);
  sttsbarSistemaInfo.Panels[1].Text := lHorarioAtual;
end;

procedure TfrmPrincipal.btnCarregarHistClick(Sender: TObject);
begin
  CarregarHistorico;
end;

procedure TfrmPrincipal.btnGerSalHistClick(Sender: TObject);
begin
  ActiveControl := btnGerSalHist;
  SalvarHistorico;
end;

procedure TfrmPrincipal.btnNovoRegistroClick(Sender: TObject);
begin
  NovoRegistro;
end;

procedure TfrmPrincipal.BuscarValoresDadosFuncionarioRegEx;
begin
  PreencherValoresDadosFuncionario(TConstantes.REGEX_CODIGO_FUNCIONARIO, frmDadosFuncionario.edtCodigo);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_NOME_FUNCIONARIO, frmDadosFuncionario.edtNome);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_ADMISSAO_FUNCIONARIO, frmDadosFuncionario.edtAdmissao);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_JORNADA_FUNCIONARIO, frmDadosFuncionario.edtJornadaSemanal);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_INTERVALO_FUNCIONARIO, frmDadosFuncionario.edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.BuscarValoresHorariosRegEx;
begin
  for var lDiaSemana := Low(TDiaSemana) to High(TDiaSemana) do
  begin
    PreencherValoresHorariosRegEx(lDiaSemana);
  end;
end;

procedure TfrmPrincipal.BuscarValoresRegEx;
begin
  BuscarValoresDadosFuncionarioRegEx;
  BuscarValoresHorariosRegEx;
end;

procedure TfrmPrincipal.CarregarArquivoFolhaDePonto;
var
  lPassWord: string;
begin
  try
    lPassWord := EmptyStr;

    if not dtmPrincipal.CarregarArquivo.Execute then
    begin
      Exit;
    end;

    if ExtractFileExt(dtmPrincipal.CarregarArquivo.FileName).ToUpper <> '.TXT' then
    begin
      Application.MessageBox('O arquivo selecionado não corresponde a extensão suportada (.txt)', 'Atenção', MB_OK +
        MB_ICONINFORMATION);
      Exit;
    end;

    memHistHorario.Lines.LoadFromFile(dtmPrincipal.CarregarArquivo.FileName);

    if TStringHelpers.VerificarCampoVazio(memHistHorario.Text) then
    begin
      memHistHorario.Clear;
      Application.MessageBox('> Folha de Ponto inválida <' + sLineBreak + 'O Arquivo escolhido não possui dados',
        'Atenção', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    BuscarValoresRegEx;

    if VerificarViolacaoFolhaDePonto then
    begin
      Limpar;

      while lPassWord <> 'gansodeterno' do
      begin
        lPassWord := InputBox('Arquivo violado!', #9'A Folha de Ponto foi violada, alguns dados podem ter sido' +
          sLineBreak + 'alterados, estarão descatados caso tenham inconformidade. Digite a Palavra-Chave:', '');

        if TStringHelpers.VerificarCampoVazio(lPassWord) then
        begin
          Exit;
        end;

        if (lPassWord.Trim <> 'gansodeterno') and (Application.MessageBox('> Senha Incorreta <' + sLineBreak +
          'A senha inserida está inválida', 'Atenção', MB_OKCANCEL + MB_ICONWARNING) = ID_CANCEL) then
        begin
          Exit;
        end;
      end;

      memHistHorario.Lines.LoadFromFile(dtmPrincipal.CarregarArquivo.FileName);
      BuscarValoresRegEx;
      frmDadosFuncionarioedtJornadaSemanalExit(nil);
      AnalisarFolhaDePontoAlterada;
    end;

    memHistHorario.FocarCabecalho;
    frmDadosFuncionarioedtJornadaSemanalExit(nil);
  except
    on E: Exception do
    begin
      if E.ClassType = EAbort then
      begin
        Exit;
      end;

      Application.MessageBox(PChar('Houve uma inconsistencia no sistema, verifique:' + sLineBreak + E.Message),
        'Atenção', MB_OKCANCEL + MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmPrincipal.CarregarHistorico;
begin
  if not NovoRegistro(True) then
  begin
    Exit;
  end;

  CarregarArquivoFolhaDePonto;
end;

function TfrmPrincipal.ConcatenarHorarios(pDia: THorariosDia): string;
begin
  Result := pDia.Entrada + pDia.SaidaAlmoco + pDia.RetornoAlmoco + pDia.SaidaFinal;
end;

procedure TfrmPrincipal.ConfigurarObservadores;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
//  frmSegunda.NomeDoFrame := dsSegunda;
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

procedure TfrmPrincipal.DefinirCoresPadraoComponentes;
begin
  frmDadosFuncionario.DefinirCorPadraoComponentes;

  for var I := 0 to Pred(ComponentCount) do
  begin
    if not (Components[I] is TfrmHorariosDia) then
    begin
      Continue;
    end;

    TfrmHorariosDia(Components[I]).DefinirCorPadraoComponentes;
  end;
end;

procedure TfrmPrincipal.AnalisarDadosFuncionarioAlterados;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
  lHashFolha, lHashAtual: TArray<string>;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  lHashFolha := [
//    RetornarHashDentroArquivo('Funcionario-Codigo'), RetornarHashDentroArquivo('Funcionario-Nome'),
//    RetornarHashDentroArquivo('Funcionario-Admissao'), RetornarHashDentroArquivo('Funcionario-Jornada'),
//    RetornarHashDentroArquivo('Funcionario-Intervalo')
  ];

  lHashAtual := [
    TStringHelpers.HashMD5(lPontoSemanal.ID), TStringHelpers.HashMD5(lPontoSemanal.Nome),
    TStringHelpers.HashMD5(lPontoSemanal.DataAdmissao), TStringHelpers.HashMD5(lPontoSemanal.JornadaSemanal),
    TStringHelpers.HashMD5(lPontoSemanal.IntervaloAlmoco)
  ];

  DestacarDadosFuncionarioAlterados(lHashFolha[0], lHashAtual[0], frmDadosFuncionario.edtCodigo);
  DestacarDadosFuncionarioAlterados(lHashFolha[1], lHashAtual[1], frmDadosFuncionario.edtNome);
  DestacarDadosFuncionarioAlterados(lHashFolha[2], lHashAtual[2], frmDadosFuncionario.edtAdmissao);
  DestacarDadosFuncionarioAlterados(lHashFolha[3], lHashAtual[3], frmDadosFuncionario.edtJornadaSemanal);
  DestacarDadosFuncionarioAlterados(lHashFolha[4], lHashAtual[4], frmDadosFuncionario.edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.AnalisarDiaDaSemanaAlterado(pDiaSemana: THorariosDia);
var
  lNomeDia, lHashDiaAtual: string;
begin
  lNomeDia := pDiaSemana.PegarNomeDaSemana;
  lHashDiaAtual := ConcatenarHorarios(pDiaSemana);
  lHashDiaAtual := TStringHelpers.HashMD5(lHashDiaAtual);

//  if RetornarHashDentroArquivo('[' + lNomeDia + ']') <> lHashDiaAtual then
  begin
    DestacarHorariosAlterados(pDiaSemana, lNomeDia);
  end;
end;

procedure TfrmPrincipal.DestacarDadosFuncionarioAlterados(pHashFolha, pHashAtual: string; pEdit: TCustomEdit);
var
  lEdit: TEdit absolute pEdit;
begin
  if not TStringHelpers.VerificarDiferenca(pHashFolha, pHashAtual) then
  begin
    Exit;
  end;

  lEdit.Color := $006969D6;
end;

procedure TfrmPrincipal.DestacarHorariosAlterados(pHorarios: THorariosDia; pDia: string);
var
  lHashArquivo, lHashAtual: TArray<string>;
  lFrame: TfrmHorariosDia;
begin
  lHashArquivo := [
//    RetornarHashDentroArquivo('[' + pDia + '-Entrada]'), RetornarHashDentroArquivo('[' + pDia + '-SaidaAlmoco]'),
//    RetornarHashDentroArquivo('[' + pDia + '-RetornoAlmoco]'), RetornarHashDentroArquivo('[' + pDia + '-SaidaFinal]')
  ];

  lHashAtual := [
    TStringHelpers.HashMD5(pHorarios.Entrada), TStringHelpers.HashMD5(pHorarios.SaidaAlmoco),
    TStringHelpers.HashMD5(pHorarios.RetornoAlmoco), TStringHelpers.HashMD5(pHorarios.SaidaFinal)
  ];

  lFrame := RetornarFrameDia(pHorarios.Tag);

  for var I := 0 to Pred(Length(lHashArquivo)) do
  begin
    if (TDiaSemana(lFrame.Tag) = dsSabado) and (I in [1, 2]) then
    begin
      Continue;
    end;

    if TStringHelpers.VerificarDiferenca(lHashArquivo[I], lHashAtual[I]) then
    begin
      lFrame.AlterarEditHorarioViolado(TRegistroHorario(I));
    end;
  end;
end;

procedure TfrmPrincipal.AnalisarFolhaDePontoAlterada;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  AnalisarDadosFuncionarioAlterados;
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Segunda);
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Terca);
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Quarta);
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Quinta);
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Sexta);
  AnalisarDiaDaSemanaAlterado(lPontoSemanal.Sabado);
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

function TfrmPrincipal.NovoRegistro(pCarregandoArquivo: Boolean): Boolean;
var
  lPossuiValoresPreenchidos: Boolean;
  lMsgAuxiliar: string;
begin
  Result := True;

  lPossuiValoresPreenchidos := VerificarPossuiValoresPreenchidos;

  case pCarregandoArquivo of
    True: lMsgAuxiliar := 'carregar um registro?';
    else lMsgAuxiliar := 'criar um novo registro?';
  end;

  if lPossuiValoresPreenchidos and (Application.MessageBox(PChar('Ainda existem valores anotados na Folha de Ponto, ' +
    'ao prosseguir os dados serão sobrescritos.' + sLineBreak + sLineBreak + '> Deseja realmente ' + lMsgAuxiliar),
    'ATENÇÃO', MB_YESNO + MB_ICONWARNING) = ID_NO) then
  begin
    Exit(False);
  end;

  Limpar;

  if not pCarregandoArquivo then
  begin
    TComponenteHelpers.Focar(frmDadosFuncionario.edtCodigo);
  end;
end;

procedure TfrmPrincipal.PreencherDadosNoMemo;
var
  lDiretor: TDiretor;
  lConstrutor: IConstrutor;
  lFolhaDePonto: TStringList;
begin
  lDiretor := TDiretor.Create;
  lConstrutor := TConstrutor.Create;

  try
    lDiretor.Construir(lConstrutor);
    lFolhaDePonto := lConstrutor.GetFolhaDePonto;
    memHistHorario.Lines := lFolhaDePonto;
  finally
    FreeAndNil(lDiretor);
  end;
end;

procedure TfrmPrincipal.PreencherValoresDadosFuncionario(pRegex: string; pEdit: TCustomEdit);
var
  lRegex: TRegEx;
begin
  lRegex := TRegEx.Create(pRegex, [roIgnoreCase]);

  if not lRegex.IsMatch(memHistHorario.Text) then
  begin
    Exit;
  end;

  pEdit.Text := lRegex.Match(memHistHorario.Text).Groups[2].Value;
  TEdit(pEdit).OnExit(pEdit);
end;

procedure TfrmPrincipal.PreencherValoresHorariosRegEx(pDiaSemana: TDiaSemana);
var
  lFrame: TfrmHorariosDia;
begin
  for var lMatch in RetornarMatchesHorariosRegex(pDiaSemana) do
  begin
    lFrame := RetornarFrameDia(pDiaSemana);
    lFrame.PreencherValoresHorarios(lMatch.Groups);
  end;
end;

function TfrmPrincipal.RetornarFrameDia(pDia: TDiaSemana): TfrmHorariosDia;
begin
  case pDia of
    dsSegunda: Result := frmSegunda;
    dsTerca: Result := frmTerca;
    dsQuarta: Result := frmQuarta;
    dsQuinta: Result := frmQuinta;
    dsSexta: Result := frmSexta;
    dsSabado: Result := frmSabado;
    else Result := nil;
  end;
end;

//function TfrmPrincipal.RetornarHashDentroArquivo(pPalavraChave: string): string;
//begin
//  for var I := 0 to Pred(memHistHorario.Lines.Count) do
//  begin
//    Result := memHistHorario.Lines[I];
//
//    if not Result.Contains(pPalavraChave) then
//    begin
//      Continue;
//    end;
//
//    Result := Copy(Result, Pos(':', Result) + 1, Length(Result)).Trim;
//    Break;
//  end;
//end;

function TfrmPrincipal.RetornarMatchesHorariosRegex(pDiaSemana: TDiaSemana): TMatchCollection;
var
  lRegex: string;
begin
  case pDiaSemana of
    dsSegunda: lRegex := TConstantes.REGEX_SEGUNDA_HORARIOS;
    dsTerca: lRegex := TConstantes.REGEX_TERCA_HORARIOS;
    dsQuarta: lRegex := TConstantes.REGEX_QUARTA_HORARIOS;
    dsQuinta: lRegex := TConstantes.REGEX_QUINTA_HORARIOS;
    dsSexta: lRegex := TConstantes.REGEX_SEXTA_HORARIOS;
    dsSabado: lRegex := TConstantes.REGEX_SABADO_HORARIOS;
    else Exit;
  end;

  Result := TRegex.Matches(memHistHorario.Text, lRegex, [roIgnoreCase]);
end;

procedure TfrmPrincipal.Salvar;
var
  lEdits: TArray<TMaskEdit>;
begin
//  frmDadosFuncionarioedtJornadaSemanalExit(nil);
  for var lComponente in Self do
  begin
    if not (lComponente is TfrmHorariosDia) then
    begin
      Continue;
    end;

    lEdits := TfrmHorariosDia(lComponente).RetornarEditsNaoVerificados;

    if lEdits <> nil then
    begin
      Application.MessageBox('Ainda possui valores que não foram revisados, verifique', 'Atenção',
        MB_OK + MB_ICONINFORMATION);
      TComponenteHelpers.Focar(lEdits[0]);
      Exit;
    end;
  end;

  PreencherDadosNoMemo;
  GravarFolhaDePontoSemanal;
  DefinirCoresPadraoComponentes;
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

function TfrmPrincipal.VerificarViolacaoFolhaDePonto: Boolean;
var
  lHashArquivo, lHashAtual: string;
  I: Integer;
begin
  I := Pred(memHistHorario.Lines.Count);
  Result := False;

  while I >= 0 do
  begin
    lHashArquivo := memHistHorario.Lines[I];
    memHistHorario.Lines.Delete(I);
    lHashAtual := TStringHelpers.HashMD5(memHistHorario.Text);
    Dec(I);

    if TStringHelpers.VerificarDiferenca(lHashArquivo, lHashArquivo) then
    begin
      Exit(True);
    end;
  end;

  memHistHorario.FocarCabecalho;
//
//  lHashAtual := TStringHelpers.HashMD5(memHistHorario.Text);
//  Result := TStringHelpers.VerificarDiferenca(lHashArquivo, lHashAtual);
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
