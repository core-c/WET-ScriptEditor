object fEditor: TfEditor
  Left = 141
  Top = 90
  Width = 877
  Height = 640
  Caption = 'ET-Script'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterV: TSplitter
    Left = 693
    Top = 25
    Height = 542
    Align = alRight
    Color = clBtnShadow
    ParentColor = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 567
    Width = 869
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 400
      end>
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 869
    Height = 25
    ButtonHeight = 21
    DockSite = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object cbScriptBlocks: TComboBox
      Left = 31
      Top = 2
      Width = 266
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object pFiles: TPanel
    Left = 0
    Top = 25
    Width = 693
    Height = 542
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object SplitterH: TSplitter
      Left = 0
      Top = 48
      Width = 693
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = clBtnShadow
      ParentColor = False
      OnMoved = SplitterHMoved
    end
    object gbFile2: TGroupBox
      Left = 0
      Top = 0
      Width = 693
      Height = 48
      Align = alTop
      Caption = '2nd File'
      TabOrder = 0
      object mMemo: TMemo
        Left = 2
        Top = 15
        Width = 689
        Height = 31
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        PopupMenu = Popup2
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WantTabs = True
        WordWrap = False
      end
    end
    object gbFileMain: TGroupBox
      Left = 0
      Top = 51
      Width = 693
      Height = 491
      Align = alClient
      Caption = 'Main File'
      TabOrder = 1
      object reRTF: TRTF
        Left = 2
        Top = 15
        Width = 689
        Height = 474
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 11
        Font.Name = 'Courier'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        PopupMenu = PopupMain
        ScrollBars = ssBoth
        TabOrder = 0
        WantTabs = True
        WordWrap = False
        OnChange = reRTFChange
        OnKeyUp = reRTFKeyUp
        OnMouseWheel = reRTFMouseWheel
        OnSelectionChange = reRTFSelectionChange
        OnVScroll = reRTFVScroll
        OnResize = reRTFResize
      end
    end
  end
  object pRight: TPanel
    Left = 696
    Top = 25
    Width = 173
    Height = 542
    Align = alRight
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 3
    OnUnDock = pRightUnDock
    object gbCommands: TGroupBox
      Left = 0
      Top = 0
      Width = 173
      Height = 376
      Caption = 'Commands'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 0
      OnStartDock = gbCommandsStartDock
      object lvCommands: TListView
        Left = 2
        Top = 15
        Width = 169
        Height = 359
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            AutoSize = True
            Caption = 'Command'
          end>
        Items.Data = {
          7E0C00005D00000000000000FFFFFFFFFFFFFFFF00000000000000001661626F
          727469666E6F7473696E676C65706C6179657200000000FFFFFFFFFFFFFFFF00
          000000000000000D61626F727469667761726D757000000000FFFFFFFFFFFFFF
          FF00000000000000000961626F72746D6F766500000000FFFFFFFFFFFFFFFF00
          0000000000000005616363756D00000000FFFFFFFFFFFFFFFF00000000000000
          000B61646474616E6B616D6D6F00000000FFFFFFFFFFFFFFFF00000000000000
          000C61697363726970746E616D6500000000FFFFFFFFFFFFFFFF000000000000
          00000B616C657274656E7469747900000000FFFFFFFFFFFFFFFF000000000000
          00000E616C6C6F7774616E6B656E74657200000000FFFFFFFFFFFFFFFF000000
          00000000000D616C6C6F7774616E6B6578697400000000FFFFFFFFFFFFFFFF00
          000000000000000B617474616368746F74616700000000FFFFFFFFFFFFFFFF00
          000000000000000E61747461746368746F747261696E00000000FFFFFFFFFFFF
          FFFF00000000000000000C626F74676562756767696E6700000000FFFFFFFFFF
          FFFFFF00000000000000000B6368616E67656D6F64656C00000000FFFFFFFFFF
          FFFFFF000000000000000009636F6E73747275637400000000FFFFFFFFFFFFFF
          FF00000000000000001A636F6E73747275637469626C655F6368617267656261
          7272657100000000FFFFFFFFFFFFFFFF000000000000000013636F6E73747275
          637469626C655F636C61737300000000FFFFFFFFFFFFFFFF0000000000000000
          1E636F6E73747275637469626C655F636F6E7374727563747870626F6E757300
          000000FFFFFFFFFFFFFFFF00000000000000001D636F6E73747275637469626C
          655F64657374727563747870626F6E757300000000FFFFFFFFFFFFFFFF000000
          000000000016636F6E73747275637469626C655F6475726174696F6E00000000
          FFFFFFFFFFFFFFFF000000000000000014636F6E73747275637469626C655F68
          65616C746800000000FFFFFFFFFFFFFFFF000000000000000019636F6E737472
          75637469626C655F776561706F6E636C61737300000000FFFFFFFFFFFFFFFF00
          00000000000000046376617200000000FFFFFFFFFFFFFFFF0000000000000000
          0E64697361626C656D65737361676500000000FFFFFFFFFFFFFFFF0000000000
          0000000E64697361626C65737065616B657200000000FFFFFFFFFFFFFFFF0000
          0000000000000D656E61626C65737065616B657200000000FFFFFFFFFFFFFFFF
          000000000000000010656E746974797363726970746E616D6500000000FFFFFF
          FFFFFFFFFF00000000000000000A66616365616E676C657300000000FFFFFFFF
          FFFFFFFF00000000000000000D66616465616C6C736F756E647300000000FFFF
          FFFFFFFFFFFF00000000000000000A666F6C6C6F777061746800000000FFFFFF
          FFFFFFFFFF00000000000000000C666F6C6C6F7773706C696E6500000000FFFF
          FFFFFFFFFFFF00000000000000000F667265657A65616E696D6174696F6E0000
          0000FFFFFFFFFFFFFFFF00000000000000000B676C6F62616C616363756D0000
          0000FFFFFFFFFFFFFFFF00000000000000000A676F746F6D61726B6572000000
          00FFFFFFFFFFFFFFFF00000000000000000468616C7400000000FFFFFFFFFFFF
          FFFF0000000000000000046B696C6C00000000FFFFFFFFFFFFFFFF0000000000
          000000076D755F6661646500000000FFFFFFFFFFFFFFFF000000000000000007
          6D755F706C617900000000FFFFFFFFFFFFFFFF0000000000000000086D755F71
          7565756500000000FFFFFFFFFFFFFFFF0000000000000000086D755F73746172
          7400000000FFFFFFFFFFFFFFFF0000000000000000076D755F73746F70000000
          00FFFFFFFFFFFFFFFF000000000000000008706C6179616E696D00000000FFFF
          FFFFFFFFFFFF000000000000000009706C6179736F756E6400000000FFFFFFFF
          FFFFFFFF0000000000000000057072696E7400000000FFFFFFFFFFFFFFFF0000
          0000000000000A7072696E74616363756D00000000FFFFFFFFFFFFFFFF000000
          0000000000107072696E74676C6F62616C616363756D00000000FFFFFFFFFFFF
          FFFF00000000000000000B72656D617073686164657200000000FFFFFFFFFFFF
          FFFF00000000000000001072656D6170736861646572666C75736800000000FF
          FFFFFFFFFFFFFF00000000000000000672656D6F766500000000FFFFFFFFFFFF
          FFFF00000000000000000972656D6F7665626F7400000000FFFFFFFFFFFFFFFF
          00000000000000000A7265706169726D67343200000000FFFFFFFFFFFFFFFF00
          000000000000000B726573657473637269707400000000FFFFFFFFFFFFFFFF00
          000000000000000B736574616173737461746500000000FFFFFFFFFFFFFFFF00
          000000000000000C7365746175746F737061776E00000000FFFFFFFFFFFFFFFF
          000000000000000012736574626F74676F616C7072696F7269747900000000FF
          FFFFFFFFFFFFFF00000000000000000F736574626F74676F616C737461746500
          000000FFFFFFFFFFFFFFFF00000000000000001373657463686172676574696D
          65666163746F7200000000FFFFFFFFFFFFFFFF00000000000000000C73657464
          616D616761626C6500000000FFFFFFFFFFFFFFFF00000000000000000D736574
          64656275676C6576656C00000000FFFFFFFFFFFFFFFF00000000000000000C73
          6574676C6F62616C666F6700000000FFFFFFFFFFFFFFFF00000000000000000B
          736574687173746174757300000000FFFFFFFFFFFFFFFF000000000000000010
          536574496E697469616C43616D65726100000000FFFFFFFFFFFFFFFF00000000
          00000000167365746D6F64656C66726F6D62727573686D6F64656C00000000FF
          FFFFFFFFFFFFFF00000000000000000B736574706F736974696F6E00000000FF
          FFFFFFFFFFFFFF00000000000000000B736574726F746174696F6E00000000FF
          FFFFFFFFFFFFFF000000000000000008736574737065656400000000FFFFFFFF
          FFFFFFFF000000000000000008736574737461746500000000FFFFFFFFFFFFFF
          FF00000000000000000B73657474616E6B616D6D6F00000000FFFFFFFFFFFFFF
          FF000000000000000008737061776E626F7400000000FFFFFFFFFFFFFFFF0000
          0000000000000B737061776E727562626C6500000000FFFFFFFFFFFFFFFF0000
          0000000000000E7374617274616E696D6174696F6E00000000FFFFFFFFFFFFFF
          FF000000000000000008737461727463616D00000000FFFFFFFFFFFFFFFF0000
          0000000000000773746F7063616D00000000FFFFFFFFFFFFFFFF000000000000
          00000C73746F70726F746174696F6E00000000FFFFFFFFFFFFFFFF0000000000
          0000000973746F70736F756E6400000000FFFFFFFFFFFFFFFF00000000000000
          000D746F67676C65737065616B657200000000FFFFFFFFFFFFFFFF0000000000
          000000077472696767657200000000FFFFFFFFFFFFFFFF000000000000000011
          756E667265657A65616E696D6174696F6E00000000FFFFFFFFFFFFFFFF000000
          0000000000047761697400000000FFFFFFFFFFFFFFFF00000000000000001777
          6D5F6164647465616D766F696365616E6E6F756E636500000000FFFFFFFFFFFF
          FFFF000000000000000015776D5F616C6C6965645F7265737061776E74696D65
          00000000FFFFFFFFFFFFFFFF00000000000000000B776D5F616E6E6F756E6365
          00000000FFFFFFFFFFFFFFFF000000000000000010776D5F616E6E6F756E6365
          5F69636F6E00000000FFFFFFFFFFFFFFFF000000000000000013776D5F617869
          735F7265737061776E74696D6500000000FFFFFFFFFFFFFFFF00000000000000
          000B776D5F656E64726F756E6400000000FFFFFFFFFFFFFFFF00000000000000
          0017776D5F6E756D6265725F6F665F6F626A6563746976657300000000FFFFFF
          FFFFFFFFFF000000000000000013776D5F6F626A6563746976655F7374617475
          7300000000FFFFFFFFFFFFFFFF00000000000000001A776D5F72656D6F766574
          65616D766F696365616E6E6F756E636500000000FFFFFFFFFFFFFFFF00000000
          0000000015776D5F7365745F646566656E64696E675F7465616D00000000FFFF
          FFFFFFFFFFFF000000000000000015776D5F7365745F6D61696E5F6F626A6563
          7469766500000000FFFFFFFFFFFFFFFF000000000000000016776D5F7365745F
          726F756E645F74696D656C696D697400000000FFFFFFFFFFFFFFFF0000000000
          0000000C776D5F73657477696E6E657200000000FFFFFFFFFFFFFFFF00000000
          0000000014776D5F7465616D766F696365616E6E6F756E636500000000FFFFFF
          FFFFFFFFFF000000000000000010776D5F766F696365616E6E6F756E6365}
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 376
      Width = 173
      Height = 166
      Caption = 'GroupBox1'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 1
      OnStartDock = GroupBox1StartDock
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 29
        Height = 13
        Caption = 'speed'
      end
      object Edit1: TEdit
        Left = 44
        Top = 18
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'speed'
      end
      object Edit2: TEdit
        Left = 48
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 488
    Top = 16
    object menuFile: TMenuItem
      Caption = '&File'
      object menuFileOpen: TMenuItem
        Caption = '&Open...'
      end
      object N2: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object menuFileSave: TMenuItem
        Caption = '&Save'
        ShortCut = 16467
      end
      object menuFileSaveAs: TMenuItem
        Caption = 'Save&As...'
      end
      object N3: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object menuFileExit: TMenuItem
        Caption = 'E&xit'
      end
    end
    object menuEdit: TMenuItem
      Caption = '&Edit'
      object menuEditCopy: TMenuItem
        Caption = 'Copy'
        ShortCut = 16451
      end
      object menuEditPaste: TMenuItem
        Caption = 'Paste'
        ShortCut = 16470
      end
      object N1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object menuEditCopyScriptblock: TMenuItem
        Caption = 'Copy Scriptblock'
        ShortCut = 49219
      end
    end
    object menuFormat: TMenuItem
      Caption = '&Format'
      object menuFormatWordWrap: TMenuItem
        AutoCheck = True
        Caption = '&WordWrap'
        Enabled = False
        OnClick = menuFormatWordWrapClick
      end
      object N4: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object menuFormatTabwidth: TMenuItem
        Caption = '&Tab Width'
        object menuFormatTabwidth2: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '2'
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth3: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '3'
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth4: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '4'
          Checked = True
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth5: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '5'
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth6: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '6'
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth7: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '7'
          GroupIndex = 1
          RadioItem = True
        end
        object menuFormatTabwidth8: TMenuItem
          Action = ActionSetTabWidth
          AutoCheck = True
          Caption = '8'
          GroupIndex = 1
          RadioItem = True
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuFormatColors: TMenuItem
        Action = ActionChooseColors
      end
    end
    object MenuView: TMenuItem
      Caption = '&View'
      object MenuViewCommands: TMenuItem
        Caption = '&Commands'
        OnClick = MenuViewCommandsClick
      end
      object MenuViewGroupBox1: TMenuItem
        Caption = '<GroupBox1>'
        OnClick = MenuViewGroupBox1Click
      end
    end
    object menuHelp: TMenuItem
      Caption = '&Help'
      object menuHelpAbout: TMenuItem
        Caption = '&About...'
      end
    end
  end
  object Popup2: TPopupMenu
    Left = 552
    Top = 16
    object popup2Open: TMenuItem
      Caption = 'Open...'
      OnClick = popup2OpenClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'script'
    Filter = 'ET script|*.script|Any file|*.*'
    Title = 'Load ET script'
    Left = 584
    Top = 16
  end
  object PopupMain: TPopupMenu
    Left = 520
    Top = 16
    object popupMainOpen: TMenuItem
      Caption = 'Open...'
      OnClick = popupMainOpenClick
    end
  end
  object ActionList: TActionList
    Left = 616
    Top = 16
    object ActionHighLight: TAction
      Caption = 'HighLight'
      OnExecute = ActionHighLightExecute
    end
    object ActionChooseColors: TAction
      Caption = '&Colors...'
      OnExecute = ActionChooseColorsExecute
    end
    object ActionSetTabWidth: TAction
      Caption = 'Tab Width'
      OnExecute = ActionSetTabWidthExecute
    end
  end
  object ColorDialog: TColorDialog
    Left = 584
    Top = 45
  end
end
