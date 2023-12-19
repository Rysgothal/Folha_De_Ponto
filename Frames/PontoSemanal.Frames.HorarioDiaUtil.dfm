object frmHorariosDiaUtil: TfrmHorariosDiaUtil
  Left = 0
  Top = 0
  Width = 538
  Height = 48
  TabOrder = 0
  PixelsPerInch = 96
  object lblDesempenho: TLabel
    Left = 498
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
    Left = 390
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
  object bvlDivisorTotalHoras: TBevel
    Left = 372
    Top = 0
    Width = 4
    Height = 48
    Shape = bsLeftLine
  end
  object lbeEntrada: TLabeledEdit
    Left = 3
    Top = 21
    Width = 81
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 40
    EditLabel.Height = 15
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Entrada'
    EditLabel.ParentBiDiMode = False
    TabOrder = 0
    Text = ''
  end
  object edtSaldoHora: TEdit
    Left = 484
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
  object edtTotalHora: TEdit
    Left = 385
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
    TabOrder = 2
    Text = '  :  '
  end
  object lbeSaidaAlmoco: TLabeledEdit
    Left = 94
    Top = 21
    Width = 81
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 73
    EditLabel.Height = 15
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Sa'#237'da Almo'#231'o'
    EditLabel.ParentBiDiMode = False
    EditLabel.Layout = tlCenter
    TabOrder = 3
    Text = ''
  end
  object lbeRetornoAlmoco: TLabeledEdit
    Left = 186
    Top = 21
    Width = 81
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 87
    EditLabel.Height = 15
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Retorno Almo'#231'o'
    EditLabel.ParentBiDiMode = False
    EditLabel.Layout = tlCenter
    TabOrder = 4
    Text = ''
  end
  object lbeSaidaFinal: TLabeledEdit
    Left = 278
    Top = 21
    Width = 81
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 64
    EditLabel.Height = 15
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = 'Sa'#237'da - Final'
    EditLabel.ParentBiDiMode = False
    EditLabel.Layout = tlCenter
    TabOrder = 5
    Text = ''
  end
end
