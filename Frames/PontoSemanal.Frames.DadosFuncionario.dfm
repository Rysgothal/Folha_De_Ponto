object frmDadosFuncionario: TfrmDadosFuncionario
  Left = 0
  Top = 0
  Width = 543
  Height = 123
  TabOrder = 0
  PixelsPerInch = 96
  object lblTempoExtenso: TLabel
    Left = 186
    Top = 101
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
  object lblIntervaloAlmoco: TLabel
    Left = 6
    Top = 101
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
  object lblJornadaSemanal: TLabel
    Left = 6
    Top = 77
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
  object lblCodigo: TLabel
    Left = 56
    Top = 5
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
    Left = 57
    Top = 29
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
    Left = 43
    Top = 53
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
  object lblAnosMesesSemanasDias: TLabel
    Left = 209
    Top = 54
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
    Left = 148
    Top = 77
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
  object edtIntervaloAlmoco: TEdit
    Left = 102
    Top = 98
    Width = 83
    Height = 23
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 4
    TextHint = 'hh:mm'
    OnChange = edtIntervaloAlmocoChange
    OnExit = edtIntervaloAlmocoExit
  end
  object edtAdmissao: TEdit
    Left = 102
    Top = 50
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
  object edtNome: TEdit
    Left = 102
    Top = 26
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
  object edtCodigo: TEdit
    Left = 102
    Top = 2
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
  object edtJornadaSemanal: TEdit
    Left = 102
    Top = 74
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
end
