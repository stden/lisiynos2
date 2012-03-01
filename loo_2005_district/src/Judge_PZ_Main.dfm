object F: TF
  Left = 218
  Top = 137
  Width = 684
  Height = 425
  Caption = #1051#1077#1085#1080#1085#1075#1088#1072#1076#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1085#1072#1103' '#1086#1083#1080#1084#1087#1080#1072#1076#1072' 2004-2005. '#1056#1072#1081#1086#1085#1085#1099#1081' '#1090#1091#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 676
    Height = 391
    ActivePage = Main
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Main: TTabSheet
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072
      object Label1: TLabel
        Left = 8
        Top = 101
        Width = 127
        Height = 16
        Caption = #1048#1084#1103' '#1074#1093#1086#1076#1085#1086#1075#1086' '#1092#1072#1081#1083#1072':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 125
        Width = 136
        Height = 16
        Caption = #1048#1084#1103' '#1074#1099#1093#1086#1076#1085#1086#1075#1086' '#1092#1072#1081#1083#1072':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 157
        Width = 101
        Height = 16
        Caption = #1051#1080#1084#1080#1090' '#1087#1086' '#1087#1072#1084#1103#1090#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 8
        Top = 181
        Width = 109
        Height = 16
        Caption = #1051#1080#1084#1080#1090' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 208
        Width = 66
        Height = 16
        Caption = 'CheckerFile'
        Visible = False
      end
      object Label9: TLabel
        Left = 8
        Top = 232
        Width = 89
        Height = 16
        Caption = 'ResultExtension'
        Visible = False
      end
      object Label10: TLabel
        Left = 8
        Top = 256
        Width = 97
        Height = 16
        Caption = 'AnswerExtension'
        Visible = False
      end
      object Label12: TLabel
        Left = 8
        Top = 280
        Width = 78
        Height = 16
        Caption = 'TaskDirectory'
        Visible = False
      end
      object Label13: TLabel
        Left = 8
        Top = 304
        Width = 58
        Height = 16
        Caption = 'TestName'
        Visible = False
      end
      object Label11: TLabel
        Left = 328
        Top = 328
        Width = 88
        Height = 16
        Caption = #1057#1091#1084#1084#1072' '#1073#1072#1083#1083#1086#1074':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object _MemoryLimit_Mesure: TLabel
        Left = 248
        Top = 157
        Width = 14
        Height = 16
        Caption = #1050#1073
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object _TimeLimit_Mesure: TLabel
        Left = 248
        Top = 181
        Width = 14
        Height = 16
        Caption = #1084#1089
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 44
        Width = 262
        Height = 16
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' .EXE '#1092#1072#1081#1083' '#1088#1077#1096#1077#1085#1080#1103' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1088#1082#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 8
        Top = 21
        Width = 106
        Height = 16
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1079#1072#1076#1072#1095#1091':'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object _BallsFactor: TLabel
        Left = 384
        Top = 24
        Width = 4
        Height = 16
      end
      object SelectTask: TComboBox
        Left = 136
        Top = 16
        Width = 209
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 12
        OnChange = SelectTaskChange
        Items.Strings = (
          'A. '#1050#1086#1088#1086#1083#1077#1074#1089#1090#1074#1086
          'B. '#1048#1085#1076#1080#1081#1089#1082#1080#1081' '#1084#1077#1090#1086#1076
          'C. '#1043#1088#1091#1087#1087#1099
          'D. '#1056#1080#1084#1089#1082#1072#1103' '#1089#1080#1089#1090#1077#1084#1072' '#1089#1095#1080#1089#1083#1077#1085#1080#1103)
      end
      object Run: TBitBtn
        Left = 16
        Top = 247
        Width = 289
        Height = 25
        Caption = '&'#1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1088#1077#1096#1077#1085#1080#1077' '#1080' '#1087#1086#1076#1089#1095#1080#1090#1072#1090#1100' '#1073#1072#1083#1083#1099
        Enabled = False
        TabOrder = 0
        OnClick = RunClick
        Kind = bkAll
      end
      object InputFile: TEdit
        Left = 152
        Top = 96
        Width = 153
        Height = 24
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Text = 'input.txt'
      end
      object OutputFile: TEdit
        Left = 152
        Top = 120
        Width = 153
        Height = 24
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
        Text = 'output.txt'
      end
      object _MemoryLimit: TRxSpinEdit
        Left = 144
        Top = 152
        Width = 97
        Height = 24
        Value = 65536.000000000000000000
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 3
        OnChange = _MemoryLimitChange
      end
      object _TimeLimit: TRxSpinEdit
        Left = 144
        Top = 176
        Width = 97
        Height = 24
        Value = 1000.000000000000000000
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 4
        OnChange = _TimeLimitChange
      end
      object CheckerFile: TEdit
        Left = 104
        Top = 200
        Width = 121
        Height = 22
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        Text = 'check.exe'
        Visible = False
      end
      object ResultExtension: TEdit
        Left = 104
        Top = 224
        Width = 121
        Height = 22
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
        Text = 'u'
        Visible = False
      end
      object AnswerExtension: TEdit
        Left = 104
        Top = 248
        Width = 121
        Height = 22
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 7
        Text = 'a'
        Visible = False
      end
      object TaskDirectory: TEdit
        Left = 104
        Top = 272
        Width = 121
        Height = 22
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 8
        Visible = False
      end
      object TestName: TEdit
        Left = 104
        Top = 296
        Width = 121
        Height = 22
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 9
        Visible = False
      end
      object TestResults: TStringGrid
        Left = 320
        Top = 96
        Width = 337
        Height = 217
        ColCount = 3
        Ctl3D = True
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        ParentCtl3D = False
        TabOrder = 10
        ColWidths = (
          28
          190
          64)
      end
      object Summary_result: TEdit
        Left = 424
        Top = 320
        Width = 129
        Height = 24
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 11
        Text = #1047#1072#1087#1091#1089#1090#1080#1090#1077' '#1087#1088#1086#1074#1077#1088#1082#1091
      end
      object ProgramName: TFilenameEdit
        Left = 24
        Top = 64
        Width = 625
        Height = 21
        Filter = '.EXE '#1092#1072#1081#1083#1099' (*.EXE)|*.EXE'
        NumGlyphs = 1
        TabOrder = 13
        Text = #1042#1099#1073#1077#1088#1080#1090#1077' .EXE '#1092#1072#1081#1083' '#1091#1095#1072#1089#1090#1085#1080#1082#1072
        OnChange = ProgramNameChange
      end
    end
    object Log: TTabSheet
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
      ImageIndex = 1
      object LogList: TMemo
        Left = 0
        Top = 152
        Width = 568
        Height = 193
        Lines.Strings = (
          'LogList')
        TabOrder = 0
      end
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 668
        Height = 360
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      Enabled = False
      ImageIndex = 2
      object Label15: TLabel
        Left = 200
        Top = 168
        Width = 155
        Height = 19
        Caption = #1055#1086#1082#1072' '#1085#1077' '#1088#1072#1079#1088#1072#1073#1086#1090#1072#1085#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object CopyTestFiles: TCheckBox
        Left = 16
        Top = 8
        Width = 97
        Height = 17
        Caption = 'CopyTestFiles'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 0
        Visible = False
      end
      object CheckResult: TCheckBox
        Left = 16
        Top = 32
        Width = 97
        Height = 17
        Caption = 'CheckResult'
        Checked = True
        Ctl3D = False
        Enabled = False
        ParentCtl3D = False
        State = cbChecked
        TabOrder = 1
        Visible = False
      end
      object ExitOnTestFail: TCheckBox
        Left = 16
        Top = 56
        Width = 97
        Height = 17
        Caption = 'ExitOnTestFail'
        Ctl3D = False
        Enabled = False
        ParentCtl3D = False
        TabOrder = 2
        Visible = False
      end
      object WaitOnExit: TCheckBox
        Left = 16
        Top = 80
        Width = 97
        Height = 17
        Caption = 'WaitOnExit'
        Ctl3D = False
        Enabled = False
        ParentCtl3D = False
        TabOrder = 3
        Visible = False
      end
      object Compile: TGroupBox
        Left = 183
        Top = 8
        Width = 241
        Height = 145
        Caption = ' Compile '
        Enabled = False
        TabOrder = 4
        Visible = False
        object Label7: TLabel
          Left = 8
          Top = 124
          Width = 94
          Height = 16
          Caption = 'SourceExtension'
        end
        object Label8: TLabel
          Left = 8
          Top = 76
          Width = 109
          Height = 16
          Caption = 'CompilerCommand'
        end
        object CompileAlways: TCheckBox
          Left = 32
          Top = 56
          Width = 257
          Height = 17
          Caption = 'CompileAlways - '#1087#1077#1088#1077#1082#1086#1084#1087#1080#1083#1080#1088#1086#1074#1072#1090#1100' exe-'#1096#1085#1080#1082
          TabOrder = 0
        end
        object CompilerCommand: TEdit
          Left = 112
          Top = 68
          Width = 121
          Height = 22
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          Text = 'dcc32.exe -cc'
        end
        object CompileSolution: TCheckBox
          Left = 8
          Top = 24
          Width = 289
          Height = 17
          Caption = 'CompileSolution - '#1082#1086#1084#1087#1080#1083#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1096#1077#1085#1080#1077
          TabOrder = 2
        end
        object SourceExtension: TEdit
          Left = 112
          Top = 116
          Width = 121
          Height = 22
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
          Text = 'dpr'
        end
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 516
    Top = 24
  end
end
