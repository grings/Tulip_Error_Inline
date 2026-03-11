object TulipErrorInlineFrame: TTulipErrorInlineFrame
  Left = 0
  Top = 0
  Width = 458
  Height = 391
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 32
    Top = 24
    Width = 369
    Height = 65
    Caption = 'Error'
    TabOrder = 0
    object label1: TLabel
      Left = 136
      Top = 30
      Width = 56
      Height = 15
      Caption = 'Font Color'
    end
    object cbxErrorFontColor: TColorBox
      Left = 198
      Top = 26
      Width = 145
      Height = 22
      TabOrder = 0
      OnChange = cbxErrorFontColorChange
    end
    object cbErrorEnabled: TCheckBox
      Left = 16
      Top = 29
      Width = 73
      Height = 17
      Caption = 'Enable'
      TabOrder = 1
      OnClick = cbErrorEnabledClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 32
    Top = 95
    Width = 369
    Height = 65
    Caption = 'Warning'
    TabOrder = 1
    object Label2: TLabel
      Left = 136
      Top = 30
      Width = 56
      Height = 15
      Caption = 'Font Color'
    end
    object cbxWarningFontColor: TColorBox
      Left = 198
      Top = 26
      Width = 145
      Height = 22
      TabOrder = 0
      OnChange = cbxWarningFontColorChange
    end
    object cbWarningEnabled: TCheckBox
      Left = 16
      Top = 29
      Width = 73
      Height = 17
      Caption = 'Enable'
      TabOrder = 1
      OnClick = cbWarningEnabledClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 32
    Top = 166
    Width = 369
    Height = 65
    Caption = 'Hint'
    TabOrder = 2
    object Label3: TLabel
      Left = 136
      Top = 30
      Width = 56
      Height = 15
      Caption = 'Font Color'
    end
    object cbxHintFontColor: TColorBox
      Left = 198
      Top = 26
      Width = 145
      Height = 22
      TabOrder = 0
      OnChange = cbxHintFontColorChange
    end
    object cbHintEnabled: TCheckBox
      Left = 16
      Top = 29
      Width = 73
      Height = 17
      Caption = 'Enable'
      TabOrder = 1
      OnClick = cbHintEnabledClick
    end
  end
end
