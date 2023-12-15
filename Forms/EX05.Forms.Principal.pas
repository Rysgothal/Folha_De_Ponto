unit EX05.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, System.StrUtils, Ex05.Classes.Horarios, System.SysUtils;

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
    Button1: TButton;
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
    procedure CalcularTempoRegistroAdmissao;
    procedure EscreverIntervaloAlmocoExtenso;
    procedure AtualizarTotalDeHorasSemanal;
    procedure AtualizarValoresTotalDeHorasSemana(pDia: THorarioBase; pGroupBox: TGroupBox; pCargaHoraria: Integer);
    procedure AtualizarComponentesTotalHoras(vDiaSemana: THorarioBase; vHoraDif, vTotalHora: string; vLabel: TLabel;
      vEditHoraDif, vEditTotalHora: TEdit);
    procedure InserirJornadaSemanal;
    procedure TratarExceptionsDiaUtil(pException: Exception; pEditSaidaAlmoco, pEditRetornoAlmoco,
      pEditAtual: TCustomEdit; pDia: THorarioDiaUtil);
    procedure TratarExceptionsSabado(pException: Exception; pEditAtual: TCustomEdit);
    procedure GerarHistorico;
    procedure PreencherMemoPontoSemanal;
    procedure PreencherMemoCadaDiaSemana(pDia: THorarioDiaUtil; pNomeDiaSemana: string);
    procedure PreencherMemoSabado;
    procedure PreencherMemoRodape;
    procedure SalvarFolhaDePontoArquivo;

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
    function VerificarTodosCampoPreenchidos: Boolean;
    function VerificarTodosGroupBoxSemanaVazios: Boolean;

    const REGEX = '';
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Avaliacao.Helpers.Funcoes, System.DateUtils, System.RegularExpressions;

{$R *.dfm}

procedure TfrmPrincipal.PermitirSomenteNumeros(const pEdit: TCustomEdit);
begin
  pEdit.Text := Tfuncoes.SomenteNumeros(pEdit.Text);
end;

procedure TfrmPrincipal.PreencherMemoCadaDiaSemana(pDia: THorarioDiaUtil; pNomeDiaSemana: string);
begin
  memHistHorario.Lines.Add(' |' + pNomeDiaSemana.PadRight(16, ' ') + '|  ' + pDia.Entrada + '  |    ' + pDia.SaidaAlmoco
    + '     |     ' + pDia.RetornoAlmoco + '      |    ' + pDia.SaidaFinal + '    |    ' +
    pDia.CargoHoras.HorasTrabalhadas + '    | ');
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
  PreencherMemoCadaDiaSemana(Terca, 'Terca-Feira');
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
end;

procedure TfrmPrincipal.PreencherMemoSabado;
begin
  memHistHorario.Lines.Add(' | Sabado         |  ' + Sabado.Entrada + '  |      -       |       -        |    ' +
    Sabado.SaidaFinal + '    |    ' + Sabado.CargoHoras.HorasTrabalhadas + '    | ');
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
    AtualizarTotalDeHorasSemanal;
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
    AtualizarTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtQuiSaidaAlmoco, medtQuiRetornoAlmoco, pEdit, Quinta);
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
    AtualizarTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsSabado(E, pEdit);
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
    AtualizarTotalDeHorasSemanal;
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
    AtualizarTotalDeHorasSemanal;
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
    AtualizarTotalDeHorasSemanal;
  except
    on E: Exception do
    begin
      TratarExceptionsDiaUtil(E, medtTerSaidaAlmoco, medtTerRetornoAlmoco, pEdit, Terca);
    end;
  end;
end;

procedure TfrmPrincipal.SalvarFolhaDePontoArquivo;
begin
  try
    svdSalvarMemo.FileName := edtCodigo.Text + '_' + StringReplace(edtNome.Text, ' ', '_', [rfReplaceAll]) + '.txt';

    if not svdSalvarMemo.Execute then
    begin
      Abort;
    end;

    if ExtractFileExt(svdSalvarMemo.FileName) <> '.txt' then
    begin
      Application.MessageBox('O Arquivo não pode ser salvo' + #13 + 'Por favor, verifique a extensão do arquivo!',
        'Extensão do Arquivo Inválido', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    if FileExists(svdSalvarMemo.FileName) then
    begin
      if Application.MessageBox('O Arquivo já existe. Deseja Substitui-lo?', 'Arquivo Existente', MB_YESNO +
        MB_ICONINFORMATION) = ID_YES then
      begin
        memHistHorario.Lines.SaveToFile(svdSalvarMemo.FileName);
      end else
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

function TfrmPrincipal.VerificarTodosCampoPreenchidos: Boolean;
var
  vComponente: TComponent;
  vComponenteText: string;
begin
  Result := True;

  for var I := 0 to ComponentCount - 1 do
  begin
    if not (Components[I] is TEdit) and not (Components[I] is TMaskEdit) then
    begin
      Continue;
    end;

    vComponente := Components[I];

    if (TEdit(vComponente).ReadOnly) or (TMaskEdit(vComponente).ReadOnly) then
    begin
      Continue;
    end;

    vComponenteText := TCustomEdit(vComponente).Text;
    vComponenteText := StringReplace(vComponenteText, '_', '', [rfReplaceAll]);

    if (vComponenteText.Trim = EmptyStr) or (vComponenteText.Trim = ':') then
    begin
      Application.MessageBox(pChar('Seu Campo: ' + RetornarNomeCustomEdit(TCustomEdit(vComponente)) +
        ', está vazio. Porfavor verifique'), 'Campo Vazio', MB_OK + MB_ICONINFORMATION);
      TCustomEdit(vComponente).Clear;
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

  for var I := 0 to ControlCount -1 do
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
  vHorasTrabalhadas := FPontoSemanal.CargoHoras.HorasTrabalhadas;
  vHorasAcumuladas := FPontoSemanal.CargoHoras.HorasAcumuladas;
  vHorasAcumuladas :=  vHorasAcumuladas.PadRight(9, ' ');

  memHistHorario.Lines.Add(' |' + string('Total de horas trabalhas na semana:').PadLeft(77, ' ') + vHorasTrabalhadas +
    '    | ');

  if FPontoSemanal.CargoHoras.Desempenho = dfAlto then
  begin
    memHistHorario.Lines.Add(' |' + string('Horas/minutos faltantes:      -      ').PadLeft(86, ' ') + '| ');
    memHistHorario.Lines.Add(' |' + string('Horas/minutos excedentes:    ').PadLeft(77, ' ') + vHorasAcumuladas + '| ');
  end else
  if FPontoSemanal.CargoHoras.Desempenho = dfBaixo then
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

  if vDiaSemana.CargoHoras.Desempenho = dfAlto then
  begin
    vLabel.Caption := 'é';
    vLabel.Font.Color := $ff0000;
    vEditHoraDif.Font.Color := $ff0000;
    vEditTotalHora.Font.Color := $ff0000;
  end
  else if vDiaSemana.CargoHoras.Desempenho = dfBaixo then
  begin
    vLabel.Caption := 'ê';
    vLabel.Font.Color := $303497;
    vEditHoraDif.Font.Color := $303497;
    vEditTotalHora.Font.Color := $303497;
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

function TfrmPrincipal.VerificarGroupBoxVazio(pGroupBox: TGroupBox): Boolean;
var
  vEditsVazios: Integer;
begin
  Result := False;
  vEditsVazios := 0;

  for var I := 0 to pGroupBox.ControlCount -1 do
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

procedure TfrmPrincipal.AtualizarTotalDeHorasSemanal;
begin
  if VerificarTodosGroupBoxSemanaVazios then
  begin
    edtTotalHoraTrab.Text := ':';
    edtHoraDifTrab.Text := EmptyStr;
    lblHoraTrabRosto.Caption := EmptyStr;
    lblHoraTrabDesemp.Caption := EmptyStr;
    Exit;                                          asdasdasdasdasd
  end;

  edtTotalHoraTrab.Text := FPontoSemanal.CargoHoras.HorasTrabalhadas;
  edtHoraDifTrab.Text := FPontoSemanal.CargoHoras.HorasAcumuladas;
  lblHoraTrabDesemp.Caption := 'J';

  edtHoraDifTrab.Font.Color := clGreen;
  edtTotalHoraTrab.Font.Color := clGreen;
  lblHoraTrabDesemp.Font.Color := clGreen;

  if FPontoSemanal.CargoHoras.Desempenho = dfAlto then
  begin
    lblHoraTrabDesemp.Caption := 'K';
    edtHoraDifTrab.Font.Color := $ff0000;
    edtTotalHoraTrab.Font.Color := $ff0000;
    lblHoraTrabDesemp.Font.Color := $ff0000;
  end;
  if FPontoSemanal.CargoHoras.Desempenho = dfBaixo then
  begin
    lblHoraTrabDesemp.Caption := 'L';
    edtHoraDifTrab.Font.Color := $303497;
    edtTotalHoraTrab.Font.Color := $303497;
    lblHoraTrabDesemp.Font.Color := $303497;
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

  vHoraDif := FormatDateTime('hh:mm', StrTotime(pDia.CargoHoras.HorasAcumuladas));
  vTotalHora := FormatDateTime('hh:mm', StrTotime(pDia.CargoHoras.HorasTrabalhadas));
  AtualizarComponentesTotalHoras(pDia, vHoraDif, vTotalHora, vLabel, vEditHoraDif, vEditTotalHora);
end;

procedure TfrmPrincipal.btnGerSalHistClick(Sender: TObject);
begin
  GerarHistorico;
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

  vAnos := YearsBetween(vDataAdmissao, Date);
  vMeses := MonthsBetween(IncYear(vDataAdmissao, vAnos), Date);
  vSemanas := WeeksBetween(IncMonth(IncYear(vDataAdmissao, vAnos), vMeses), Date);
  vDias := DaysBetween(IncWeek(IncMonth(IncYear(vDataAdmissao, vAnos), vMeses), vSemanas), Date);

  vIdade := TratarPluralDataAdmissao(vAnos, vMeses, vSemanas, vDias);
  lblAnosMesesSemanasDias.Caption := '-> ' + vIdade;
end;

procedure TfrmPrincipal.TimerSistemaTimer(Sender: TObject);
begin
  stbDataHoraSistema.Panels.Items[1].Text := TimeToStr(Now);
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

    Exit;
  end;

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

    Exit;
  end;

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

    Exit;
  end;

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

    Exit;
  end;

  if vClassType = EHorarioZeradoNaoPermitido then
  begin
    MandarMensagemHorarioInvalido('não é aceito zerado', pEditAtual);
    Exit;
  end;

  if vClassType = EHorarioMaiorProximo then
  begin
    MandarMensagemHorarioInvalido('esta maior que um de seus horários posteriores', pEditAtual);
    Exit;
  end;

  if vClassType =  EHorarioMenorAnterior then
  begin
    MandarMensagemHorarioInvalido('esta menor que um de seus horários anteriores', pEditAtual);
    Exit;
  end;

  if vClassType = EHorarioInvalido then
  begin
    MandarMensagemHorarioInvalido('está inválido', pEditAtual);
  end else
  begin
    MandarMensagemFalhaDesconhecida('Houve uma falha inesperada ao inserir seu horário', pEditAtual);
  end;
end;

procedure TfrmPrincipal.TratarExceptionsSabado(pException: Exception; pEditAtual: TCustomEdit);
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
end;

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
  SairCampoSegunda(thEntrada, medtSegEntrada);
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
  if not VerificarTodosCampoPreenchidos then
  begin
    Exit;
  end;

  PreencherMemoPontoSemanal;
  SalvarFolhaDePontoArquivo;
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
