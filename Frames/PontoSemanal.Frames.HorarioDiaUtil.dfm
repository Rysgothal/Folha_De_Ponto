object frmHorariosDia: TfrmHorariosDia
  Left = 0
  Top = 0
  Width = 547
  Height = 54
  TabOrder = 0
  OnExit = FrameExit
  PixelsPerInch = 96
  object bvlDivisorTotalHoras: TBevel
    Left = 368
    Top = 0
    Width = 4
    Height = 48
    Shape = bsLeftLine
  end
  object lblSaidaFinal: TLabel
    Left = 286
    Top = 0
    Width = 64
    Height = 15
    Caption = 'Sa'#237'da - Final'
  end
  object lblRetornoAlmoco: TLabel
    Left = 184
    Top = 0
    Width = 85
    Height = 15
    Caption = 'Retorno almo'#231'o'
  end
  object lblSaidaAlmoco: TLabel
    Left = 99
    Top = 0
    Width = 71
    Height = 15
    Caption = 'Sa'#237'da almo'#231'o'
  end
  object lblEntrada: TLabel
    Left = 23
    Top = 0
    Width = 40
    Height = 15
    Caption = 'Entrada'
  end
  object medEntrada: TMaskEdit
    Left = 7
    Top = 21
    Width = 72
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
    OnExit = medEntradaExit
  end
  object medSaidaAlmoco: TMaskEdit
    Left = 98
    Top = 21
    Width = 72
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
    OnExit = medSaidaAlmocoExit
  end
  object medRetornoAlmoco: TMaskEdit
    Left = 190
    Top = 21
    Width = 72
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
    OnExit = medRetornoAlmocoExit
  end
  object medSaidaFinal: TMaskEdit
    Left = 282
    Top = 21
    Width = 72
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
    OnExit = medSaidaFinalExit
  end
  inline frmSaldoHorasDia: TfrmSaldoHorasDia
    Left = 382
    Top = 0
    Width = 149
    Height = 48
    TabOrder = 4
    ExplicitLeft = 382
  end
end
