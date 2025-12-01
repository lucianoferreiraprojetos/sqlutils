object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 610
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Memo1: TMemo
    Left = 120
    Top = 32
    Width = 585
    Height = 217
    Lines.Strings = (
      'SELECT * FROM CUSTOMER')
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 120
    Top = 384
    Width = 585
    Height = 169
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object BitBtn1: TBitBtn
    Left = 304
    Top = 288
    Width = 217
    Height = 57
    Caption = 'Executar SQL'
    TabOrder = 2
  end
end
