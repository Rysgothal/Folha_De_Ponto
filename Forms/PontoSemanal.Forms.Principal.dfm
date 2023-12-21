object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Ponto Semanal'
  ClientHeight = 699
  ClientWidth = 1262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
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
      inherited edtJornadaSemanal: TEdit
        OnExit = frmDadosFuncionarioedtJornadaSemanalExit
      end
    end
  end
  object sttsbarSistemaInfo: TStatusBar
    Left = 0
    Top = 680
    Width = 1262
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    Panels = <
      item
        Text = 'Data do Sistema: 00/00/0000'
        Width = 1150
      end
      item
        Alignment = taCenter
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = '00:00:00'
        Width = 50
      end>
    UseSystemFont = False
    ExplicitTop = 477
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
    inline frmSegunda: TfrmHorariosDiaUtil
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
    end
  end
  object gbxHorasTrabalhadas: TGroupBox
    Left = 559
    Top = 8
    Width = 354
    Height = 90
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
    TabOrder = 3
    TabStop = True
    inline frmHorasTrabalhadasSemana: TfrmSaldoHorasDia
      Left = 2
      Top = 17
      Width = 350
      Height = 71
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 350
      ExplicitHeight = 71
      inherited lblDesempenho: TLabel
        Left = 195
        ExplicitLeft = 195
      end
      inherited lblTotalHora: TLabel
        Left = 287
        Top = 16
        Width = 33
        Height = 36
        Caption = ''
        Font.Height = -33
        Font.Name = 'Wingdings'
        Font.Style = []
        ExplicitLeft = 287
        ExplicitTop = 16
        ExplicitWidth = 33
        ExplicitHeight = 36
      end
      inherited edtTotalHora: TEdit
        Left = 23
        Top = 20
        Width = 103
        Height = 31
        Font.Height = -17
        ExplicitLeft = 23
        ExplicitTop = 20
        ExplicitWidth = 103
        ExplicitHeight = 31
      end
      inherited edtSaldoHora: TEdit
        Left = 155
        Top = 20
        Width = 103
        Height = 31
        Font.Height = -17
        ExplicitLeft = 155
        ExplicitTop = 20
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
    TabOrder = 4
    inline frmTerca: TfrmHorariosDiaUtil
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 26
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
    TabOrder = 5
    inline frmQuarta: TfrmHorariosDiaUtil
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 24
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
    TabOrder = 6
    inline frmQuinta: TfrmHorariosDiaUtil
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
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
    TabOrder = 7
    inline frmSexta: TfrmHorariosDiaUtil
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 26
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
    TabOrder = 8
    inline frmSabado: TfrmHorariosDiaUtil
      Left = 2
      Top = 17
      Width = 541
      Height = 61
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 26
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
  object tmrHorario: TTimer
    Enabled = False
    OnTimer = tmrHorarioTimer
    Left = 496
    Top = 96
  end
end
