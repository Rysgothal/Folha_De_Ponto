object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Ponto Semanal'
  ClientHeight = 699
  ClientWidth = 1209
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object gbxDadosFuncionario: TGroupBox
    Left = 8
    Top = 8
    Width = 545
    Height = 145
    Caption = 'Dados do Funcion'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    inline frmDadosFuncionario: TfrmDadosFuncionario
      Left = 2
      Top = 17
      Width = 541
      Height = 126
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 126
      inherited edtNome: TEdit
        Width = 426
        ExplicitWidth = 426
      end
      inherited edtJornadaSemanal: TEdit
        Text = '44'
        OnExit = frmDadosFuncionarioedtJornadaSemanalExit
      end
    end
  end
  object sttsbarSistemaInfo: TStatusBar
    Left = 0
    Top = 680
    Width = 1209
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    Panels = <
      item
        Text = 'Data do Sistema: 00/00/0000'
        Width = 1100
      end
      item
        Alignment = taCenter
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = '00:00:00'
        Width = 50
      end>
    UseSystemFont = False
  end
  object gbxSeg: TGroupBox
    Left = 8
    Top = 160
    Width = 545
    Height = 74
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
    TabOrder = 2
    inline frmSegunda: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 55
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 55
      inherited medEntrada: TMaskEdit
        Width = 71
        Text = '22:00'
        ExplicitWidth = 71
      end
      inherited medSaidaAlmoco: TMaskEdit
        Width = 71
        Text = '01:30'
        ExplicitWidth = 71
      end
      inherited medRetornoAlmoco: TMaskEdit
        Width = 71
        Text = '02:30'
        ExplicitWidth = 71
      end
      inherited medSaidaFinal: TMaskEdit
        Width = 71
        Text = '08:00'
        ExplicitWidth = 71
      end
    end
  end
  object gbxHorasTrabalhadas: TGroupBox
    Left = 561
    Top = 8
    Width = 354
    Height = 114
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
    TabOrder = 8
    TabStop = True
    inline frmHorasTrabalhadasSemana: TfrmSaldoHorasDia
      Left = 2
      Top = 17
      Width = 350
      Height = 95
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 350
      ExplicitHeight = 95
      inherited lblDesempenho: TLabel
        Left = 196
        Top = 5
        ExplicitLeft = 196
        ExplicitTop = 5
      end
      inherited lblTotalHora: TLabel
        Left = 288
        Top = 30
        Width = 33
        Height = 36
        Caption = ''
        Font.Height = -33
        Font.Name = 'Wingdings'
        Font.Style = []
        ExplicitLeft = 288
        ExplicitTop = 30
        ExplicitWidth = 33
        ExplicitHeight = 36
      end
      inherited edtTotalHora: TEdit
        Left = 27
        Top = 32
        Width = 103
        Height = 31
        Font.Height = -17
        ExplicitLeft = 27
        ExplicitTop = 32
        ExplicitWidth = 103
        ExplicitHeight = 31
      end
      inherited edtSaldoHora: TEdit
        Left = 155
        Top = 32
        Width = 103
        Height = 31
        Font.Height = -17
        ExplicitLeft = 155
        ExplicitTop = 32
        ExplicitWidth = 103
        ExplicitHeight = 31
      end
    end
  end
  object gbxTer: TGroupBox
    Left = 8
    Top = 241
    Width = 545
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
    TabOrder = 3
    inline frmTerca: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 61
    end
  end
  object gbxQua: TGroupBox
    Left = 8
    Top = 328
    Width = 545
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
    TabOrder = 4
    inline frmQuarta: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 61
    end
  end
  object gbxQui: TGroupBox
    Left = 8
    Top = 415
    Width = 545
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
    TabOrder = 5
    inline frmQuinta: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 61
    end
  end
  object gbxSex: TGroupBox
    Left = 8
    Top = 502
    Width = 545
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
    TabOrder = 6
    inline frmSexta: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 61
    end
  end
  object gbxSab: TGroupBox
    Left = 8
    Top = 589
    Width = 545
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
    TabOrder = 7
    inline frmSabado: TfrmHorariosDia
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 541
      ExplicitHeight = 61
      inherited lblRetornoAlmoco: TLabel
        Enabled = False
      end
      inherited lblSaidaAlmoco: TLabel
        Enabled = False
      end
      inherited medSaidaAlmoco: TMaskEdit
        Enabled = False
      end
      inherited medRetornoAlmoco: TMaskEdit
        Enabled = False
      end
    end
  end
  object memHistHorario: TMemo
    Left = 559
    Top = 124
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
    TabOrder = 9
  end
  object btnNovoRegistro: TButton
    Tag = 1
    Left = 952
    Top = 87
    Width = 228
    Height = 34
    Caption = '&Novo Registro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 2
    Images = dtmPrincipal.imglistIcones
    ParentFont = False
    TabOrder = 10
    OnClick = btnNovoRegistroClick
  end
  object btnCarregarHist: TButton
    Left = 952
    Top = 51
    Width = 228
    Height = 34
    BiDiMode = bdLeftToRight
    Caption = '&Carregar Hist'#243'rico'
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 1
    Images = dtmPrincipal.imglistIcones
    ParentBiDiMode = False
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 11
    OnClick = btnCarregarHistClick
  end
  object btnGerSalHist: TButton
    Left = 952
    Top = 16
    Width = 228
    Height = 34
    Caption = '&Gerar e Salvar Hist'#243'rico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ImageIndex = 0
    Images = dtmPrincipal.imglistIcones
    ParentFont = False
    TabOrder = 12
    OnClick = btnGerSalHistClick
  end
  object btnConfiguracoes: TBitBtn
    Left = 516
    Top = 121
    Width = 28
    Height = 25
    ImageIndex = 3
    Images = dtmPrincipal.imglistIcones
    TabOrder = 13
    OnClick = btnConfiguracoesClick
  end
  object tmrHorario: TTimer
    Enabled = False
    OnTimer = tmrHorarioTimer
    Left = 440
    Top = 112
  end
end
