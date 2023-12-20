object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Ponto Semanal'
  ClientHeight = 496
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
    end
  end
  object sttsbarSistemaInfo: TStatusBar
    Left = 0
    Top = 477
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
        Width = 900
      end
      item
        Alignment = taCenter
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = '00:00:00'
        Width = 50
      end>
    UseSystemFont = False
    ExplicitWidth = 1017
  end
  object gbxSeg: TGroupBox
    Left = 8
    Top = 159
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
      ExplicitTop = 16
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
  object tmrHorario: TTimer
    Enabled = False
    OnTimer = tmrHorarioTimer
    Left = 488
    Top = 96
  end
end
