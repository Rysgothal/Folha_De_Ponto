object frmSaldoHorasDia: TfrmSaldoHorasDia
  Left = 0
  Top = 0
  Width = 149
  Height = 48
  TabOrder = 0
  PixelsPerInch = 96
  object lblDesempenho: TLabel
    Left = 112
    Top = -1
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
  object lblTotalHora: TLabel
    Left = 4
    Top = 0
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
  object edtTotalHora: TEdit
    Left = -1
    Top = 21
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
    TabOrder = 0
    Text = '  :  '
  end
  object edtSaldoHora: TEdit
    Left = 98
    Top = 21
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
    TabOrder = 1
  end
end
