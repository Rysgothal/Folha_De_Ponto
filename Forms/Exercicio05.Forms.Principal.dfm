object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Ponto Semanal'
  ClientHeight = 707
  ClientWidth = 1228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object gbxDadosFuncionario: TGroupBox
    Left = 8
    Top = 8
    Width = 555
    Height = 161
    Caption = 'Dados do Funcion'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 60
      Top = 25
      Width = 42
      Height = 15
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblNome: TLabel
      Left = 61
      Top = 49
      Width = 36
      Height = 15
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblAdmissao: TLabel
      Left = 47
      Top = 73
      Width = 55
      Height = 15
      Alignment = taRightJustify
      Caption = 'Admiss'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblJornadaSemanal: TLabel
      Left = 10
      Top = 97
      Width = 92
      Height = 15
      Alignment = taRightJustify
      Caption = 'Jornada Semanal:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblIntervaloAlmoco: TLabel
      Left = 10
      Top = 121
      Width = 92
      Height = 15
      Alignment = taRightJustify
      Caption = 'Intervalo almo'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblAnosMesesSemanasDias: TLabel
      Left = 213
      Top = 74
      Width = 165
      Height = 15
      Caption = '-> anos; meses; semanas; dias.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblHoras: TLabel
      Left = 152
      Top = 97
      Width = 29
      Height = 15
      Caption = 'horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblTempoExtenso: TLabel
      Left = 190
      Top = 121
      Width = 123
      Height = 15
      Caption = '"x" horas e "y" minutos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 106
      Top = 22
      Width = 98
      Height = 23
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnChange = edtCodigoChange
      OnExit = edtCodigoExit
    end
    object edtNome: TEdit
      Left = 106
      Top = 46
      Width = 434
      Height = 23
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnChange = edtNomeChange
    end
    object edtAdmissao: TEdit
      Left = 106
      Top = 70
      Width = 98
      Height = 23
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      TextHint = 'dd/mm/yyyy'
      OnChange = edtAdmissaoChange
      OnExit = edtAdmissaoExit
    end
    object edtJornadaSemanal: TEdit
      Left = 106
      Top = 94
      Width = 42
      Height = 23
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
      TextHint = 'hh'
      OnChange = edtJornadaSemanalChange
      OnExit = edtJornadaSemanalExit
    end
    object edtIntervaloAlmoco: TEdit
      Left = 108
      Top = 118
      Width = 83
      Height = 23
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      TextHint = 'hh:mm'
      OnChange = edtIntervaloAlmocoChange
      OnExit = edtIntervaloAlmocoExit
    end
  end
  object stbDataHoraSistema: TStatusBar
    Left = 0
    Top = 691
    Width = 1228
    Height = 16
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    Panels = <
      item
        Text = 'Data do Sistema : 00/00/0000'
        Width = 1080
      end
      item
        Alignment = taCenter
        Text = '00:00:00'
        Width = 700
      end>
    UseSystemFont = False
  end
  object gbxHorasTrabalhadas: TGroupBox
    Left = 575
    Top = 8
    Width = 370
    Height = 112
    Caption = 'Horas Trabalhadas (Semana)'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    TabStop = True
    object lblHoraTrabRosto: TLabel
      Left = 301
      Top = 45
      Width = 33
      Height = 36
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object lblHoraTrabDesemp: TLabel
      Left = 217
      Top = 19
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object edtTotalHoraTrab: TEdit
      Left = 39
      Top = 47
      Width = 103
      Height = 31
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '  :  '
    end
    object edtHoraDifTrab: TEdit
      Left = 176
      Top = 47
      Width = 103
      Height = 31
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object gbxSeg: TGroupBox
    Left = 8
    Top = 174
    Width = 555
    Height = 80
    Caption = 'Segunda-Feira'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object lblSegEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblSegSaidaAlmoco: TLabel
      Left = 111
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Sa'#237'da almo'#231'o'
    end
    object lblSegRetornoAlmoco: TLabel
      Left = 203
      Top = 22
      Width = 85
      Height = 15
      Caption = 'Retorno almo'#231'o'
    end
    object lblSegSaidaFinal: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblSegTotalHora: TLabel
      Left = 405
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSegDesempenho: TLabel
      Left = 511
      Top = 17
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtSegEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 77
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtSegEntradaExit
    end
    object medtSegSaidaAlmoco: TMaskEdit
      Left = 106
      Top = 43
      Width = 78
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtSegSaidaAlmocoExit
    end
    object medtSegRetornoAlmoco: TMaskEdit
      Left = 204
      Top = 43
      Width = 78
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = medtSegRetornoAlmocoExit
    end
    object medtSegSaidaFinal: TMaskEdit
      Left = 302
      Top = 43
      Width = 78
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnExit = medtSegSaidaFinalExit
    end
    object edtSegTotalHora: TEdit
      Left = 404
      Top = 43
      Width = 88
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
    end
    object edtSegHoraDif: TEdit
      Left = 498
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object gbxTer: TGroupBox
    Left = 8
    Top = 259
    Width = 555
    Height = 80
    Caption = 'Ter'#231'a-Feira'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblTerEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblTerSaidaAlmoco: TLabel
      Left = 111
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Sa'#237'da almo'#231'o'
    end
    object lblTerRetornoAlmoco: TLabel
      Left = 203
      Top = 22
      Width = 85
      Height = 15
      Caption = 'Retorno almo'#231'o'
    end
    object lblTerSaidaFinal: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblTerTotalHora: TLabel
      Left = 405
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTerDesempenho: TLabel
      Left = 511
      Top = 15
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtTerEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtTerEntradaExit
    end
    object medtTerSaidaAlmoco: TMaskEdit
      Left = 106
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtTerSaidaAlmocoExit
    end
    object medtTerRetornoAlmoco: TMaskEdit
      Left = 204
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = medtTerRetornoAlmocoExit
    end
    object medtTerSaidaFinal: TMaskEdit
      Left = 302
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnExit = medtTerSaidaFinalExit
    end
    object edtTerTotalHora: TEdit
      Left = 404
      Top = 43
      Width = 88
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
    end
    object edtTerHoraDif: TEdit
      Left = 498
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object gbxQua: TGroupBox
    Left = 8
    Top = 344
    Width = 555
    Height = 80
    Caption = 'Quarta-Feira'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object lblQuaEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblQuaSaidaAlmoco: TLabel
      Left = 111
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Sa'#237'da almo'#231'o'
    end
    object lblQuaRetornoAlmoco: TLabel
      Left = 203
      Top = 22
      Width = 85
      Height = 15
      Caption = 'Retorno almo'#231'o'
    end
    object lblQuaSaidaFinal: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblQuaTotalHora: TLabel
      Left = 405
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuaDesempenho: TLabel
      Left = 511
      Top = 15
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtQuaEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtQuaEntradaExit
    end
    object medtQuaSaidaAlmoco: TMaskEdit
      Left = 106
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtQuaSaidaAlmocoExit
    end
    object medtQuaRetornoAlmoco: TMaskEdit
      Left = 204
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = medtQuaRetornoAlmocoExit
    end
    object medtQuaSaidaFinal: TMaskEdit
      Left = 302
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnExit = medtQuaSaidaFinalExit
    end
    object edtQuaTotalHora: TEdit
      Left = 405
      Top = 43
      Width = 87
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
    end
    object edtQuaHoraDif: TEdit
      Left = 498
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object gbxQui: TGroupBox
    Left = 8
    Top = 429
    Width = 555
    Height = 80
    Caption = 'Quinta-Feira'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object lblQuiEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblQuiSaidaAlmoco: TLabel
      Left = 111
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Sa'#237'da almo'#231'o'
    end
    object lblQuiRetornoAlmoco: TLabel
      Left = 203
      Top = 22
      Width = 85
      Height = 15
      Caption = 'Retorno almo'#231'o'
    end
    object lblQuiSaidaFinal: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblQuiTotalHora: TLabel
      Left = 405
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuiDesempenho: TLabel
      Left = 511
      Top = 16
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtQuiEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtQuiEntradaExit
    end
    object medtQuiSaidaAlmoco: TMaskEdit
      Left = 106
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtQuiSaidaAlmocoExit
    end
    object medtQuiRetornoAlmoco: TMaskEdit
      Left = 204
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = medtQuiRetornoAlmocoExit
    end
    object medtQuiSaidaFinal: TMaskEdit
      Left = 302
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnExit = medtQuiSaidaFinalExit
    end
    object edtQuiTotalHora: TEdit
      Left = 418
      Top = 43
      Width = 87
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
    end
    object edtQuiHoraDif: TEdit
      Left = 498
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object gbxSex: TGroupBox
    Left = 8
    Top = 514
    Width = 555
    Height = 80
    Caption = 'Sexta-Feira'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object lblSexEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblSexSaidaAlmoco: TLabel
      Left = 111
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Sa'#237'da almo'#231'o'
    end
    object lblSexRetornoAlmoco: TLabel
      Left = 204
      Top = 22
      Width = 85
      Height = 15
      Caption = 'Retorno almo'#231'o'
    end
    object lblSexSaidaFinal: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblSexTotalHora: TLabel
      Left = 405
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSexDesempenho: TLabel
      Left = 511
      Top = 15
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtSexEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtSexEntradaExit
    end
    object medtSexSaidaAlmoco: TMaskEdit
      Left = 106
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtSexSaidaAlmocoExit
    end
    object medtSexRetornoAlmoco: TMaskEdit
      Left = 204
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      Text = '  :  '
      OnExit = medtSexRetornoAlmocoExit
    end
    object medtSexSaidaFinal: TMaskEdit
      Left = 302
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnExit = medtSexSaidaFinalExit
    end
    object edtSexTotalHora: TEdit
      Left = 404
      Top = 43
      Width = 88
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
    end
    object edtSexHoraDif: TEdit
      Left = 498
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object gbxSab: TGroupBox
    Left = 8
    Top = 600
    Width = 417
    Height = 80
    Caption = 'S'#225'bado'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lblSabEntrada: TLabel
      Left = 28
      Top = 22
      Width = 40
      Height = 15
      Caption = 'Entrada'
    end
    object lblSabSaidaFinal: TLabel
      Left = 114
      Top = 22
      Width = 64
      Height = 15
      Caption = 'Sa'#237'da - Final'
    end
    object lblSabTotalHora: TLabel
      Left = 213
      Top = 22
      Width = 79
      Height = 15
      Caption = 'Total de Horas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSabDesempenho: TLabel
      Left = 332
      Top = 13
      Width = 20
      Height = 22
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
    end
    object medtSabEntrada: TMaskEdit
      Left = 8
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '  :  '
      OnExit = medtSabEntradaExit
    end
    object medtSabSaidaFinal: TMaskEdit
      Left = 106
      Top = 43
      Width = 80
      Height = 23
      Alignment = taCenter
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnExit = medtSabSaidaFinalExit
    end
    object edtSabTotalHora: TEdit
      Left = 208
      Top = 43
      Width = 88
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '  :  '
    end
    object edtSabHoraDif: TEdit
      Left = 318
      Top = 43
      Width = 48
      Height = 23
      TabStop = False
      Alignment = taCenter
      BevelInner = bvSpace
      BevelKind = bkSoft
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
  end
  object memHistHorario: TMemo
    Left = 569
    Top = 142
    Width = 643
    Height = 543
    TabStop = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    Color = clInfoBk
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    CanUndoSelText = True
    ReadOnly = True
    ShowHint = False
    TabOrder = 10
  end
  object btnGerSalHist: TButton
    Left = 999
    Top = 8
    Width = 173
    Height = 33
    Caption = '&Gerar e Salvar Hist'#243'rico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 1
    Images = ImagensBotão
    ParentFont = False
    TabOrder = 7
    OnClick = btnGerSalHistClick
  end
  object btnCarregarHist: TButton
    Left = 999
    Top = 49
    Width = 173
    Height = 33
    BiDiMode = bdLeftToRight
    Caption = '&Carregar Hist'#243'rico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 2
    Images = ImagensBotão
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 8
    OnClick = btnCarregarHistClick
  end
  object btnNovoRegistro: TButton
    Tag = 1
    Left = 999
    Top = 88
    Width = 173
    Height = 33
    Caption = '&Novo Registro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 0
    Images = ImagensBotão
    ParentFont = False
    TabOrder = 9
    OnClick = btnNovoRegistroClick
  end
  object TimerSistema: TTimer
    Interval = 500
    OnTimer = TimerSistemaTimer
    Left = 632
    Top = 616
  end
  object ImagensBotão: TImageList
    Left = 712
    Top = 616
    Bitmap = {
      494C010104000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000002D00000000000000000000000000000000000000FA0000
      00000000000000000000000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000F000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000F000000000000000000000000000000000000000000000
      0000000000C60000000000000000000000000000000000000000000000000000
      00FF0000005500000000000000000000000000000000000000FF000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000090000000000000000000000000000000FF0000
      009F0000007F0000007F0000007F0000007F0000007F0000007F0000007F0000
      007F0000009F000000FF00000000000000000000000000000000000000FF0000
      009F0000007F0000007F0000007F0000007F0000007F0000007F0000007F0000
      007F0000009F000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000380000000000000000000000000000
      0000000000AF00000049000000000000000000000000000000FF000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      0040000000000000000000000000000000000000000000000000000000000000
      000000000040000000FF00000000000000000000000000000000000000FF0000
      0040000000000000000000000000000000000000000000000000000000000000
      000000000040000000FF00000000000000000000000000000021000000720000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000FF000000000000000000000000000000FF000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000FF0000
      0040000000000000000000000000000000400000004000000000000000000000
      000000000040000000FF00000000000000000000000000000000000000FF0000
      0040000000000000000000000000000000000000000000000000000000000000
      000000000040000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000EF0000000000000000000000FF000000000000
      00FF000000FF0000000000000000000000000000000000000040000000000000
      00000000000000000000000000FF000000000000000000000000000000BF0000
      0030000000000000000000000000000000FF000000FF00000000000000000000
      000000000030000000BF00000000000000000000000000000000000000BF0000
      0030000000000000000000000000000000FF000000FF00000000000000000000
      000000000030000000BF000000000000000000000000000000D1000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000021000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000013000000000000
      0000000000000000000000000000000000FF000000B600000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      00FF000000FF0000000000000040000000FF000000FF000000FF000000FF0000
      00FF0000000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000100000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000009F000000FF00000000000000FF000000FF00000000000000FF0000
      009F000000000000000000000000000000000000000000000096000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      0000000000A0000000FF00000000000000FF000000FF00000000000000FF0000
      00A0000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000100000
      00000000000000000000000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000FF000000FA00000000000000000000
      00000000000000000000000000FF0000000000000000000000FF000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000AA000000020000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      000000000000000000D3000000000000000000000000000000FF000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000E000000ED00000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000020000000000000000000000000000000000000000000000000000
      007A000000FA0000000000000000000000000000000000000000000000000000
      00AF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000003F0000003F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000AA000000FF0000009E000000120000002A000000D9000000FF0000
      001C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFF8007FFFFFFFFFBDF
      BFFFC003C003F7E7B001C003C003FEF3A001CFF3CFF39E7BA7FDCE73CFF3BE7D
      A7BDCE73CE73BE7DA7BDFE7FFC3FBE7DA7BDFE7FF81FBE7DA40DFE5FF24FBFFD
      A7BDF24FFE5FBE7DA7BDF81FFE7F9E7BA7FDFC3FFE7FDFF3E7FDFE7FFE7FE7E7
      E001FFFFFE7FF00FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object svdSalvarMemo: TSaveDialog
    Filter = 'Hist'#243'rico de Ponto(*.txt)|*.txt'
    InitialDir = 
      'C:\Users\Lucas Souza\Documents\Embarcadero\Studio\Projects\Exerc' +
      #237'cio 05'
    Title = 'Salvar hist'#243'rico do registro de ponto semanal'
    Left = 632
    Top = 568
  end
  object opdCarregarTxt: TOpenDialog
    Filter = 'Hist'#243'rico de Ponto|*.txt'
    InitialDir = 
      'C:\Users\Lucas Souza\Documents\Embarcadero\Studio\Projects\Exerc' +
      #237'cio 05'
    Title = 'Abrir hist'#243'rico do registro de ponto semanal'
    Left = 720
    Top = 568
  end
end
