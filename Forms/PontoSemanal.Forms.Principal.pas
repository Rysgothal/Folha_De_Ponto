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
    procedure ConfigurarObservadores;
    procedure AplicarTagFrame(pFrame: TfrmHorariosDia; pTag: TDiaSemana);
    function NovoRegistro: Boolean;
    procedure LimparFormulario;
    procedure SalvarHistorico;
    procedure CarregarHistorico;
    function VerificarPossuiValoresPreenchidos: Boolean;
    procedure Salvar;
    procedure PreencherDadosNoMemo;
    procedure PreencherDadosNoMemoLinha;
    procedure PreencherDadosNoMemoDiaSemana(pDia: THorariosDia);
    procedure PreencherDadosNoMemoRodape;
    procedure AdicionarHashMemo;
    procedure PreencherDadosNoMemoHashHorarios(pDia: THorariosDia);
    function ConcatenarHorarios(pDia: THorariosDia): string;
    procedure GravarFolhaDePontoSemanal;
    procedure DefinirCoresPadraoComponentes;
    procedure CarregarArquivoFolhaDePonto;
    procedure BuscarValoresHorariosRegEx;
    procedure BuscarValoresDadosFuncionario;
    procedure PreencherValoresDadosFuncionario(pRegex: string; pEdit: TCustomEdit);
    function VerificarViolacaoFolhaDePonto: Boolean;
    function RetornarHashDentroArquivo(pPalavraChave: string): string;
    procedure AnalizarHorariosAlteradosSemana;
    procedure AnalizarDiaDaSemanaAlterado(pDiaSemana: THorariosDia);
    procedure DestacarHorariosAlterados(pHorarios: THorariosDia; pDia: string);
    function RetornarFrameDia(pDia: TDiaSemana): TfrmHorariosDia;
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
    lNomeFuncionario := lPontoSemanal.ID + '_' + StringReplace(lPontoSemanal.Nome, ' ', '_', [rfReplaceAll]) + '.txt';
    dtmPrincipal.SalvarArquivo.FileName := lNomeFuncionario;
    memHistHorario.FocarCabecalho;

    if not dtmPrincipal.SalvarArquivo.Execute then
    begin
      Exit;
    end;

    if (ExtractFileExt(dtmPrincipal.SalvarArquivo.FileName) <> '.txt') and (ExtractFileExt(dtmPrincipal.SalvarArquivo.FileName) <> EmptyStr) then
    begin
      Application.MessageBox('A folha de ponto não pode ser salva, a extensão selecionanda não é suportada.' +
        sLineBreak + 'Salve como ".TXT"', 'Atenção', MB_OK + MB_ICONINFORMATION);

      Exit;
    end;

    if FileExists(dtmPrincipal.SalvarArquivo.FileName) then
    begin
      if Application.MessageBox('O Arquivo já existe. Deseja Substitui-lo?', 'Atenção', MB_YESNO +
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
  SalvarHistorico;
end;

procedure TfrmPrincipal.btnNovoRegistroClick(Sender: TObject);
begin
  NovoRegistro;
end;

procedure TfrmPrincipal.BuscarValoresDadosFuncionario;
begin
  PreencherValoresDadosFuncionario(TConstantes.REGEX_CODIGO_FUNCIONARIO, frmDadosFuncionario.edtCodigo);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_NOME_FUNCIONARIO, frmDadosFuncionario.edtNome);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_ADMISSAO_FUNCIONARIO, frmDadosFuncionario.edtAdmissao);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_JORNADA_FUNCIONARIO, frmDadosFuncionario.edtJornadaSemanal);
  PreencherValoresDadosFuncionario(TConstantes.REGEX_INTERVALO_FUNCIONARIO, frmDadosFuncionario.edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.BuscarValoresHorariosRegEx;
var
  lDiaNome: string;
  lMatches: TMatchCollection;
  lFrame: TfrmHorariosDia;
  lDiaSemana: TDiaSemana;
begin
  lMatches := TRegex.Matches(memHistHorario.Text, TConstantes.REGEX_HORARIOS, [roIgnoreCase]);

  for var lMatch in lMatches do
  begin
    for var lGroup in lMatch.Groups do
    begin
      lDiaNome := Copy(lGroup.Value.Trim, 1, 3);
      lDiaNome := lDiaNome.Replace('á', 'a', [rfReplaceAll]);
      lDiaSemana := TDiaSemana(IndexStr(lDiaNome, ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab']));

      if lDiaSemana = dsNenhum then
      begin
        Continue;
      end;

      lFrame := RetornarFrameDia(lDiaSemana);
      lFrame.PreencherValoresHorarios(lMatch.Groups);
    end;
  end;
end;

procedure TfrmPrincipal.CarregarArquivoFolhaDePonto;
begin
  try
    if not dtmPrincipal.CarregarArquivo.Execute then
    begin
      Exit;
    end;

    if ExtractFileExt(dtmPrincipal.CarregarArquivo.FileName) <> '.txt' then
    begin
      Application.MessageBox('O arquivo selecionado não corresponde a extensão suportada (.txt)', 'Atenção', MB_OK +
        MB_ICONINFORMATION);
      Exit;
    end;

    memHistHorario.Lines.LoadFromFile(dtmPrincipal.CarregarArquivo.FileName);

    if not TRegex.IsMatch(memHistHorario.Text, TConstantes.REGEX_HORARIOS, [roIgnoreCase]) then
    begin
      memHistHorario.Clear;
      Application.MessageBox('> Folha de Ponto inválida <' + sLineBreak + 'O Arquivo escolhido não possui nenhum horário',
        'Atenção', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    BuscarValoresDadosFuncionario;
    BuscarValoresHorariosRegEx;

    if VerificarViolacaoFolhaDePonto then
    begin
      LimparFormulario;
      memHistHorario.Clear;

      var vPassWord: string;
      vPassWord := EmptyStr;

      while vPassWord <> 'gansodeterno' do
      begin
        if (vPassWord.Trim <> EmptyStr) and (Application.MessageBox('> Senha Incorreta <' + sLineBreak +
          'A senha inserida está inválida', 'Atenção', MB_OKCANCEL + MB_ICONWARNING) = ID_CANCEL) then
        begin
          Exit;
        end;

        vPassWord := InputBox('Folha de Ponto Violada', #9'Digite a Palavra-Chave', '');
      end;

      memHistHorario.Lines.LoadFromFile(dtmPrincipal.CarregarArquivo.FileName);
      BuscarValoresDadosFuncionario;
      BuscarValoresHorariosRegEx;
      frmDadosFuncionarioedtJornadaSemanalExit(nil);
      AnalizarHorariosAlteradosSemana;
    end;

    memHistHorario.FocarCabecalho;
    frmDadosFuncionarioedtJornadaSemanalExit(nil);
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('Houve uma inconsistencia no sistema, verifique:' + sLineBreak + E.Message),
        'Atenção', MB_OKCANCEL + MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmPrincipal.CarregarHistorico;
begin
  if not NovoRegistro then
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

procedure TfrmPrincipal.AdicionarHashMemo;
//var
//  lPontoSemanal: TFolhaPontoSemanalSingleton;
//  lSegunda, lTerca, lQuarta, lQuinta, lSexta, lSabado: string;
begin
//  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;
//
//  lSegunda := ConcatenarHorarios(lPontoSemanal.Segunda);
//  lTerca := ConcatenarHorarios(lPontoSemanal.Terca);
//  lQuarta := ConcatenarHorarios(lPontoSemanal.Quarta);
//  lQuinta := ConcatenarHorarios(lPontoSemanal.Quinta);
//  lSexta := ConcatenarHorarios(lPontoSemanal.Sexta);
//  lSabado := ConcatenarHorarios(lPontoSemanal.Sabado);
//
//  memHistHorario.Lines.Add('');
//  memHistHorario.Lines.Add('');
//  memHistHorario.Lines.Add('');
//  memHistHorario.Lines.Add('[Folha]: ' + TStringHelpers.HashMD5(memHistHorario.Text, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Segunda]: ' + TStringHelpers.HashMD5(lSegunda, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Terca]: ' + TStringHelpers.HashMD5(lTerca, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Quarta]: ' + TStringHelpers.HashMD5(lQuarta, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Quinta]: ' + TStringHelpers.HashMD5(lQuinta, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Sexta]: ' + TStringHelpers.HashMD5(lSexta, TConstantes.HASH_SALTING));
//  memHistHorario.Lines.Add('[Sabado]: ' + TStringHelpers.HashMD5(lSabado, TConstantes.HASH_SALTING));

//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Segunda);
//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Terca);
//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Quarta);
//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Quinta);
//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Sexta);
//  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Sabado);
end;

procedure TfrmPrincipal.AnalizarDiaDaSemanaAlterado(pDiaSemana: THorariosDia);
var
  lNomeDia, lHashDiaAtual: string;
begin
  lNomeDia := pDiaSemana.PegarNomeDaSemana;
  lHashDiaAtual := ConcatenarHorarios(pDiaSemana);
  lHashDiaAtual := TStringHelpers.HashMD5(lHashDiaAtual);

  if RetornarHashDentroArquivo('[' + lNomeDia + ']') <> lHashDiaAtual then
  begin
    DestacarHorariosAlterados(pDiaSemana, lNomeDia);
  end;
end;

procedure TfrmPrincipal.DestacarHorariosAlterados(pHorarios: THorariosDia; pDia: string);
var
  lHashArquivo, lHashAtual: array[0..3] of string;
  lFrame: TfrmHorariosDia;
begin
  lHashArquivo[0] := RetornarHashDentroArquivo('[' + pDia + '-Entrada]');
  lHashArquivo[1] := RetornarHashDentroArquivo('[' + pDia + '-SaidaAlmoco]');
  lHashArquivo[2] := RetornarHashDentroArquivo('[' + pDia + '-RetornoAlmoco]');
  lHashArquivo[3] := RetornarHashDentroArquivo('[' + pDia + '-SaidaFinal]');

  lHashAtual[0] := TStringHelpers.HashMD5(pHorarios.Entrada);
  lHashAtual[1] := TStringHelpers.HashMD5(pHorarios.SaidaAlmoco);
  lHashAtual[2] := TStringHelpers.HashMD5(pHorarios.RetornoAlmoco);
  lHashAtual[3] := TStringHelpers.HashMD5(pHorarios.SaidaFinal);

  lFrame := RetornarFrameDia(pHorarios.Tag);

  if TStringHelpers.VerificarDiferenca(lHashArquivo[0], lHashAtual[0]) then
  begin
    lFrame.AlterarEditHorarioViolado(rhEntrada);
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[3], lHashAtual[3]) then
  begin
    lFrame.AlterarEditHorarioViolado(rhSaidaFinal);
  end;

  if lFrame = frmSabado then
  begin
    Exit;
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[1], lHashAtual[1]) then
  begin
    lFrame.AlterarEditHorarioViolado(rhSaidaAlmoco);
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[2], lHashAtual[2]) then
  begin
    lFrame.AlterarEditHorarioViolado(rhRetornoAlmoco);
  end;
end;

procedure TfrmPrincipal.AnalizarHorariosAlteradosSemana;
var
  lPontoSemanal: TFolhaPontoSemanalSingleton;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Segunda);
  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Terca);
  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Quarta);
  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Quinta);
  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Sexta);
  AnalizarDiaDaSemanaAlterado(lPontoSemanal.Sabado);
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

function TfrmPrincipal.NovoRegistro: Boolean;
var
  lPossuiValoresPreenchidos: Boolean;
begin
  lPossuiValoresPreenchidos := VerificarPossuiValoresPreenchidos;

  if lPossuiValoresPreenchidos and (Application.MessageBox('Ainda existem valores anotados na Folha de Ponto, ' +
    'ao criar um novo registro os dados serão sobrescritos.' + sLineBreak + sLineBreak + '> Deseja realmente ' +
    'criar um novo registro?', 'ATENÇÃO', MB_YESNO + MB_ICONWARNING) = ID_NO) then
  begin
    Exit(False);
  end;

  LimparFormulario;
  TComponenteHelpers.Focar(frmDadosFuncionario.edtCodigo);
  Result := True
end;

procedure TfrmPrincipal.PreencherDadosNoMemo;
var
  lDiretor: TDiretor;
  lConstrutor: IConstrutor;
  lFolhaDePonto: TStringList;

  lPontoSemanal: TFolhaPontoSemanalSingleton;
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













  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

//  memHistHorario.Clear;
//  memHistHorario.Lines.Add(' =====================================');
//  memHistHorario.Lines.Add(' Registro de Ponto Semanal - Histórico');
//  memHistHorario.Lines.Add(' =====================================');
//  memHistHorario.Lines.Add(' ');
//  memHistHorario.Lines.Add(' Código...........: ' + lPontoSemanal.ID);
//  memHistHorario.Lines.Add(' Funcionário......: ' + lPontoSemanal.Nome);
//  memHistHorario.Lines.Add(' Admissão.........: ' + lPontoSemanal.DataAdmissao + ' ' + lPontoSemanal.TempoAdmissao);
//  memHistHorario.Lines.Add(' Jornada Semanal..: ' + lPontoSemanal.JornadaSemanal + ' horas');
//  memHistHorario.Lines.Add(' Intervalo Almoço.: ' + lPontoSemanal.IntervaloAlmoco + ' -> ' + frmDadosFuncionario.lblTempoExtenso.Caption);
//  memHistHorario.Lines.Add(' ');
//  memHistHorario.Lines.Add('  ______________________________________________________________________________________');
//  memHistHorario.Lines.Add(' /                |         |              |                |             |             \ ');
//  memHistHorario.Lines.Add(' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ');
//  memHistHorario.Lines.Add(' |                |         |              |                |             |             | ');
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Segunda);
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Terca);
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Quarta);
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Quinta);
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Sexta);
//  PreencherDadosNoMemoLinha;
//  PreencherDadosNoMemoDiaSemana(lPontoSemanal.Sabado);
//  PreencherDadosNoMemoLinha;
//  memHistHorario.Lines.Add(' |                                                                                      | ');
//  PreencherDadosNoMemoRodape;
//  memHistHorario.Lines.Add(' |                                                                                      | ');
//  memHistHorario.Lines.Add(' \______________________________________________________________________________________/');
end;

procedure TfrmPrincipal.PreencherDadosNoMemoDiaSemana(pDia: THorariosDia);
var
  lDiaNome, lSaidaAlmoco, lRetornoAlmoco, lHorariosNoMemo: string;
begin
  lDiaNome := pDia.PegarNomeDaSemana(True, True);

  lSaidaAlmoco := IfThen(pDia.SaidaAlmoco.Trim = EmptyStr, '00:00', pDia.SaidaAlmoco);
  lRetornoAlmoco := IfThen(pDia.RetornoAlmoco.Trim = EmptyStr, '00:00', pDia.RetornoAlmoco);

  if pDia.Tag = dsSabado then
  begin
    lSaidaAlmoco := '  -  ' ;
    lRetornoAlmoco := '  -  ';
  end;

  lSaidaAlmoco := lSaidaAlmoco.PadRight(10, ' ').PadLeft(14, ' ');
  lRetornoAlmoco := lRetornoAlmoco.PadRight(11, ' ').PadLeft(16, ' ');

  lHorariosNoMemo := lDiaNome.PadRight(15, ' ') + '|   ' + pDia.Entrada + ' |' + lSaidaAlmoco + '|' + lRetornoAlmoco +
    '|    ' + pDia.SaidaFinal + '    |    ' + pDia.Desempenho.TotalTrabalhado;

  memHistHorario.Lines.Add(' | ' + lHorariosNoMemo + '    | ');
end;

procedure TfrmPrincipal.PreencherDadosNoMemoHashHorarios(pDia: THorariosDia);
var
  lDia, lHashEntrada, lHashSaidaAlmoco, lHashRetornoAlmoco, lHashSaidaFinal: string;
begin
  lDia := pDia.PegarNomeDaSemana;

  lHashEntrada := TStringHelpers.HashMD5(pDia.Entrada);
  lHashSaidaAlmoco := TStringHelpers.HashMD5(pDia.SaidaAlmoco);
  lHashRetornoAlmoco := TStringHelpers.HashMD5(pDia.RetornoAlmoco);
  lHashSaidaFinal := TStringHelpers.HashMD5(pDia.SaidaFinal);

  memHistHorario.Lines.Add('[' + lDia + '-Entrada]: ' + lHashEntrada);

  if not (pDia.SaidaAlmoco.Trim = EmptyStr) and not (pDia.RetornoAlmoco.Trim = EmptyStr) then
  begin
    memHistHorario.Lines.Add('[' + lDia + '-SaidaAlmoco]: ' + lHashSaidaAlmoco);
    memHistHorario.Lines.Add('[' + lDia + '-RetornoAlmoco]: ' + lHashRetornoAlmoco);
  end;

  memHistHorario.Lines.Add('[' + lDia + '-SaidaFinal]: ' + lHashSaidaFinal);
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
  Tedit(pEdit).OnExit(pEdit);
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

function TfrmPrincipal.RetornarHashDentroArquivo(pPalavraChave: string): string;
begin
  for var I := 0 to Pred(memHistHorario.Lines.Count) do
  begin
    Result := memHistHorario.Lines[I];

    if not Result.Contains(pPalavraChave) then
    begin
      Continue;
    end;

    Result := Copy(Result, Pos(':', Result) + 1, Length(Result)).Trim;
    Break;
  end;
end;

procedure TfrmPrincipal.Salvar;
begin
  PreencherDadosNoMemo;
  AdicionarHashMemo;
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
  I := 0;
  lHashArquivo := RetornarHashDentroArquivo('[Folha]');

  while I < 30 do
  begin
    memHistHorario.Lines.Delete(memHistHorario.Lines.Count - 1);
    Inc(I);
  end;
  memHistHorario.FocarCabecalho;

  lHashAtual := TStringHelpers.HashMD5(memHistHorario.Text);
  Result := TStringHelpers.VerificarDiferenca(lHashArquivo, lHashAtual);
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
