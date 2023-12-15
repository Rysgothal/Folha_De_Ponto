object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registro de Ponto Semanal'
  ClientHeight = 496
  ClientWidth = 1017
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
      OnExit = edtNomeExit
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
    end
    object edtIntervaloAlmoco: TEdit
      Left = 106
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
    end
  end
  object sttsbarSistemaInfo: TStatusBar
    Left = 0
    Top = 477
    Width = 1017
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
  end
  object tmrHorario: TTimer
    Enabled = False
    OnTimer = tmrHorarioTimer
    Left = 504
    Top = 112
  end
end
