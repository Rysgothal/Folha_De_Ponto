object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
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
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object lblCargaSemanalMax: TLabel
    Left = 47
    Top = 125
    Width = 240
    Height = 15
    Caption = 'Carga hor'#225'ria semanal m'#225'x. permitida por Lei'
  end
  object chkTurnosNoturnos: TCheckBox
    Left = 8
    Top = 8
    Width = 105
    Height = 17
    Caption = 'Turnos noturnos'
    TabOrder = 0
  end
  object chkExpedienteSabado: TCheckBox
    Left = 8
    Top = 25
    Width = 185
    Height = 17
    Caption = 'Possui expediente aos s'#225'bados'
    TabOrder = 1
  end
  object edtCargaSemanalMax: TEdit
    Left = 8
    Top = 122
    Width = 33
    Height = 23
    Hint = 'hh'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object chkHorarioAlmocoSabado: TCheckBox
    Left = 8
    Top = 43
    Width = 185
    Height = 17
    Caption = 'Hor'#225'rio de almo'#231'o aos s'#225'bados'
    TabOrder = 3
  end
end
