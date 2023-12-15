unit Exercicio05.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, System.StrUtils, Exercicio05.Classes.Horarios, System.SysUtils,
  System.RegularExpressions, System.IniFiles, System.TypInfo;

type
  TfrmPrincipal = class(TForm)
    gbxDadosFuncionario: TGroupBox;
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblAdmissao: TLabel;
    lblJornadaSemanal: TLabel;
    lblIntervaloAlmoco: TLabel;
    lblAnosMesesSemanasDias: TLabel;
    lblHoras: TLabel;
    lblTempoExtenso: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtAdmissao: TEdit;
    edtJornadaSemanal: TEdit;
    edtIntervaloAlmoco: TEdit;
    stbDataHoraSistema: TStatusBar;
    gbxHorasTrabalhadas: TGroupBox;
    lblHoraTrabRosto: TLabel;
    lblHoraTrabDesemp: TLabel;
    edtTotalHoraTrab: TEdit;
    edtHoraDifTrab: TEdit;
    gbxSeg: TGroupBox;
    lblSegEntrada: TLabel;
    lblSegSaidaAlmoco: TLabel;
    lblSegRetornoAlmoco: TLabel;
    lblSegSaidaFinal: TLabel;
    lblSegTotalHora: TLabel;
    lblSegDesempenho: TLabel;
    medtSegEntrada: TMaskEdit;
    medtSegSaidaAlmoco: TMaskEdit;
    medtSegRetornoAlmoco: TMaskEdit;
    medtSegSaidaFinal: TMaskEdit;
    edtSegTotalHora: TEdit;
    edtSegHoraDif: TEdit;
    gbxTer: TGroupBox;
    lblTerEntrada: TLabel;
    lblTerSaidaAlmoco: TLabel;
    lblTerRetornoAlmoco: TLabel;
    lblTerSaidaFinal: TLabel;
    lblTerTotalHora: TLabel;
    lblTerDesempenho: TLabel;
    medtTerEntrada: TMaskEdit;
    medtTerSaidaAlmoco: TMaskEdit;
    medtTerRetornoAlmoco: TMaskEdit;
    medtTerSaidaFinal: TMaskEdit;
    edtTerTotalHora: TEdit;
    edtTerHoraDif: TEdit;
    gbxQua: TGroupBox;
    lblQuaEntrada: TLabel;
    lblQuaSaidaAlmoco: TLabel;
    lblQuaRetornoAlmoco: TLabel;
    lblQuaSaidaFinal: TLabel;
    lblQuaTotalHora: TLabel;
    lblQuaDesempenho: TLabel;
    medtQuaEntrada: TMaskEdit;
    medtQuaSaidaAlmoco: TMaskEdit;
    medtQuaRetornoAlmoco: TMaskEdit;
    medtQuaSaidaFinal: TMaskEdit;
    edtQuaTotalHora: TEdit;
    edtQuaHoraDif: TEdit;
    gbxQui: TGroupBox;
    lblQuiEntrada: TLabel;
    lblQuiSaidaAlmoco: TLabel;
    lblQuiRetornoAlmoco: TLabel;
    lblQuiSaidaFinal: TLabel;
    lblQuiTotalHora: TLabel;
    lblQuiDesempenho: TLabel;
    medtQuiEntrada: TMaskEdit;
    medtQuiSaidaAlmoco: TMaskEdit;
    medtQuiRetornoAlmoco: TMaskEdit;
    medtQuiSaidaFinal: TMaskEdit;
    edtQuiTotalHora: TEdit;
    edtQuiHoraDif: TEdit;
    gbxSex: TGroupBox;
    lblSexEntrada: TLabel;
    lblSexSaidaAlmoco: TLabel;
    lblSexRetornoAlmoco: TLabel;
    lblSexSaidaFinal: TLabel;
    lblSexTotalHora: TLabel;
    lblSexDesempenho: TLabel;
    medtSexEntrada: TMaskEdit;
    medtSexSaidaAlmoco: TMaskEdit;
    medtSexRetornoAlmoco: TMaskEdit;
    medtSexSaidaFinal: TMaskEdit;
    edtSexTotalHora: TEdit;
    edtSexHoraDif: TEdit;
    gbxSab: TGroupBox;
    lblSabEntrada: TLabel;
    lblSabSaidaFinal: TLabel;
    lblSabTotalHora: TLabel;
    lblSabDesempenho: TLabel;
    medtSabEntrada: TMaskEdit;
    medtSabSaidaFinal: TMaskEdit;
    edtSabTotalHora: TEdit;
    edtSabHoraDif: TEdit;
    memHistHorario: TMemo;
    btnGerSalHist: TButton;
    btnCarregarHist: TButton;
    btnNovoRegistro: TButton;
    TimerSistema: TTimer;
    ImagensBotão: TImageList;
    svdSalvarMemo: TSaveDialog;
    opdCarregarTxt: TOpenDialog;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtAdmissaoChange(Sender: TObject);
    procedure edtJornadaSemanalChange(Sender: TObject);
    procedure edtIntervaloAlmocoChange(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtAdmissaoExit(Sender: TObject);
    procedure edtIntervaloAlmocoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure medtSegEntradaExit(Sender: TObject);
    procedure medtSegSaidaAlmocoExit(Sender: TObject);
    procedure medtSegRetornoAlmocoExit(Sender: TObject);
    procedure medtSegSaidaFinalExit(Sender: TObject);
    procedure medtTerEntradaExit(Sender: TObject);
    procedure medtTerSaidaAlmocoExit(Sender: TObject);
    procedure medtTerRetornoAlmocoExit(Sender: TObject);
    procedure medtTerSaidaFinalExit(Sender: TObject);
    procedure medtQuaEntradaExit(Sender: TObject);
    procedure medtQuaSaidaAlmocoExit(Sender: TObject);
    procedure medtQuaRetornoAlmocoExit(Sender: TObject);
    procedure medtQuaSaidaFinalExit(Sender: TObject);
    procedure medtQuiEntradaExit(Sender: TObject);
    procedure medtQuiSaidaAlmocoExit(Sender: TObject);
    procedure medtQuiRetornoAlmocoExit(Sender: TObject);
    procedure medtQuiSaidaFinalExit(Sender: TObject);
    procedure medtSexEntradaExit(Sender: TObject);
    procedure medtSexSaidaAlmocoExit(Sender: TObject);
    procedure medtSexRetornoAlmocoExit(Sender: TObject);
    procedure medtSexSaidaFinalExit(Sender: TObject);
    procedure medtSabEntradaExit(Sender: TObject);
    procedure medtSabSaidaFinalExit(Sender: TObject);
    procedure edtJornadaSemanalExit(Sender: TObject);
    procedure TimerSistemaTimer(Sender: TObject);
    procedure btnGerSalHistClick(Sender: TObject);
    procedure btnCarregarHistClick(Sender: TObject);
    procedure btnNovoRegistroClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FPontoSemanal: TPontoSemanal;
    function GetSegunda: THorarioDiaUtil;
    function GetQuarta: THorarioDiaUtil;
    function GetQuinta: THorarioDiaUtil;
    function GetSabado: THorarioSabado;
    function GetSexta: THorarioDiaUtil;
    function GetTerca: THorarioDiaUtil;
    property Segunda: THorarioDiaUtil read GetSegunda;
    property Terca: THorarioDiaUtil read GetTerca;
    property Quarta: THorarioDiaUtil read GetQuarta;
    property Quinta: THorarioDiaUtil read GetQuinta;
    property Sexta: THorarioDiaUtil read GetSexta;
    property Sabado: THorarioSabado read GetSabado;

    procedure PermitirSomenteNumeros(const pEdit: TCustomEdit);
    procedure FocarCampo(const pEdit: TCustomEdit);
    procedure MandarMensagemDataInvalida(pMotivo: string; pEditAtual: TCustomEdit);
    procedure MandarMensagemFalhaDesconhecida(pInformacao: string; pEditAtual: TCustomEdit);
    procedure MandarMensagemHorarioInvalido(pMotivo: string; pEditAtual: TCustomEdit);
    procedure MandarMensagemExtensaoDoArquivoInvalido(pInformacao: string);
    procedure CalcularTempoRegistroAdmissao;
    procedure EscreverIntervaloAlmocoExtenso;
    procedure AtualizarComponentesTotalDeHorasSemanal;
    procedure AplicarCorComponentesTotalDeHorasSemanal(pCor: TColor);
    procedure AtualizarValoresTotalDeHorasSemana(pDia: THorarioBase; pGroupBox: TGroupBox; pCargaHoraria: Integer);
    procedure AtualizarComponentesTotalHoras(vDiaSemana: THorarioBase; vHoraDif, vTotalHora: string; vLabel: TLabel;
      vEditHoraDif, vEditTotalHora: TEdit);
    procedure InserirJornadaSemanal;
    procedure PassarPelosMaskEdit;
    procedure PassarPeloDadosFuncionario;
    procedure TratarExceptionsDiaUtil(pException: Exception; pEditSaidaAlmoco, pEditRetornoAlmoco,
      pEditAtual: TCustomEdit; pDia: THorarioDiaUtil);
//    procedure TratarExceptionsSabado(pException: Exception; pEditAtual: TCustomEdit);
    procedure TratarExceptions(pE: Exception; pHorario: THorarioDiaUtil; pEditAtual: TCustomEdit);
    procedure TratarExceptionsHorarioAlmoco(pEClass: TClass; pGroupBoxName: string; pHorario: THorarioDiaUtil);
    procedure GerarHistorico;
    procedure CarregarHistorico;
    procedure PreencherMemoPontoSemanal;
    procedure PreencherMemoCadaDiaSemana(pDia: THorarioDiaUtil; pNomeDiaSemana: string);
    procedure PreencherMemoSabado;
    procedure PreencherMemoRodape;
    procedure PreencherMaskEditsHorarios(pGroup: TGroup; pGroupCollection: TGroupCollection);
    procedure SalvarFolhaDePontoArquivo;
    procedure CarregarFolhaDePontoArquivo;
    procedure BuscarValoresRegExHorarios;
    procedure PreencherDadosFuncionario;
    procedure VerificarDadosFuncionarioRegEx(pRegex: string; pEdit: TCustomEdit);
    procedure LimparFormulario;
    procedure SetarCoresDefaultMaskEdits;
    procedure AdicionarHashArquivo;
    procedure AnalizarHorariosAlterados;
    procedure DestacarHorariosAlterados(pHorarios: THorarioDiaUtil; pDia: string);
    procedure AnalizarDiaDaSemanaAlterado(pDiaSemana: THorarioDiaUtil);
    procedure SairCampoGenerico(pDiaUtil: THorarioDiaUtil; pHora: string; pEdit: TCustomEdit);

    // Saida dos MaskEdit de cada Dia da Semana //
    procedure SairCampoSegunda(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
    procedure SairCampoTerca(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
    procedure SairCampoQuarta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
    procedure SairCampoQuinta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
    procedure SairCampoSexta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
    procedure SairCampoSabado(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);

    function VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
    function VerificarDataValida(pData: string): Boolean;
    function TratarPluralDataAdmissao(pAnos, pMeses, pSemanas, pDias: Integer): string;
    function TratarPluralIntervaloAlmoco(pHora, pMinuto: Integer): string;
    function VerificarGroupBoxVazio(pGroupBox: TGroupBox): Boolean;
    function RetornarNomeCustomEdit(pCustomEdit: TCustomEdit): string;
    function VerificarTodosCamposEstaoPreenchidos: Boolean;
    function VerificarTodosGroupBoxSemanaVazios: Boolean;
    function VerificarAlgumCampoPreenchido: Boolean;
    function MD5(pText: string; pSalting: Boolean): string;
    function VerificarFolhaDePontoViolada: Boolean;
    function CriptografarString(pString: string): string;
    function ProcurarHashDentroArquivo(pPalavraChave: string): string;

    const REGEX_HORARIOS = '(Segunda|Terça|Quarta|Sexta|Quinta)\D{0,}?\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0' +
      '-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,' +
      '}?([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])|(Sábado|Sabado)\D{0,' +
      '}?\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])\W{0,}([0,1][0-9]:[0-5][0-9]|[2][0-3]:[0-5][0-9])';

    const REGEX_CODIGO_FUNCIONARIO = '(Código|Codigo)\W{0,}(\d{0,7})';
    const REGEX_NOME_FUNCIONARIO = '(Funcionário|Funcionario)\W{0,}(.*)\R';
    const REGEX_ADMISSAO_FUNCIONARIO = '(Admissão|Admissao)\W{0,}(\d{2}[\/]\d{2}[\/]\d{4})';
    const REGEX_JORNADA_FUNCIONARIO = '(Jornada\sSemanal)\W{0,}(\d{0,3})';
    const REGEX_INTERVALO_FUNCIONARIO = '(Intervalo\sAlmoço)\W{0,}(\d[\:]\d{2})';
    const HASH_SALTING = 'Lucas;Souza;Frade';
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Exercicio05.Helpers.Funcoes, System.DateUtils, IdHashMessageDigest, IdHash, System.Hash;

{$R *.dfm}

procedure TfrmPrincipal.PassarPeloDadosFuncionario;
var
  vNomeEdit: string;
begin
  for var I := 0 to Pred(gbxDadosFuncionario.ControlCount) do
  begin
    if not (gbxDadosFuncionario.Controls[I] is TEdit) then
    begin
      Continue;
    end;

    vNomeEdit := gbxDadosFuncionario.Controls[I].Name;

    if not vNomeEdit.Contains('Nome') and not vNomeEdit.Contains('Codigo') then
    begin
      TEdit(gbxDadosFuncionario.Controls[I]).OnExit(gbxDadosFuncionario.Controls[I]);
    end;
  end;
end;

procedure TfrmPrincipal.PassarPelosMaskEdit;
begin
  for var I := 0 to Pred(ComponentCount) do
  begin
    if not (Components[I] is TMaskEdit) then
    begin
      Continue;
    end;

    TMaskEdit(Components[I]).OnExit(Components[I]);
  end;
end;

procedure TfrmPrincipal.PermitirSomenteNumeros(const pEdit: TCustomEdit);
begin
  pEdit.Text := Tfuncoes.SomenteNumeros(pEdit.Text);
end;

procedure TfrmPrincipal.PreencherDadosFuncionario;
begin
  VerificarDadosFuncionarioRegEx(REGEX_CODIGO_FUNCIONARIO, edtCodigo);
  VerificarDadosFuncionarioRegEx(REGEX_NOME_FUNCIONARIO, edtNome);
  VerificarDadosFuncionarioRegEx(REGEX_ADMISSAO_FUNCIONARIO, edtAdmissao);
  VerificarDadosFuncionarioRegEx(REGEX_JORNADA_FUNCIONARIO, edtJornadaSemanal);
  VerificarDadosFuncionarioRegEx(REGEX_INTERVALO_FUNCIONARIO, edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.PreencherMaskEditsHorarios(pGroup: TGroup; pGroupCollection: TGroupCollection);
var
  vEntrada, vSaidaAlmoco, vRetornoAlmoco, vSaidaFinal: TMaskEdit;
  vDiaSemana: string;
begin
  vDiaSemana := Copy(pGroup.Value.Trim, 1, 3);
  vDiaSemana := StringReplace(vDiaSemana, 'á', 'a', [rfReplaceAll]);

  if not MatchStr(vDiaSemana, ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab']) then
  begin
    Exit;
  end;

  vEntrada := TMaskEdit(FindComponent('medt' + vDiaSemana + 'Entrada'));
  vSaidaFinal := TMaskEdit(FindComponent('medt' + vDiaSemana + 'SaidaFinal'));

  if vDiaSemana <> 'Sab' then
  begin
    vSaidaAlmoco := TMaskEdit(FindComponent('medt' + vDiaSemana + 'SaidaAlmoco'));
    vRetornoAlmoco := TMaskEdit(FindComponent('medt' + vDiaSemana + 'RetornoAlmoco'));
  end else
  begin
    vEntrada.Text := pGroupCollection[7].Value;
    vSaidaFinal.Text := pGroupCollection[8].Value;
    Exit;
  end;

  vEntrada.Text := pGroupCollection[2].Value;
  vSaidaAlmoco.Text := pGroupCollection[3].Value;
  vRetornoAlmoco.Text := pGroupCollection[4].Value;
  vSaidaFinal.Text := pGroupCollection[5].Value;
end;

procedure TfrmPrincipal.PreencherMemoCadaDiaSemana(pDia: THorarioDiaUtil; pNomeDiaSemana: string);
begin
  memHistHorario.Lines.Add(' | ' + pNomeDiaSemana.PadRight(15, ' ') + '|  ' + pDia.Entrada + '  |    ' + pDia.SaidaAlmoco
    + '     |     ' + pDia.RetornoAlmoco + '      |    ' + pDia.SaidaFinal + '    |    ' +
    pDia.CargoHoras.TotalTrabalhadas + '    | ');
end;

procedure TfrmPrincipal.PreencherMemoPontoSemanal;
begin
  memHistHorario.Clear;
  memHistHorario.Lines.Add(' =====================================');
  memHistHorario.Lines.Add(' Registro de Ponto Semanal - Histórico');
  memHistHorario.Lines.Add(' =====================================');
  memHistHorario.Lines.Add(' ');
  memHistHorario.Lines.Add(' Código...........: ' + edtCodigo.Text);
  memHistHorario.Lines.Add(' Funcionário......: ' + edtNome.Text);
  memHistHorario.Lines.Add(' Admissão.........: ' + edtAdmissao.Text + ' ' + lblAnosMesesSemanasDias.Caption);
  memHistHorario.Lines.Add(' Jornada semanal..: ' + edtJornadaSemanal.Text + ' ' + lblHoras.Caption);
  memHistHorario.Lines.Add(' Intervalo almoço.: ' + edtIntervaloAlmoco.Text + ' -> ' + lblTempoExtenso.Caption);
  memHistHorario.Lines.Add(' ');
  memHistHorario.Lines.Add('  ______________________________________________________________________________________');
  memHistHorario.Lines.Add(' /                |         |              |                |             |             \ ');
  memHistHorario.Lines.Add(' | DIA DA SEMANA  | ENTRADA | SAÍDA ALMOÇO | RETORNO ALMOÇO | SAÍDA FINAL | TOTAL HORAS | ');
  memHistHorario.Lines.Add(' |                |         |              |                |             |             | ');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoCadaDiaSemana(Segunda, 'Segunda-Feira');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoCadaDiaSemana(Terca, 'Terça-Feira');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoCadaDiaSemana(Quarta, 'Quarta-Feira');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoCadaDiaSemana(Quinta, 'Quinta-Feira');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoCadaDiaSemana(Sexta, 'Sexta-Feira');
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  PreencherMemoSabado;
  memHistHorario.Lines.Add(' |----------------|---------|--------------|----------------|-------------|-------------| ');
  memHistHorario.Lines.Add(' |                                                                                      | ');
  PreencherMemoRodape;
  memHistHorario.Lines.Add(' |                                                                                      | ');
  memHistHorario.Lines.Add(' \______________________________________________________________________________________/');
  memHistHorario.Lines.Add('');
  memHistHorario.Lines.Add('');
  memHistHorario.Lines.Add('');
  AdicionarHashArquivo;
end;

procedure TfrmPrincipal.PreencherMemoSabado;
begin
  memHistHorario.Lines.Add(' | Sábado         |  ' + Sabado.Entrada + '  |      -       |       -        |    ' +
    Sabado.SaidaFinal + '    |    ' + Sabado.CargoHoras.TotalTrabalhadas + '    | ');
end;

function TfrmPrincipal.ProcurarHashDentroArquivo(pPalavraChave: string): string;
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

procedure TfrmPrincipal.SairCampoQuarta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Quarta.Entrada := medtQuaEntrada.Text;
      thSaidaAlmoco: Quarta.SaidaAlmoco := medtQuaSaidaAlmoco.Text;
      thRetornoAlmoco: Quarta.RetornoAlmoco := medtQuaRetornoAlmoco.Text;
      thSaidaFinal: Quarta.SaidaFinal := medtQuaSaidaFinal.Text;
    end;

    Quarta.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(Quarta, gbxQua, Quarta.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtQuaSaidaAlmoco, medtQuaRetornoAlmoco, pEdit, Quarta);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoQuinta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Quinta.Entrada := medtQuiEntrada.Text;
      thSaidaAlmoco: Quinta.SaidaAlmoco := medtQuiSaidaAlmoco.Text;
      thRetornoAlmoco: Quinta.RetornoAlmoco := medtQuiRetornoAlmoco.Text;
      thSaidaFinal: Quinta.SaidaFinal := medtQuiSaidaFinal.Text;
    end;

    Quinta.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(Quinta, gbxQui, Quinta.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtQuiSaidaAlmoco, medtQuiRetornoAlmoco, pEdit, Quinta);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoGenerico(pDiaUtil: THorarioDiaUtil; pHora: string; pEdit: TCustomEdit);
begin
  try
    pHora := pEdit.Text;
    pDiaUtil.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(pDiaUtil, TGroupBox(pEdit.Parent), pDiaUtil.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptions(E, pDiaUtil, pEdit);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoSabado(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Sabado.Entrada := medtSabEntrada.Text;
      thSaidaFinal: Sabado.SaidaFinal := medtSabSaidaFinal.Text;
    end;

    Sabado.CalcularHorasTrabalhadas;
    AtualizarValoresTotalDeHorasSemana(Sabado, gbxSab, Sabado.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptions(E, Sabado, pEdit);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoSegunda(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Segunda.Entrada := medtSegEntrada.Text;
      thSaidaAlmoco: Segunda.SaidaAlmoco := medtSegSaidaAlmoco.Text;
      thRetornoAlmoco: Segunda.RetornoAlmoco := medtSegRetornoAlmoco.Text;
      thSaidaFinal: Segunda.SaidaFinal := medtSegSaidaFinal.Text;
    end;

    Segunda.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(Segunda, gbxSeg, Segunda.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtSegSaidaAlmoco, medtSegRetornoAlmoco, pEdit, Segunda);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoSexta(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Sexta.Entrada := medtSexEntrada.Text;
      thSaidaAlmoco: Sexta.SaidaAlmoco := medtSexSaidaAlmoco.Text;
      thRetornoAlmoco: Sexta.RetornoAlmoco := medtSexRetornoAlmoco.Text;
      thSaidaFinal: Sexta.SaidaFinal := medtSexSaidaFinal.Text;
    end;

    Sexta.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(Sexta, gbxSex, Sexta.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtSexSaidaAlmoco, medtSexRetornoAlmoco, pEdit, Sexta);
    end;
  end;
end;

procedure TfrmPrincipal.SairCampoTerca(pHorarioDia: TTipoHorario; pEdit: TCustomEdit);
begin
  if VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := 44;
  end;

  try
    case pHorarioDia of
      thEntrada: Terca.Entrada := medtTerEntrada.Text;
      thSaidaAlmoco: Terca.SaidaAlmoco := medtTerSaidaAlmoco.Text;
      thRetornoAlmoco: Terca.RetornoAlmoco := medtTerRetornoAlmoco.Text;
      thSaidaFinal: Terca.SaidaFinal := medtTerSaidaFinal.Text;
    end;

    Terca.CalcularTotalDeHoras;
    AtualizarValoresTotalDeHorasSemana(Terca, gbxTer, Terca.JornadaDiaria);
    FPontoSemanal.CalcularHorasTotaisSemana;
    AtualizarComponentesTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtTerSaidaAlmoco, medtTerRetornoAlmoco, pEdit, Terca);
    end;
  end;
end;

procedure TfrmPrincipal.SalvarFolhaDePontoArquivo;
var
  vNomeFuncionario: string;
begin
  try
    vNomeFuncionario := edtCodigo.Text + '_' + StringReplace(edtNome.Text, ' ', '_', [rfReplaceAll]) + '.txt';
    svdSalvarMemo.FileName := vNomeFuncionario;
    memHistHorario.SelStart := 1;
    memHistHorario.SelLength := 1;

    if not svdSalvarMemo.Execute then
    begin
      Exit;
    end;

    if (ExtractFileExt(svdSalvarMemo.FileName) <> '.txt') and (ExtractFileExt(svdSalvarMemo.FileName) <> EmptyStr) then
    begin
      MandarMensagemExtensaoDoArquivoInvalido('não pode ser salvo, a extensão não é suportada (.txt)');
      Exit;
    end;

    if FileExists(svdSalvarMemo.FileName) then
    begin
      if Application.MessageBox('O Arquivo já existe. Deseja Substitui-lo?', 'Arquivo Existente', MB_YESNO +
        MB_ICONINFORMATION) = ID_NO then
      begin
        Application.MessageBox(pChar('Arquivo não foi salvo!'), 'Arquivo não Salvo', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
    end;

    memHistHorario.Lines.SaveToFile(svdSalvarMemo.FileName);
    Application.MessageBox('Arquivo foi salvo com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);

  except
    on E: Exception do
    begin
      Application.MessageBox('Houve uma falha inesperada, porfavor verifique se está tudo em coerência' +
        ' e tente novamente!', 'Falha não Prevista', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TfrmPrincipal.SetarCoresDefaultMaskEdits;
begin
  for var I := 0 to Pred(ComponentCount) do
  begin
    if not (Components[I] is TMaskEdit) then
    begin
      Continue;
    end;

    TMaskEdit(Components[I]).Color := clWhite;
  end;
end;

function TfrmPrincipal.VerificarTodosCamposEstaoPreenchidos: Boolean;
var
  vComponente: TComponent;
  vComponenteText: string;
begin
  Result := True;

  for var I := 0 to Pred(ComponentCount) do
  begin
    if not (Components[I] is TEdit) and not (Components[I] is TMaskEdit) then
    begin
      Continue;
    end;

    vComponente := Components[I];

    if TCustomEdit(Components[I]).ReadOnly then
    begin
      Continue;
    end;

    vComponenteText := TCustomEdit(vComponente).Text;
    vComponenteText := StringReplace(vComponenteText, '_', '', [rfReplaceAll]);

    if (vComponenteText.Trim = EmptyStr) or (vComponenteText.Trim = ':') then
    begin
      Application.MessageBox(pChar('Seu Campo: ' + RetornarNomeCustomEdit(TCustomEdit(vComponente)) +
        ', está vazio. Porfavor verifique'), 'Campo Vazio', MB_OK + MB_ICONINFORMATION);
      FocarCampo(TCustomEdit(vComponente));
      Result := False;
      Break;
    end;
  end;
end;

function TfrmPrincipal.VerificarTodosGroupBoxSemanaVazios: Boolean;
var
  vGroupBoxVazio: Integer;
begin
  Result := False;
  vGroupBoxVazio:= 0;

  for var I := 0 to Pred(ControlCount) do
  begin
    if not (Controls[I] is TGroupBox) then
    begin
      Continue;
    end;

    if (Controls[I] = gbxDadosFuncionario) or (Controls[I] = gbxHorasTrabalhadas) then
    begin
      Continue;
    end;

    if VerificarGroupBoxVazio(TGroupBox(Controls[I])) then
    begin
      vGroupBoxVazio := vGroupBoxVazio + 1;
    end;

    if vGroupBoxVazio = 6 then
    begin
      Result := True;
    end;
  end;
end;

procedure TfrmPrincipal.PreencherMemoRodape;
var
  vHorasTrabalhadas, vHorasAcumuladas: string;
begin
  vHorasTrabalhadas := FPontoSemanal.CargoHoras.TotalTrabalhadas;
  vHorasAcumuladas := FPontoSemanal.CargoHoras.SaldoDeHoras;
  vHorasAcumuladas :=  vHorasAcumuladas.PadRight(9, ' ');

  memHistHorario.Lines.Add(' |' + string('Total de horas trabalhadas na semana:    ').PadLeft(77, ' ') + vHorasTrabalhadas +
    '    | ');

  if FPontoSemanal.CargoHoras.Cumprimento = chAcima then
  begin
    memHistHorario.Lines.Add(' |' + string('Horas/minutos faltantes:      -      ').PadLeft(86, ' ') + '| ');
    memHistHorario.Lines.Add(' |' + string('Horas/minutos excedentes:    ').PadLeft(77, ' ') + vHorasAcumuladas + '| ');
  end else
  if FPontoSemanal.CargoHoras.Cumprimento = chAbaixo then
  begin
    memHistHorario.Lines.Add(' |' + string('Horas/minutos faltantes:    ').PadLeft(77, ' ') + vHorasAcumuladas + '| ');
    memHistHorario.Lines.Add(' |' + string('Horas/minutos excedentes:      -      ').PadLeft(86, ' ') + '| ');
  end else
  begin
    memHistHorario.Lines.Add(' |' + string('Horas/minutos faltantes:      -      ').PadLeft(86, ' ') + '| ');
    memHistHorario.Lines.Add(' |' + string('Horas/minutos excedentes:      -      ').PadLeft(86, ' ') + '| ');
  end;
end;

procedure TfrmPrincipal.AtualizarComponentesTotalHoras(vDiaSemana: THorarioBase; vHoraDif, vTotalHora: string;
  vLabel: TLabel; vEditHoraDif, vEditTotalHora: TEdit);
begin
  vEditHoraDif.Text := vHoraDif;
  vEditTotalHora.Text := vTotalHora;
  vLabel.Caption := 'ü';
  vLabel.Font.Color := clGreen;
  vEditHoraDif.Font.Color := clGreen;
  vEditTotalHora.Font.Color := clGreen;

  if vDiaSemana.CargoHoras.Cumprimento = chAcima then
  begin
    vLabel.Caption := 'é';
    vLabel.Font.Color := $ff0000;
    vEditHoraDif.Font.Color := $ff0000;
    vEditTotalHora.Font.Color := $ff0000;
  end
  else if vDiaSemana.CargoHoras.Cumprimento = chAbaixo then
  begin
    vLabel.Caption := 'ê';
    vLabel.Font.Color := $303497;
    vEditHoraDif.Font.Color := $303497;
    vEditTotalHora.Font.Color := $303497;
  end;
end;

function TfrmPrincipal.VerificarAlgumCampoPreenchido: Boolean;
var
  vTextComponent: string;
begin
  Result := False;

  for var I := 0 to Pred(ComponentCount) do
  begin
    if not (Components[I] is TCustomEdit) or (Components[I] is TMemo) then
    begin
      Continue;
    end;

    vTextComponent := string(TCustomEdit(Components[I]).Text).Trim;

    if (vTextComponent <> EmptyStr) and (vTextComponent <> ':') and (vTextComponent <> '__:__') then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TfrmPrincipal.VerificarCampoVazio(const pEdit: TCustomEdit): Boolean;
begin
  Result := pEdit.Text = EmptyStr;
end;

function TfrmPrincipal.VerificarDataValida(pData: string): Boolean;
begin
  Result := True;

  if pData.Length = 9 then
  begin
    Exit(False);
  end;

  try
    StrToDate(pData);

    if StrToDate(pData) > Now then
    begin
      MandarMensagemDataInvalida('está além do dia atual', edtAdmissao);
      Result := False;
    end;
  except
    on EConvertError do
    begin
      MandarMensagemDataInvalida('está incorreta', edtAdmissao);
      Result := False
    end;

    on Exception do
    begin
      MandarMensagemFalhaDesconhecida('Houve uma falha inesperada na data inserida', edtAdmissao);
      Result := False;
    end;
  end;
end;

function TfrmPrincipal.VerificarFolhaDePontoViolada: Boolean;
var
  vHashArquivo, vHashAtual: string;
  I: Integer;
begin
  Result := False;
  I := 0;

  vHashArquivo := ProcurarHashDentroArquivo('[Folha]');

  while I < 29 do
  begin
    memHistHorario.Lines.Delete(memHistHorario.Lines.Count-1);
    I := I + 1;
  end;

  memHistHorario.SelStart := 1;
  memHistHorario.SelLength := 1;

  vHashAtual := MD5(memHistHorario.Text, True);
  if vHashArquivo <> vHashAtual then
  begin
    Result := True;
  end;
end;

function TfrmPrincipal.VerificarGroupBoxVazio(pGroupBox: TGroupBox): Boolean;
var
  vEditsVazios: Integer;
begin
  Result := False;
  vEditsVazios := 0;

  for var I := 0 to Pred(pGroupBox.ControlCount) do
  begin
    if not (pGroupBox.Controls[I] is TMaskEdit) then
    begin
      Continue;
    end;

    if string(TMaskEdit(pGroupBox.Controls[I]).Text).Trim = ':' then
    begin
      vEditsVazios := vEditsVazios + 1;
    end;
  end;

  if (vEditsVazios = 4) or ((vEditsVazios = 2) and (pGroupBox = gbxSab)) then
  begin
    Result := True;
  end;
end;

procedure TfrmPrincipal.AdicionarHashArquivo;
var
  vSegunda, vTerca, vQuarta, vQuinta, vSexta, vSabado: string;
begin
  vSegunda := Segunda.Entrada + Segunda.SaidaAlmoco + Segunda.RetornoAlmoco + Segunda.SaidaFinal;
  vTerca := Terca.Entrada + Terca.SaidaAlmoco + Terca.RetornoAlmoco + Terca.SaidaFinal;
  vQuarta := Quarta.Entrada + Quarta.SaidaAlmoco + Quarta.RetornoAlmoco + Quarta.SaidaFinal;
  vQuinta := Quinta.Entrada + Quinta.SaidaAlmoco + Quinta.RetornoAlmoco + Quinta.SaidaFinal;
  vSexta := Sexta.Entrada + Sexta.SaidaAlmoco + Sexta.RetornoAlmoco + Sexta.SaidaFinal;
  vSabado := Sabado.Entrada + Sabado.SaidaFinal;

  memHistHorario.Lines.Add('[Folha]: ' + MD5(memHistHorario.Text, True));
  memHistHorario.Lines.Add('[Segunda]: ' + MD5(vSegunda, True));
  memHistHorario.Lines.Add('[Terca]: ' + MD5(vTerca, True));
  memHistHorario.Lines.Add('[Quarta]: ' + MD5(vQuarta, True));
  memHistHorario.Lines.Add('[Quinta]: ' + MD5(vQuinta, True));
  memHistHorario.Lines.Add('[Sexta]: ' + MD5(vSexta, True));
  memHistHorario.Lines.Add('[Sabado]: ' + MD5(vSabado, True));

  memHistHorario.Lines.Add('[Segunda-Entrada]: ' + MD5(Segunda.Entrada, True));
  memHistHorario.Lines.Add('[Segunda-SaidaAlmoco]: ' + MD5(Segunda.SaidaAlmoco, True));
  memHistHorario.Lines.Add('[Segunda-RetornoAlmoco]: ' + MD5(Segunda.RetornoAlmoco, True));
  memHistHorario.Lines.Add('[Segunda-SaidaFinal]: ' + MD5(Segunda.SaidaFinal, True));

  memHistHorario.Lines.Add('[Terca-Entrada]: ' + MD5(Terca.Entrada, True));
  memHistHorario.Lines.Add('[Terca-SaidaAlmoco]: ' + MD5(Terca.SaidaAlmoco, True));
  memHistHorario.Lines.Add('[Terca-RetornoAlmoco]: ' + MD5(Terca.RetornoAlmoco, True));
  memHistHorario.Lines.Add('[Terca-SaidaFinal]: ' + MD5(Terca.SaidaFinal, True));

  memHistHorario.Lines.Add('[Quarta-Entrada]: ' + MD5(Quarta.Entrada, True));
  memHistHorario.Lines.Add('[Quarta-SaidaAlmoco]: ' + MD5(Quarta.SaidaAlmoco, True));
  memHistHorario.Lines.Add('[Quarta-RetornoAlmoco]: ' + MD5(Quarta.RetornoAlmoco, True));
  memHistHorario.Lines.Add('[Quarta-SaidaFinal]: ' + MD5(Quarta.SaidaFinal, True));

  memHistHorario.Lines.Add('[Quinta-Entrada]: ' + MD5(Quinta.Entrada, True));
  memHistHorario.Lines.Add('[Quinta-SaidaAlmoco]: ' + MD5(Quinta.SaidaAlmoco, True));
  memHistHorario.Lines.Add('[Quinta-RetornoAlmoco]: ' + MD5(Quinta.RetornoAlmoco, True));
  memHistHorario.Lines.Add('[Quinta-SaidaFinal]: ' + MD5(Quinta.SaidaFinal, True));

  memHistHorario.Lines.Add('[Sexta-Entrada]: ' + MD5(Sexta.Entrada, True));
  memHistHorario.Lines.Add('[Sexta-SaidaAlmoco]: ' + MD5(Sexta.SaidaAlmoco, True));
  memHistHorario.Lines.Add('[Sexta-RetornoAlmoco]: ' + MD5(Sexta.RetornoAlmoco, True));
  memHistHorario.Lines.Add('[Sexta-SaidaFinal]: ' + MD5(Sexta.SaidaFinal, True));

  memHistHorario.Lines.Add('[Sabado-Entrada]: ' + MD5(Sabado.Entrada, True));
  memHistHorario.Lines.Add('[Sabado-SaidaFinal]: ' + MD5(Sabado.SaidaFinal, True));
end;

procedure TfrmPrincipal.AplicarCorComponentesTotalDeHorasSemanal(pCor: TColor);
begin
  edtHoraDifTrab.Font.Color := pCor;
  edtTotalHoraTrab.Font.Color := pCor;
  lblHoraTrabDesemp.Font.Color := pCor;
  lblHoraTrabRosto.Font.Color := pCor;
end;

procedure TfrmPrincipal.AtualizarComponentesTotalDeHorasSemanal;
begin
  if VerificarTodosGroupBoxSemanaVazios then
  begin
    edtTotalHoraTrab.Text := ':';
    edtHoraDifTrab.Text := EmptyStr;

    lblHoraTrabRosto.Caption := EmptyStr;
    lblHoraTrabDesemp.Caption := EmptyStr;

    AplicarCorComponentesTotalDeHorasSemanal(clBlack);
    Exit;
  end;

  edtTotalHoraTrab.Text := FPontoSemanal.CargoHoras.TotalTrabalhadas;
  edtHoraDifTrab.Text := FPontoSemanal.CargoHoras.SaldoDeHoras;
  lblHoraTrabDesemp.Caption := 'ü';
  lblHoraTrabRosto.Caption := 'K';

  AplicarCorComponentesTotalDeHorasSemanal(clGreen);

  if FPontoSemanal.CargoHoras.Cumprimento = chAcima then
  begin
    lblHoraTrabDesemp.Caption := 'é';
    lblHoraTrabRosto.Caption := 'J';
    AplicarCorComponentesTotalDeHorasSemanal($ff0000);
  end;
  if FPontoSemanal.CargoHoras.Cumprimento = chAbaixo then
  begin
    lblHoraTrabDesemp.Caption := 'ê';
    lblHoraTrabRosto.Caption := 'L';
    AplicarCorComponentesTotalDeHorasSemanal($303497);
  end;
end;

procedure TfrmPrincipal.AtualizarValoresTotalDeHorasSemana(pDia: THorarioBase; pGroupBox: TGroupBox; pCargaHoraria: Integer);
var
  vHoraDif, vTotalHora, vNomeDiaSemana: string;
  vLabel: TLabel;
  vEditHoraDif, vEditTotalHora: TEdit;
begin
  vNomeDiaSemana := Copy(pGroupBox.Name, 4, 3);

  vLabel := TLabel(FindComponent('lbl' + vNomeDiaSemana + 'Desempenho'));
  vEditHoraDif := TEdit(FindComponent('edt' + vNomeDiaSemana + 'HoraDif'));
  vEditTotalHora := TEdit(FindComponent('edt' + vNomeDiaSemana + 'TotalHora'));

  if VerificarGroupBoxVazio(pGroupBox) then
  begin
    vLabel.Caption := '';
    vEditHoraDif.Text := '';
    vEditTotalHora.Text := ':';
    vLabel.Font.Color := clBlack;
    vEditHoraDif.Font.Color := clBlack;
    vEditTotalHora.Font.Color := clBlack;
    Exit;
  end;

  vHoraDif := FormatDateTime('hh:mm', StrTotime(pDia.CargoHoras.SaldoDeHoras));
  vTotalHora := FormatDateTime('hh:mm', StrTotime(pDia.CargoHoras.SaldoDeHoras));
  AtualizarComponentesTotalHoras(pDia, vHoraDif, vTotalHora, vLabel, vEditHoraDif, vEditTotalHora);
end;

procedure TfrmPrincipal.btnCarregarHistClick(Sender: TObject);
begin
  CarregarHistorico;
end;

procedure TfrmPrincipal.btnGerSalHistClick(Sender: TObject);
begin
  GerarHistorico;
end;

procedure TfrmPrincipal.btnNovoRegistroClick(Sender: TObject);
begin
  if VerificarAlgumCampoPreenchido then
  begin
    if Application.MessageBox('Ainda possui valores anotados, quer mesmo apagá-los?', 'Valores Existentes', MB_YESNO +
      MB_ICONINFORMATION) = ID_NO then
    begin
      Exit;
    end;
  end;

  LimparFormulario;
end;

function TfrmPrincipal.RetornarNomeCustomEdit(pCustomEdit: TCustomEdit): string;
var
  vNomeCustomEdit, vGroupBoxParent, vCaptionLabel: string;
begin
  vNomeCustomEdit := Copy(pCustomEdit.Name, 4, Length(pCustomEdit.Name));

  if (pCustomEdit.Parent <> gbxDadosFuncionario) then
  begin
    vGroupBoxParent := ', de ' + TGroupBox(pCustomEdit.Parent).Caption;

    if pCustomEdit is TMaskEdit then
    begin
      vNomeCustomEdit := Copy(pCustomEdit.Name, 5, Length(pCustomEdit.Name));
    end;
  end;

  vCaptionLabel := TLabel(FindComponent('lbl' + vNomeCustomEdit)).Caption;
  vCaptionLabel := StringReplace(vCaptionLabel, ':', '', [rfReplaceAll]);
  Result := vCaptionLabel + vGroupBoxParent;
end;

procedure TfrmPrincipal.CalcularTempoRegistroAdmissao;
var
  vDataAdmissao: TDate;
  vAnos, vMeses, vSemanas, vDias: Integer;
  vIdade: string;
begin
  if VerificarCampoVazio(edtAdmissao) then
  begin
    lblAnosMesesSemanasDias.Caption := '-> anos; meses; semanas; dias.';
    Exit;
  end;

  if not VerificarDataValida(edtAdmissao.Text) then
  begin
    lblAnosMesesSemanasDias.Caption := '-> anos; meses; semanas; dias.';
    Exit;
  end;

  vDataAdmissao := StrToDate(edtAdmissao.Text);
  edtAdmissao.Text := FormatDateTime('dd/mm/yyyy', vDataAdmissao);

  vAnos := YearsBetween(vDataAdmissao, Date);
  vMeses := MonthsBetween(IncYear(vDataAdmissao, vAnos), Date);
  vSemanas := WeeksBetween(IncMonth(IncYear(vDataAdmissao, vAnos), vMeses), Date);
  vDias := DaysBetween(IncWeek(IncMonth(IncYear(vDataAdmissao, vAnos), vMeses), vSemanas), Date);

  vIdade := TratarPluralDataAdmissao(vAnos, vMeses, vSemanas, vDias);
  lblAnosMesesSemanasDias.Caption := '-> ' + vIdade;
end;

procedure TfrmPrincipal.CarregarFolhaDePontoArquivo;
begin
  try
    if not opdCarregarTxt.Execute then
    begin
      Exit;
    end;

    if ExtractFileExt(opdCarregarTxt.FileName) <> '.txt' then
    begin
      MandarMensagemExtensaoDoArquivoInvalido('não corresponde a extensão suportada (.txt)');
      Exit;
    end;

    memHistHorario.Lines.LoadFromFile(opdCarregarTxt.FileName);

    if not TRegex.IsMatch(memHistHorario.Text, REGEX_HORARIOS, [roIgnoreCase]) then
    begin
      memHistHorario.Clear;
      Application.MessageBox('Seu Arquivo escolhido não possui nenhum horário', 'Folha de Ponto Invalida',
        MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    BuscarValoresRegExHorarios;
    PreencherDadosFuncionario;

    if VerificarFolhaDePontoViolada then
    begin
      var vPassWord: string;

      memHistHorario.Clear;
      vPassWord := InputBox('Folha de Ponto Violada', #9'Digite a Palavra-Chave', '');

      if vPassWord = EmptyStr then
      begin
        Exit;
      end;

      if (vPassWord <> 'gansodeterno') then
      begin
        Application.MessageBox('A senha inserida está inválida', 'Senha Incorreta', MB_OK + MB_ICONWARNING);
        CarregarFolhaDePontoArquivo;
        Exit;
      end;

      memHistHorario.Lines.LoadFromFile(opdCarregarTxt.FileName);

      PassarPeloDadosFuncionario;
      AnalizarHorariosAlterados;
    end;

    memHistHorario.SelStart := 1;
    memHistHorario.SelLength := 1;
    PassarPeloDadosFuncionario;
  except
    on E: Exception do
    begin
      MandarMensagemFalhaDesconhecida('Não foi possivel carregar completamente seu arquivo', edtCodigo);
    end;
  end;
end;

procedure TfrmPrincipal.CarregarHistorico;
begin
  if VerificarAlgumCampoPreenchido then
  begin
    if Application.MessageBox('Ainda possui valores anotados, caso carregue um registro os dados serão limpados,' +
      ' Deseja prosseguir?', 'Valores Ainda Existentes', MB_YESNO + MB_ICONINFORMATION) = ID_NO then
    begin
      Exit;
    end;
  end;

  LimparFormulario;
  CarregarFolhaDePontoArquivo;
end;

function TfrmPrincipal.CriptografarString(pString: string): string;
var
  vSimbolos : array [1..4] of String;
  vIndex: Integer;
  vCopy: string;
begin
  vSimbolos[1]:='ABCDEFGHIJLMNOPQRSTUVXZYWK ~!@#$%^&*()';
  vSimbolos[2]:= 'ÂÀ©Øû×ƒçêùÿ5Üø£úñÑªº¿®¬¼ëèïÙýÄÅÉæÆôöò»Á';
  vSimbolos[3]:= 'abcdefghijlmnopqrstuvxzywk1234567890';
  vSimbolos[4]:= 'áâäàåíóÇüé¾¶§÷ÎÏ-+ÌÓß¸°¨·¹³²Õµþîì¡«½';

  for vIndex := 1 to Length(Trim(pString)) do
  begin
    vCopy := Copy(pString, vIndex, 1);

    if Pos(vCopy, vSimbolos[1]) > 0 then
    begin
      Result := Result + Copy(vSimbolos[2], Pos(vCopy, vSimbolos[1]), 1);
    end else

    if Pos(vCopy, vSimbolos[2]) > 0 then
    begin
      Result := Result + Copy(vSimbolos[1], Pos(vCopy, vSimbolos[2]), 1);
    end else

    if Pos(vCopy, vSimbolos[3]) > 0 then
    begin
      Result := Result + Copy(vSimbolos[4], Pos(vCopy, vSimbolos[3]), 1);
    end else

    if Pos(vCopy, vSimbolos[4]) > 0 then
    begin
      Result := Result+copy(vSimbolos[3], Pos(vCopy, vSimbolos[4]), 1);
    end;
  end;
end;

procedure TfrmPrincipal.DestacarHorariosAlterados(pHorarios: THorarioDiaUtil; pDia: string);
var
  vMaskEdit: TMaskEdit;
  vHashArquivo, vHashAtual: Array[0..3] of string;
  vCopy: string;
begin
  vCopy := Copy(pDia, 1, 3);

  vHashArquivo[0] := ProcurarHashDentroArquivo('[' + pDia + '-Entrada]');
  vHashArquivo[1] := ProcurarHashDentroArquivo('[' + pDia + '-SaidaAlmoco]');
  vHashArquivo[2] := ProcurarHashDentroArquivo('[' + pDia + '-RetornoAlmoco]');
  vHashArquivo[3] := ProcurarHashDentroArquivo('[' + pDia + '-SaidaFinal]');

  vHashAtual[0] := MD5(pHorarios.Entrada, True);
  vHashAtual[1] := MD5(pHorarios.SaidaAlmoco, True);
  vHashAtual[2] := MD5(pHorarios.RetornoAlmoco, True);
  vHashAtual[3] := MD5(pHorarios.SaidaFinal, True);


  if vHashArquivo[0] <> vHashAtual[0] then
  begin
    vMaskEdit := TMaskEdit(FindComponent('medt' + vCopy + 'Entrada'));
    vMaskEdit.Color := clSkyBlue;
  end;

  if vHashArquivo[1] <> vHashAtual[1] then
  begin
    vMaskEdit := TMaskEdit(FindComponent('medt' + vCopy + 'SaidaAlmoco'));
    vMaskEdit.Color := clSkyBlue;
  end;

  if vHashArquivo[2] <> vHashAtual[2] then
  begin
    vMaskEdit := TMaskEdit(FindComponent('medt' + vCopy + 'RetornoAlmoco'));
    vMaskEdit.Color := clSkyBlue;
  end;

  if vHashArquivo[3] <> vHashAtual[3] then
  begin
    vMaskEdit := TMaskEdit(FindComponent('medt' + vCopy + 'SaidaFinal'));
    vMaskEdit.Color := clSkyBlue;
  end;
end;

procedure TfrmPrincipal.AnalizarDiaDaSemanaAlterado(pDiaSemana: THorarioDiaUtil);
var
  vHashSemana, vDiaSemana: string;
begin
  vDiaSemana := GetEnumName(TypeInfo(TDiaSemana), Integer(pDiaSemana.Nome));
  vDiaSemana := Copy(vDiaSemana, 3, Length(vDiaSemana));

  vHashSemana := pDiaSemana.Entrada + pDiaSemana.SaidaAlmoco + pDiaSemana.RetornoAlmoco + pDiaSemana.SaidaFinal;
  vHashSemana := MD5(vHashSemana, True);

  if ProcurarHashDentroArquivo('[' + vDiaSemana + ']') <> vHashSemana then
  begin
    DestacarHorariosAlterados(pDiaSemana, vDiaSemana);
  end;
end;

procedure TfrmPrincipal.AnalizarHorariosAlterados;
begin
  AnalizarDiaDaSemanaAlterado(Segunda);
  AnalizarDiaDaSemanaAlterado(Terca);
  AnalizarDiaDaSemanaAlterado(Quarta);
  AnalizarDiaDaSemanaAlterado(Quinta);
  AnalizarDiaDaSemanaAlterado(Sexta);

  if MD5(Sabado.Entrada + Sabado.SaidaFinal, True) <> ProcurarHashDentroArquivo('[Sabado]') then
  begin
    if MD5(Sabado.Entrada, True) <> ProcurarHashDentroArquivo('[Sabado-Entrada]') then
    begin
      medtSabEntrada.Color := clSkyBlue;
    end;

    if MD5(Sabado.SaidaFinal, True) <> ProcurarHashDentroArquivo('[Sabado-SaidaFinal]') then
    begin
      medtSabSaidaFinal.Color := clSkyBlue;
    end;
  end;
end;

procedure TfrmPrincipal.VerificarDadosFuncionarioRegEx(pRegex: string; pEdit: TCustomEdit);
var
  vRegex: TRegEx;
begin
  vRegex := TRegEx.Create(pRegex, [roIgnoreCase]);

  if not vRegex.IsMatch(memHistHorario.Text) then
  begin
    Exit;
  end;

  pEdit.Text := vRegex.Match(memHistHorario.Text).Groups[2].Value;
end;

procedure TfrmPrincipal.BuscarValoresRegExHorarios;
var
  vMatches: TMatchCollection;
begin
  vMatches := TRegex.Matches(memHistHorario.Text, REGEX_HORARIOS,[roIgnoreCase]);

  for var vMatch in vMatches do
  begin
    if not vMatch.Success then
    begin
      Continue;
    end;

    for var vGroup in vMatch.Groups do
    begin
      if not vGroup.Success then
      begin
        Continue;
      end;

      PreencherMaskEditsHorarios(vGroup, vMatch.Groups);
    end;
  end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  ShowMessage(GetEnumName(TypeInfo(TDiaSemana), integer(dsSegunda)));
end;

procedure TfrmPrincipal.TimerSistemaTimer(Sender: TObject);
begin
  stbDataHoraSistema.Panels.Items[1].Text := TimeToStr(Now);
end;

procedure TfrmPrincipal.TratarExceptions(pE: Exception; pHorario: THorarioDiaUtil; pEditAtual: TCustomEdit);
var
  vEClassType: TClass;
begin
  vEClassType := pE.ClassType;

  TratarExceptionsHorarioAlmoco(vEClassType, pEditAtual.Parent.Name, pHorario);

  if vEClassType = EHorarioZeradoNaoPermitido then
  begin
    MandarMensagemHorarioInvalido('não é aceito zerado', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMaiorQueSaidaAlmoco then
  begin
    MandarMensagemHorarioInvalido('esta maior que o Horário Saida-Almoço', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMaiorQueRetornoAlmoco then
  begin
    MandarMensagemHorarioInvalido('esta maior que o Horário Retorno-Almoço', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMaiorQueSaidaFinal then
  begin
    MandarMensagemHorarioInvalido('esta maior que o Horário Saida-Final', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMenorQueEntrada then
  begin
    MandarMensagemHorarioInvalido('esta menor que o Horário Entrada', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMenorQueSaidaAlmoco then
  begin
    MandarMensagemHorarioInvalido('esta menor que o Horário Saida-Almoço', pEditAtual);
  end else

  if vEClassType = EHorarioAtualMenorQueRetornoAlmoco then
  begin
    MandarMensagemHorarioInvalido('esta menor que o Horário Retorno-Almoço', pEditAtual);
  end else

  if vEClassType = EHorarioInvalido then
  begin
    MandarMensagemHorarioInvalido('está inválido', pEditAtual);
  end else
  begin
    MandarMensagemFalhaDesconhecida('Houve uma falha inesperada ao inserir seu horário', pEditAtual);
  end;
end;

procedure TfrmPrincipal.TratarExceptionsDiaUtil(pException: Exception; pEditSaidaAlmoco: TCustomEdit;
  pEditRetornoAlmoco: TCustomEdit; pEditAtual: TCustomEdit; pDia: THorarioDiaUtil);

  procedure LimparCamposAlmoco;
  begin
    pEditSaidaAlmoco.Clear;
    pEditRetornoAlmoco.Clear;
    pDia.RetornoAlmoco := ':';
    pDia.SaidaAlmoco := ':';
    FocarCampo(pEditSaidaAlmoco);
  end;
var
  vClassType: TClass;
begin
  vClassType := pException.ClassType;

  if vClassType = EHorarioAnteriorNaoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ser zerado, porque Saída-Almoço possui horário.' +
    #13 + 'Altere seu horário atual', 'Horario Saída-Almoço Nao Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      pEditRetornoAlmoco.Clear;
      FocarCampo(pEditRetornoAlmoco);
    end else
    begin
      LimparCamposAlmoco;
    end;
  end else

  if vClassType = EHorarioProximoNaoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ser zerado, porque Retorno-Almoço possui horário.' +
    #13 + 'Altere seu horário atual!', 'Horario Retorno-Almoço Nao Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      pEditSaidaAlmoco.Clear;
      FocarCampo(pEditSaidaAlmoco);
    end else
    begin
      LimparCamposAlmoco;
    end;
  end else

  if vClassType = EHorarioAnteriorZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ter um horario diferente do que zerado, ' +
    'porque Saída-Almoço está zerado.' + #13 + 'Altere seu horario Atual!',
    'Horario Saída-Almoço Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      pEditRetornoAlmoco.Clear;
      FocarCampo(pEditRetornoAlmoco);
    end else
    begin
      LimparCamposAlmoco;
    end;
  end else

  if vClassType = EHorarioProximoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ter um horario diferente do que zerado, ' +
    'porque Retorno-Almoço está zerado.' + #13 + 'Altere seu horario Atual!',
    'Horario Retorno-Almoço Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      pEditSaidaAlmoco.Clear;
      FocarCampo(pEditSaidaAlmoco);
    end else
    begin
      LimparCamposAlmoco;
    end;
  end else

  if vClassType = EHorarioZeradoNaoPermitido then
  begin
    MandarMensagemHorarioInvalido('não é aceito zerado', pEditAtual);
  end else

//  if vClassType = EHorarioMaiorProximo then
//  begin
//    MandarMensagemHorarioInvalido('esta maior que um de seus horários posteriores', pEditAtual);
//  end else
//
//  if vClassType =  EHorarioMenorAnterior then
//  begin
//    MandarMensagemHorarioInvalido('esta menor que um de seus horários anteriores', pEditAtual);
//  end else

  if vClassType = EHorarioInvalido then
  begin
    MandarMensagemHorarioInvalido('está inválido', pEditAtual);
  end else
  begin
    MandarMensagemFalhaDesconhecida('Houve uma falha inesperada ao inserir seu horário', pEditAtual);
  end;
end;

procedure TfrmPrincipal.TratarExceptionsHorarioAlmoco(pEClass: TClass; pGroupBoxName: string; pHorario: THorarioDiaUtil);
var
  vSaidaAlmoco, vRetornoAlmoco: TMaskEdit;
  vDiaSemana: string;
begin
  vDiaSemana := Copy(pGroupBoxName, 4, 3);
  vSaidaAlmoco := TMaskEdit(FindComponent('medt' + vDiaSemana + 'SaidaAlmoco'));
  vRetornoAlmoco := TMaskEdit(FindComponent('medt' + vDiaSemana + 'RetornoAlmoco'));

  if pEClass = EHorarioAnteriorNaoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ser zerado, porque Saída-Almoço possui horário.' +
    #13 + 'Altere seu horário atual', 'Horario Saída-Almoço Nao Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      vRetornoAlmoco.Clear;
      FocarCampo(vRetornoAlmoco);
    end else
    begin
      vRetornoAlmoco.Clear;
      vSaidaAlmoco.Clear;
      pHorario.RetornoAlmoco := EmptyStr;
      pHorario.SaidaAlmoco := EmptyStr;
      FocarCampo(vSaidaAlmoco);
    end;
  end;

  if pEClass = EHorarioProximoNaoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ser zerado, porque Retorno-Almoço possui horário.' +
    #13 + 'Altere seu horário atual!', 'Horario Retorno-Almoço Nao Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      vSaidaAlmoco.Clear;
      FocarCampo(vSaidaAlmoco);
    end else
    begin
      vRetornoAlmoco.Clear;
      vSaidaAlmoco.Clear;
      pHorario.RetornoAlmoco := EmptyStr;
      pHorario.SaidaAlmoco := EmptyStr;
      FocarCampo(vSaidaAlmoco);
    end;
  end;

  if pEClass = EHorarioAnteriorZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ter um horario diferente do que zerado, ' +
    'porque Saída-Almoço está zerado.' + #13 + 'Altere seu horario Atual!',
    'Horario Saída-Almoço Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      vRetornoAlmoco.Clear;
      FocarCampo(vRetornoAlmoco);
    end else
    begin
      vRetornoAlmoco.Clear;
      vSaidaAlmoco.Clear;
      pHorario.RetornoAlmoco := EmptyStr;
      pHorario.SaidaAlmoco := EmptyStr;
      FocarCampo(vSaidaAlmoco);
    end;
  end;

  if pEClass = EHorarioProximoZerado then
  begin
    if Application.MessageBox('Seu horário Atual inserido não pode ter um horario diferente do que zerado, ' +
    'porque Retorno-Almoço está zerado.' + #13 + 'Altere seu horario Atual!',
    'Horario Retorno-Almoço Zerado', MB_YESNO + MB_ICONINFORMATION) = ID_YES then
    begin
      vSaidaAlmoco.Clear;
      FocarCampo(vSaidaAlmoco);
    end else
    begin
      vRetornoAlmoco.Clear;
      vSaidaAlmoco.Clear;
      pHorario.RetornoAlmoco := EmptyStr;
      pHorario.SaidaAlmoco := EmptyStr;
      FocarCampo(vSaidaAlmoco);
    end;
  end;
end;


{procedure TfrmPrincipal.TratarExceptionsSabado(pException: Exception; pEditAtual: TCustomEdit);
var
  vClassType: TClass;
begin
  vClassType := pException.ClassType;

  if vClassType = EHorarioZeradoNaoPermitido then
  begin
    MandarMensagemHorarioInvalido('não é aceito zerado', pEditAtual);
  end;

  if vClassType = EHorarioMaiorProximo then
  begin
    MandarMensagemHorarioInvalido('esta maior que seu horário de Saida-Final', pEditAtual);
  end;

  if vClassType = EHorarioMenorAnterior then
  begin
    MandarMensagemHorarioInvalido('esta menor que seu horário de Entrada', pEditAtual);
  end;

  if vClassType = EHorarioInvalido then
  begin
    MandarMensagemHorarioInvalido('está inválido', pEditAtual);
  end else
  begin
    MandarMensagemFalhaDesconhecida('Houve uma falha inesperada ao inserir seu horário', pEditAtual);
  end;
end;}

function TfrmPrincipal.TratarPluralDataAdmissao(pAnos: Integer; pMeses: Integer; pSemanas: Integer;
  pDias: Integer): string;
begin
  case pAnos of
    0: ;
    1: Result := pAnos.ToString + ' Ano; ';
    else Result := pAnos.ToString + ' Anos; ';
  end;

  case pMeses of
    0: ;
    1: Result := Result + pMeses.ToString + ' Mês; ';
    else Result := Result + pMeses.ToString + ' Meses; ';
  end;

  case pSemanas of
    0: ;
    1: Result := Result + pSemanas.ToString + ' Semana; ';
    else Result := Result + pSemanas.ToString + ' Semanas; ';
  end;

  case pDias of
    0: ;
    1: Result := Result + pDias.ToString + ' Dia. ';
    else Result := Result + pDias.ToString + ' Dias. ';
  end;

  if Result <> EmptyStr then
  begin
    Result := Copy(Result, 1, Length(Result) - 2) + '.';
  end else
  begin
    Result := 'Seu Primeiro Dia, Bem-Vindo(a)!!';
  end;
end;

function TfrmPrincipal.TratarPluralIntervaloAlmoco(pHora: Integer; pMinuto: Integer): string;
begin
  case pHora of
    0: ;
    1: Result := pHora.ToString + ' hora' + IfThen(pMinuto.ToString > '0', ' e ');
    else Result := pHora.ToString + ' horas' + IfThen(pMinuto.ToString > '0', ' e ');
  end;

  case pMinuto of
    0: ;
    1: Result := Result + pMinuto.ToString + ' minuto';
    else Result := Result + pMinuto.ToString + ' minutos';
  end;
end;

procedure TfrmPrincipal.InserirJornadaSemanal;
begin
  FPontoSemanal.JornadaSemanal := 44;

  if not VerificarCampoVazio(edtJornadaSemanal) then
  begin
    FPontoSemanal.JornadaSemanal := StrToInt(edtJornadaSemanal.Text);
  end;

  PassarPelosMaskEdit;
end;

procedure TfrmPrincipal.LimparFormulario;
var
  vComponente: String;
begin
  lblAnosMesesSemanasDias.Caption := '-> anos; meses; semanas; dias.';
  lblTempoExtenso.Caption := '"x" horas e "y" minutos';
  memHistHorario.Clear;
  SetarCoresDefaultMaskEdits;

  for var I := 0 to ComponentCount -1 do
  begin
    vComponente := Components[I].Name;

    if (Components[I] is TMaskEdit) and not (TMaskEdit(Components[I]).ReadOnly) then
    begin
      TMaskEdit(Components[I]).Clear;
      TMaskEdit(Components[I]).OnExit(Components[I]);
    end;

    if Components[I] is TEdit then
    begin
      TEdit(Components[I]).Clear;

      if vComponente.Contains('TotalHora') then
      begin
        TEdit(Components[I]).Text := ':';
      end else
      if not vComponente.Contains('Codigo') and not vComponente.Contains('Nome') and
         not vComponente.Contains('HoraDif') and not (TEdit(Components[I]).Parent = gbxHorasTrabalhadas) then
      begin
        TEdit(Components[I]).OnExit(Components[I]);
      end;
    end;

    if Components[I] is TLabel then
    begin
      if vComponente.Contains('Desemp') or vComponente.Contains('Rosto') then
      begin
        TLabel(Components[I]).Caption := EmptyStr;
      end;
    end;
  end;
end;

procedure TfrmPrincipal.EscreverIntervaloAlmocoExtenso;
var
  vHora, vMinuto: Integer;
  vIntervaloAlmoco: string;
  vIntervaloTime: TDateTime;
begin
  if VerificarCampoVazio(edtIntervaloAlmoco) then
  begin
    Exit;
  end;

  case Length(edtIntervaloAlmoco.Text) of
    1: edtIntervaloAlmoco.Text := string(edtIntervaloAlmoco.Text).PadRight(3, '0');
    else edtIntervaloAlmoco.Text := string(edtIntervaloAlmoco.Text).PadRight(4, '0');
  end;

  vIntervaloAlmoco := edtIntervaloAlmoco.Text;

  if not TryStrToTime(vIntervaloAlmoco, vIntervaloTime) then
  begin
    MandarMensagemHorarioInvalido('não é um intervalo válido', edtIntervaloAlmoco);
    lblTempoExtenso.Caption := '"x" horas e "y" minutos';
    Exit;
  end;

  if vIntervaloTime > StrToTime('3:00') then
  begin
    MandarMensagemHorarioInvalido('está excedendo o limite (Máx: 3:00 Horas)', edtIntervaloAlmoco);
    lblTempoExtenso.Caption := '"x" horas e "y" minutos';
    Exit;
  end;

  vHora := SplitString(vIntervaloAlmoco, ':')[0].ToInteger;
  vMinuto := SplitString(vIntervaloAlmoco, ':')[1].ToInteger;

  lblTempoExtenso.Caption := TratarPluralIntervaloAlmoco(vHora, vMinuto);
end;

procedure TfrmPrincipal.MandarMensagemFalhaDesconhecida(pInformacao: string; pEditAtual: TCustomEdit);
begin
  Application.MessageBox(pChar(pInformacao + '. Porfavor verfique!'), 'Falha Desconhecida', MB_OK +
    MB_ICONINFORMATION);
  pEditAtual.Clear;
  FocarCampo(pEditAtual);
end;

procedure TfrmPrincipal.MandarMensagemHorarioInvalido(pMotivo: string; pEditAtual: TCustomEdit);
begin
  Application.MessageBox(pChar('O Horario inserido, ' + pMotivo + '. Porfavor verfique!'), 'Horário Inválido', MB_OK +
    MB_ICONINFORMATION);
  pEditAtual.Clear;
  FocarCampo(pEditAtual);
end;

function TfrmPrincipal.MD5(pText: string; pSalting: Boolean): string;
var
  vHash: THashMD5;
  vResult: string;
begin
  vHash := THashMD5.Create;

  case pSalting of
    True: vResult := pText + MD5(CriptografarString(HASH_SALTING), False);
    else vResult := pText;
  end;

  Result := vHash.GetHashString(vResult);
end;

procedure TfrmPrincipal.medtQuaEntradaExit(Sender: TObject);
begin
  SairCampoQuarta(thEntrada, medtQuaEntrada);
end;

procedure TfrmPrincipal.medtQuaRetornoAlmocoExit(Sender: TObject);
begin
  SairCampoQuarta(thRetornoAlmoco, medtQuaRetornoAlmoco);
end;

procedure TfrmPrincipal.medtQuaSaidaAlmocoExit(Sender: TObject);
begin
  SairCampoQuarta(thSaidaAlmoco, medtQuaSaidaAlmoco);
end;

procedure TfrmPrincipal.medtQuaSaidaFinalExit(Sender: TObject);
begin
  SairCampoQuarta(thSaidaFinal, medtQuaSaidaFinal);
end;

procedure TfrmPrincipal.medtQuiEntradaExit(Sender: TObject);
begin
  SairCampoQuinta(thEntrada, medtQuiEntrada);
end;

procedure TfrmPrincipal.medtQuiRetornoAlmocoExit(Sender: TObject);
begin
  SairCampoQuinta(thRetornoAlmoco, medtQuiRetornoAlmoco);
end;

procedure TfrmPrincipal.medtQuiSaidaAlmocoExit(Sender: TObject);
begin
  SairCampoQuinta(thSaidaAlmoco, medtQuiSaidaAlmoco);
end;

procedure TfrmPrincipal.medtQuiSaidaFinalExit(Sender: TObject);
begin
  SairCampoQuinta(thSaidaFinal, medtQuiSaidaFinal);
end;

procedure TfrmPrincipal.medtSabEntradaExit(Sender: TObject);
begin
  SairCampoSabado(thEntrada, medtSabEntrada);
end;

procedure TfrmPrincipal.medtSabSaidaFinalExit(Sender: TObject);
begin
  SairCampoSabado(thSaidaFinal, medtSabSaidaFinal);
end;

procedure TfrmPrincipal.medtSegEntradaExit(Sender: TObject);
begin
//  SairCampoSegunda(thEntrada, medtSegEntrada);
  SairCampoGenerico(Segunda, Segunda.Entrada, medtSegEntrada);
end;

procedure TfrmPrincipal.medtSegRetornoAlmocoExit(Sender: TObject);
begin
  SairCampoSegunda(thRetornoAlmoco, medtSegRetornoAlmoco);
end;

procedure TfrmPrincipal.medtSegSaidaAlmocoExit(Sender: TObject);
begin
  SairCampoSegunda(thSaidaAlmoco, medtSegSaidaAlmoco);
end;

procedure TfrmPrincipal.medtSegSaidaFinalExit(Sender: TObject);
begin
  SairCampoSegunda(thSaidaFinal, medtSegSaidaFinal);
end;

procedure TfrmPrincipal.medtSexEntradaExit(Sender: TObject);
begin
  SairCampoSexta(thEntrada, medtSexEntrada);
end;

procedure TfrmPrincipal.medtSexRetornoAlmocoExit(Sender: TObject);
begin
  SairCampoSexta(thRetornoAlmoco, medtSexRetornoAlmoco);
end;

procedure TfrmPrincipal.medtSexSaidaAlmocoExit(Sender: TObject);
begin
  SairCampoSexta(thSaidaAlmoco, medtSexSaidaAlmoco);
end;

procedure TfrmPrincipal.medtSexSaidaFinalExit(Sender: TObject);
begin
  SairCampoSexta(thSaidaFinal, medtSexSaidaFinal);
end;

procedure TfrmPrincipal.medtTerEntradaExit(Sender: TObject);
begin
  SairCampoTerca(thEntrada, medtTerEntrada);
end;

procedure TfrmPrincipal.medtTerRetornoAlmocoExit(Sender: TObject);
begin
  SairCampoTerca(thRetornoAlmoco, medtTerRetornoAlmoco);
end;

procedure TfrmPrincipal.medtTerSaidaAlmocoExit(Sender: TObject);
begin
  SairCampoTerca(thSaidaAlmoco, medtTerSaidaAlmoco);
end;

procedure TfrmPrincipal.medtTerSaidaFinalExit(Sender: TObject);
begin
  SairCampoTerca(thSaidaFinal, medtTerSaidaFinal);
end;

procedure TfrmPrincipal.MandarMensagemDataInvalida(pMotivo: string; pEditAtual: TCustomEdit);
begin
  Application.MessageBox(pChar('A Data inserida, ' + pMotivo + '. Porfavor verfique!'), 'Data Inválida', MB_OK +
    MB_ICONINFORMATION);
  pEditAtual.Clear;
  FocarCampo(pEditAtual);
end;

procedure TfrmPrincipal.MandarMensagemExtensaoDoArquivoInvalido(pInformacao: string);
begin
  Application.MessageBox(pChar('O arquivo, ' + pInformacao + '. Porfavor verfique!'), 'Extensão do Arquivo inválido',
    MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmPrincipal.edtAdmissaoChange(Sender: TObject);
begin
  TFuncoes.FormatarData(edtAdmissao);
end;

procedure TfrmPrincipal.edtAdmissaoExit(Sender: TObject);
begin
  CalcularTempoRegistroAdmissao;
end;

procedure TfrmPrincipal.edtCodigoChange(Sender: TObject);
begin
  PermitirSomenteNumeros(edtCodigo);
end;

procedure TfrmPrincipal.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.Text <> EmptyStr then
  begin
    edtCodigo.Text := string(edtCodigo.Text).PadLeft(7, '0');
  end;
end;

procedure TfrmPrincipal.edtIntervaloAlmocoChange(Sender: TObject);
begin
  edtIntervaloAlmoco.Text := TFuncoes.FormatarHorario(edtIntervaloAlmoco.Text);
  TFuncoes.MoverFinal(edtIntervaloAlmoco);
end;

procedure TfrmPrincipal.edtIntervaloAlmocoExit(Sender: TObject);
begin
  EscreverIntervaloAlmocoExtenso;
end;

procedure TfrmPrincipal.edtJornadaSemanalChange(Sender: TObject);
begin
  PermitirSomenteNumeros(edtJornadaSemanal);
end;

procedure TfrmPrincipal.edtJornadaSemanalExit(Sender: TObject);
begin
  InserirJornadaSemanal;
end;

procedure TfrmPrincipal.edtNomeChange(Sender: TObject);
begin
  edtNome.Text := TFuncoes.SomenteLetrasComEspaco(edtNome.Text);
end;

procedure TfrmPrincipal.FocarCampo(const pEdit: TCustomEdit);
begin
  if pEdit.CanFocus then
  begin
    pEdit.SetFocus;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FPontoSemanal := TPontoSemanal.Create;
  stbDataHoraSistema.Panels.Items[0].Text := FormatDateTime('dddddd', Now);
  TimerSistema.Enabled := True;
end;

procedure TfrmPrincipal.GerarHistorico;
begin
  if not VerificarTodosCamposEstaoPreenchidos then
  begin
    Exit;
  end;

  PreencherMemoPontoSemanal;
  SalvarFolhaDePontoArquivo;
  SetarCoresDefaultMaskEdits;
end;

function TfrmPrincipal.GetQuarta: THorarioDiaUtil;
begin
  Result := FPontoSemanal.Quarta;
end;

function TfrmPrincipal.GetQuinta: THorarioDiaUtil;
begin
  Result := FPontoSemanal.Quinta;
end;

function TfrmPrincipal.GetSabado: THorarioSabado;
begin
  Result := FPontoSemanal.Sabado;
end;

function TfrmPrincipal.GetSegunda: THorarioDiaUtil;
begin
  Result := FPontoSemanal.Segunda;
end;

function TfrmPrincipal.GetSexta: THorarioDiaUtil;
begin
  Result := FPontoSemanal.Sexta;
end;

function TfrmPrincipal.GetTerca: THorarioDiaUtil;
begin
  Result := FPontoSemanal.Terca;
end;

end.
