unit PontoSemanal.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, PontoSemanal.Frames.DadosFuncionario, Vcl.Mask, PontoSemanal.Frames.HorarioDiaUtil,
  PontoSemanal.Frames.SaldoHorasDia, PontoSemanal.Helpers.TiposAuxiliares, System.Classes, System.ImageList,
  Vcl.ImgList, PontoSemanal.DataModules.Principal, System.RegularExpressions,
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
    procedure btnCarregarHistClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarHorarioSistema;
    procedure ConfigurarObservadores;
    procedure AplicarTagFrame(pFrame: TfrmHorariosDia; pTag: TDiaSemana);
    procedure NovoRegistro;
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
    procedure FocarTituloMemo;
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

    const REGEX_HORARIOS = '(Segunda|Terça|Quarta|Sexta|Quinta)\D{0,}?\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0' +
      '-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,' +
      '}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])|(Sábado|Sabado)\D{0,' +
      '}?\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])';
    const REGEX_CODIGO_FUNCIONARIO = '(Código|Codigo)\W{0,}(\d{0,7})';
    const REGEX_NOME_FUNCIONARIO = '(Funcionário|Funcionario)\W{0,}(.*)\R';
    const REGEX_ADMISSAO_FUNCIONARIO = '(Admissão|Admissao)\W{0,}(\d{2}[\/]\d{2}[\/]\d{4})';
    const REGEX_JORNADA_FUNCIONARIO = '(Jornada\sSemanal)\W{0,}(\d{0,3})';
    const REGEX_INTERVALO_FUNCIONARIO = '(Intervalo\sAlmoço)\W{0,}(\d[\:]\d{2})';
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

procedure TfrmPrincipal.FocarTituloMemo;
begin
  memHistHorario.SelStart := 1;
  memHistHorario.SelLength := 1;
end;

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
  vNomeFuncionario: string;
begin
  lPontoSemanal := TFolhaPontoSemanalSingleton.ObterInstancia;

  try

    vNomeFuncionario := lPontoSemanal.ID + '_' + StringReplace(lPontoSemanal.Nome, ' ', '_', [rfReplaceAll]) + '.txt';
    dtmPrincipal.SalvarArquivo.FileName := vNomeFuncionario;
    FocarTituloMemo;

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
  PreencherValoresDadosFuncionario(REGEX_CODIGO_FUNCIONARIO, frmDadosFuncionario.edtCodigo);
  PreencherValoresDadosFuncionario(REGEX_NOME_FUNCIONARIO, frmDadosFuncionario.edtNome);
  PreencherValoresDadosFuncionario(REGEX_ADMISSAO_FUNCIONARIO, frmDadosFuncionario.edtAdmissao);
  PreencherValoresDadosFuncionario(REGEX_JORNADA_FUNCIONARIO, frmDadosFuncionario.edtJornadaSemanal);
  PreencherValoresDadosFuncionario(REGEX_INTERVALO_FUNCIONARIO, frmDadosFuncionario.edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.BuscarValoresHorariosRegEx;
var
  lDiaSemana: string;
  lMatches: TMatchCollection;
begin
  lMatches := TRegex.Matches(memHistHorario.Text, REGEX_HORARIOS, [roIgnoreCase]);

  for var vMatch in lMatches do
  begin
    for var vGroup in vMatch.Groups do
    begin
      lDiaSemana := Copy(vGroup.Value.Trim, 1, 3);
      lDiaSemana := StringReplace(lDiaSemana, 'á', 'a', [rfReplaceAll]);

      case TDiaSemana(IndexStr(lDiaSemana, ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'])) of
        dsSegunda: frmSegunda.PreencherValoresHorarios(vGroup, vMatch.Groups);
        dsTerca: frmTerca.PreencherValoresHorarios(vGroup, vMatch.Groups);
        dsQuarta: frmQuarta.PreencherValoresHorarios(vGroup, vMatch.Groups);
        dsQuinta: frmQuinta.PreencherValoresHorarios(vGroup, vMatch.Groups);
        dsSexta: frmSexta.PreencherValoresHorarios(vGroup, vMatch.Groups);
        dsSabado: frmSabado.PreencherValoresHorarios(vGroup, vMatch.Groups);
      end;
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

    if not TRegex.IsMatch(memHistHorario.Text, REGEX_HORARIOS, [roIgnoreCase]) then
    begin
      memHistHorario.Clear;
      Application.MessageBox('> Folha de Ponto inválida <' + sLineBreak + 'O Arquivo escolhido não possui nenhum horário',
        'Atenção', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    BuscarValoresHorariosRegEx;
    BuscarValoresDadosFuncionario;

    if VerificarViolacaoFolhaDePonto then
    begin
      LimparFormulario;
      memHistHorario.Clear;

      var vPassWord: string;
      vPassWord := InputBox('Folha de Ponto Violada', #9'Digite a Palavra-Chave', '');

      while vPassWord <> 'gansodeterno' do
      begin

        if TStringHelpers.VerificarCampoVazio(vPassWord) then
        begin
          Exit;
        end;

        if Application.MessageBox('> Senha Incorreta <' + sLineBreak + 'A senha inserida está inválida', 'Atenção',
          MB_OKCANCEL + MB_ICONWARNING) = ID_CANCEL then
        begin
          Exit;
        end;
      end;

//      if (vPassWord <> 'gansodeterno') then
//      begin
//        Application.MessageBox('A senha inserida está inválida', 'Senha Incorreta', MB_OK + MB_ICONWARNING);
//        CarregarFolhaDePontoArquivo;
//        Exit;
//      end;

      memHistHorario.Lines.LoadFromFile(dtmPrincipal.CarregarArquivo.FileName);
      BuscarValoresHorariosRegEx;
      BuscarValoresDadosFuncionario;
//      ChamarEventoSairDadosFuncionario;

      AnalizarHorariosAlteradosSemana;
    end;

    FocarTituloMemo;
//    ChamarEventoSairDadosFuncionario;
  except
    on E: Exception do
    begin
//      MandarMensagemFalhaDesconhecida('Não foi possivel carregar completamente seu arquivo', edtCodigo);
    end;
  end;
end;

procedure TfrmPrincipal.CarregarHistorico;
begin
  NovoRegistro;
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

  memHistHorario.Lines.Add('');
  memHistHorario.Lines.Add('');
  memHistHorario.Lines.Add('');
  memHistHorario.Lines.Add('[Folha]: ' + TStringHelpers.HashMD5(memHistHorario.Text, HASH_SALTING));
  memHistHorario.Lines.Add('[Segunda]: ' + TStringHelpers.HashMD5(lSegunda, HASH_SALTING));
  memHistHorario.Lines.Add('[Terca]: ' + TStringHelpers.HashMD5(lTerca, HASH_SALTING));
  memHistHorario.Lines.Add('[Quarta]: ' + TStringHelpers.HashMD5(lQuarta, HASH_SALTING));
  memHistHorario.Lines.Add('[Quinta]: ' + TStringHelpers.HashMD5(lQuinta, HASH_SALTING));
  memHistHorario.Lines.Add('[Sexta]: ' + TStringHelpers.HashMD5(lSexta, HASH_SALTING));
  memHistHorario.Lines.Add('[Sabado]: ' + TStringHelpers.HashMD5(lSabado, HASH_SALTING));

  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Segunda);
  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Terca);
  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Quarta);
  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Quinta);
  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Sexta);
  PreencherDadosNoMemoHashHorarios(lPontoSemanal.Sabado);
end;

procedure TfrmPrincipal.AnalizarDiaDaSemanaAlterado(pDiaSemana: THorariosDia);
var
  lNomeDia, vHashDiaAtual: string;
begin
  case pDiaSemana.Tag of
    dsSegunda: lNomeDia := 'Segunda';
    dsTerca: lNomeDia := 'Terca';
    dsQuarta: lNomeDia := 'Quarta';
    dsQuinta: lNomeDia := 'Quinta';
    dsSexta: lNomeDia := 'Sexta';
    dsSabado: lNomeDia := 'Sabado';
  end;

  vHashDiaAtual := ConcatenarHorarios(pDiaSemana);
  vHashDiaAtual := TStringHelpers.HashMD5(vHashDiaAtual, HASH_SALTING);

  if RetornarHashDentroArquivo('[' + lNomeDia + ']') <> vHashDiaAtual then
  begin
    DestacarHorariosAlterados(pDiaSemana, lNomeDia);
  end;
end;

procedure TfrmPrincipal.DestacarHorariosAlterados(pHorarios: THorariosDia; pDia: string);
var
  lMaskEdit: TMaskEdit;
  lHashArquivo, lHashAtual: array[0..3] of string;
  lCopy: string;
begin
  lCopy := Copy(pDia, 1, 3);

  lHashArquivo[0] := RetornarHashDentroArquivo('[' + pDia + '-Entrada]');
  lHashArquivo[1] := RetornarHashDentroArquivo('[' + pDia + '-SaidaAlmoco]');
  lHashArquivo[2] := RetornarHashDentroArquivo('[' + pDia + '-RetornoAlmoco]');
  lHashArquivo[3] := RetornarHashDentroArquivo('[' + pDia + '-SaidaFinal]');

  lHashAtual[0] := TStringHelpers.HashMD5(pHorarios.Entrada, HASH_SALTING);
  lHashAtual[1] := TStringHelpers.HashMD5(pHorarios.SaidaAlmoco, HASH_SALTING);
  lHashAtual[2] := TStringHelpers.HashMD5(pHorarios.RetornoAlmoco, HASH_SALTING);
  lHashAtual[3] := TStringHelpers.HashMD5(pHorarios.SaidaFinal, HASH_SALTING);

  if TStringHelpers.VerificarDiferenca(lHashArquivo[0], lHashAtual[0]) then
  begin
    lMaskEdit := TMaskEdit(FindComponent('med' + lCopy + 'Entrada'));
    lMaskEdit.Color := clSkyBlue;
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[3], lHashAtual[3]) then
  begin
    lMaskEdit := TMaskEdit(FindComponent('med' + lCopy + 'SaidaFinal'));
    lMaskEdit.Color := clSkyBlue;
  end;

  if pDia = 'Sabado' then
  begin
    Exit;
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[1], lHashAtual[1]) then
  begin
    lMaskEdit := TMaskEdit(FindComponent('med' + lCopy + 'SaidaAlmoco'));
    lMaskEdit.Color := clSkyBlue;
  end;

  if TStringHelpers.VerificarDiferenca(lHashArquivo[2], lHashAtual[2]) then
  begin
    lMaskEdit := TMaskEdit(FindComponent('med' + lCopy + 'RetornoAlmoco'));
    lMaskEdit.Color := clSkyBlue;
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

procedure TfrmPrincipal.PreencherDadosNoMemoHashHorarios(pDia: THorariosDia);
var
  lDia, lHashEntrada, lHashSaidaAlmoco, lHashRetornoAlmoco, lHashSaidaFinal: string;
begin
  case pDia.Tag of
    dsSegunda: lDia := 'Segunda';
    dsTerca: lDia := 'Terca';
    dsQuarta: lDia := 'Quarta';
    dsQuinta: lDia := 'Quinta';
    dsSexta: lDia := 'Sexta';
    dsSabado: lDia := 'Sabado';
  end;

  lHashEntrada := TStringHelpers.HashMD5(pDia.Entrada, HASH_SALTING);
  lHashSaidaAlmoco := TStringHelpers.HashMD5(pDia.SaidaAlmoco, HASH_SALTING);
  lHashRetornoAlmoco := TStringHelpers.HashMD5(pDia.RetornoAlmoco, HASH_SALTING);
  lHashSaidaFinal := TStringHelpers.HashMD5(pDia.SaidaFinal, HASH_SALTING);

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

  while I < 29 do
  begin
    memHistHorario.Lines.Delete(memHistHorario.Lines.Count-1);
    Inc(I);
  end;
  FocarTituloMemo;

  lHashAtual := TStringHelpers.HashMD5(memHistHorario.Text, HASH_SALTING);
  Result := TStringHelpers.VerificarDiferenca(lHashArquivo, lHashAtual);
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  AtualizarHorarioSistema;
end;

end.
