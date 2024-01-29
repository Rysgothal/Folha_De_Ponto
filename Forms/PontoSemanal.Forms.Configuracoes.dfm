object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Folha de Ponto - Configura'#231#245'es'
  ClientHeight = 148
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblCargaSemanalMax: TLabel
    Left = 52
    Top = 48
    Width = 240
    Height = 15
    Caption = 'Carga hor'#225'ria semanal m'#225'x. permitida por Lei'
  end
  object chkHorarioAlmocoSabado: TCheckBox
    Left = 8
    Top = 6
    Width = 185
    Height = 17
    Caption = 'Hor'#225'rio de almo'#231'o aos s'#225'bados'
    TabOrder = 0
  end
  object chkAutoCompletar: TCheckBox
    Left = 8
    Top = 23
    Width = 257
    Height = 17
    Hint = 'Nem sempre os hor'#225'rios ir'#227'o ficar corretamente preenchidos'
    Caption = 'Auto-Completar campos vazios ("_") com "0"'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object edtCargaSemanalMax: TEdit
    Left = 8
    Top = 44
    Width = 42
    Height = 23
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TextHint = 'hh'
    OnChange = edtCargaSemanalMaxChange
  end
  object btnDistribuirHorarios: TButton
    Left = 8
    Top = 119
    Width = 113
    Height = 25
    Caption = 'Distribuir Hor'#225'rios'
    TabOrder = 3
    OnClick = btnDistribuirHorariosClick
  end
  object btnConfirmar: TButton
    Left = 297
    Top = 119
    Width = 73
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 4
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TButton
    Left = 233
    Top = 119
    Width = 62
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
end
