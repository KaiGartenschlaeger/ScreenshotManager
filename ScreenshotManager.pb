;OnlyOne("ScreenshotManager 2")

XIncludeFile #PB_Compiler_Home + "Include\directory.pbi"

;- FensterIDs
Enumeration
  #TempWindow
  #Hauptfenster
  #InfoFenster
  #FirstStart
EndEnumeration

;- GadgetsIDs
Enumeration
  ;Hauptfenster
  #CheckBox_SKSTRG
  #CheckBox_SKALT
  #Combo_ScreenKey3
  #Radio_BMP
  #Radio_JPG
  #Radio_PNG
  #CheckBox_ExpDir
  #Button_SearchDir_SaveOrt
  #String_DisplayPath
  #Text_SaveIntervall
  #TrackBar_SaveIntervall
  #Text_SaveIntervallDisp
  #CheckBox_SaveIntervall
  #Radio_LO
  #Radio_LU
  #Radio_RO
  #Radio_RU
  #CheckBox_OT
  #CheckBox_AddTimeDate
  #String_OT
  #Button_Font
  #CheckBox_Signalton
  #CheckBox_DeskModeTest
  #CheckBox_AutoClipboardSave
  #Radio_SNTime
  #Radio_SNDate
  #Radio_SNTimeDate
  #Radio_SNNummeriert
  #F3D_ScreenButton
  #F3D_Speicherformat
  #F3D_Speicherort
  #F3D_AutoSpeicher
  #F3D_Hinzufuegen
  #F3D_Optionen
  #F3D_Speichername
  ;Info Fenster
  #Text_Info
  #Image_Info
  #URL_HPage
  ;FirstStart Fenster
  #Image_FirstStart_Info
  #Text_FirstStart_Info1
  #Text_FirstStart_Info2
  #CheckBox_FirstStart_Show
  #Button_FirstStart_OK
EndEnumeration

;- StatusBarIDs
Enumeration
  #StatusBar_Hauptfenster
EndEnumeration

;- MenuIDs
Enumeration
  #Menu_Hauptfenster
  #Menu_Hauptfenster_OpenWindow
  #Menu_Hauptfenster_OpenScreenFolder
  #Menu_Hauptfenster_Info
  #Menu_Hauptfenster_Help
  #Menu_Hauptfenster_ClearClipboard
  #Menu_Hauptfenster_ShowFirstWindow
  #Menu_Hauptfenster_ShowEndMsg
  #Menu_Hauptfenster_ShowSPMsg
  #Menu_Hauptfenster_Beenden
  #Menu_Hauptfenster_MinLanguage ;Muß ganz unten in der Liste sein!
EndEnumeration

;- DateiIDs
Enumeration
  #Screenshot_Save
  #TestFile
  #SaveSound
  #Dir
  #ScreenFont
EndEnumeration

;- Fonts
Global FontID1, FontID2, ScreenFontID
FontID1 = LoadFont(1, "Arial", 8, #PB_Font_Bold)
FontID2 = LoadFont(2, "Arial", 8, #PB_Font_Bold|#PB_Font_Underline)
ScreenFontID = LoadFont(3, "Arial", 20, #PB_Font_Bold|#PB_Font_Underline)

;- Konstanten und Variablen
#Programmname = "Screenshot Manager"
#Programmvers = "1.20"
;Allgemeine Variablen
Global ClipboardImageID.l, LanguageName.s
Global TestString.s
;Einstellungen
Global FirstStart.l, ClearClipboardbyStart.l, CtrlKey.l, AltKey.l, ScreenKey.l, SaveFormat.l
Global SavePathExport.l, SavePath.s, SaveIntervall.l, GraphicPosition.l
Global AddownText.l, OwnText.s, AddDateandTime.l
Global Fontname.s, Fontsize.l, Fontcolor.l, Fontstyle.l
Global ScreenSound.l, DesktopModeTest.l, AutoClipboardSave.l, SaveName.l
Global ShowEndMsg.l, ShowQMsg.l

;- Image Plugins
UsePNGImageDecoder()
UsePNGImageEncoder()
UseJPEGImageDecoder()
UseJPEGImageEncoder()

;- Ressourcen
Icon = LoadIcon_(GetModuleHandle_(0),"#1")

Global Image0, Sound0
Image0 = CatchImage(0, ?Image0)
Image1 = CatchImage(1, ?Image1)

IncludePath "E:\Documents\PureBasic\Source\Projekte\ScreenshotManager\"
DataSection
  Image0: IncludeBinary "InfoLogo.png"
  Image1: IncludeBinary "FirstStartLogo.png"
EndDataSection

;Export Verzeichniss erstellen falls es nicht existiert
If FileSize(ExecutableDirectory() + "Export") = -1
  CreateDirectory(ExecutableDirectory() + "Export")
EndIf

Procedure KeyReleasedSM(Key.l)
  Static Rueckgabe.l
  GetAsyncKeyState_(Key)
  If GetAsyncKeyState_(Key)
    Rueckgabe = #True
    ProcedureReturn #False
  EndIf
  If GetAsyncKeyState_(Key) = 0 And Rueckgabe = #True
    Rueckgabe = #False
    ProcedureReturn #True
  EndIf
EndProcedure

Procedure ClearKeyPufferSM()
  GetAsyncKeyState_(#VK_0)         ;Zahlen
  GetAsyncKeyState_(#VK_1)
  GetAsyncKeyState_(#VK_2)
  GetAsyncKeyState_(#VK_3)
  GetAsyncKeyState_(#VK_4)
  GetAsyncKeyState_(#VK_5)
  GetAsyncKeyState_(#VK_6)
  GetAsyncKeyState_(#VK_7)
  GetAsyncKeyState_(#VK_8)
  GetAsyncKeyState_(#VK_9)
  GetAsyncKeyState_(#VK_A)         ;Buchstaben
  GetAsyncKeyState_(#VK_B)
  GetAsyncKeyState_(#VK_C)
  GetAsyncKeyState_(#VK_D)
  GetAsyncKeyState_(#VK_E)
  GetAsyncKeyState_(#VK_F)
  GetAsyncKeyState_(#VK_G)
  GetAsyncKeyState_(#VK_H)
  GetAsyncKeyState_(#VK_I)
  GetAsyncKeyState_(#VK_J)
  GetAsyncKeyState_(#VK_K)
  GetAsyncKeyState_(#VK_L)
  GetAsyncKeyState_(#VK_M)
  GetAsyncKeyState_(#VK_N)
  GetAsyncKeyState_(#VK_O)
  GetAsyncKeyState_(#VK_P)
  GetAsyncKeyState_(#VK_Q)
  GetAsyncKeyState_(#VK_R)
  GetAsyncKeyState_(#VK_S)
  GetAsyncKeyState_(#VK_T)
  GetAsyncKeyState_(#VK_U)
  GetAsyncKeyState_(#VK_V)
  GetAsyncKeyState_(#VK_W)
  GetAsyncKeyState_(#VK_X)
  GetAsyncKeyState_(#VK_Y)
  GetAsyncKeyState_(#VK_Z)
  GetAsyncKeyState_(#VK_F1)        ;F-Tasten
  GetAsyncKeyState_(#VK_F2)
  GetAsyncKeyState_(#VK_F3)
  GetAsyncKeyState_(#VK_F4)
  GetAsyncKeyState_(#VK_F5)
  GetAsyncKeyState_(#VK_F6)
  GetAsyncKeyState_(#VK_F7)
  GetAsyncKeyState_(#VK_F8)
  GetAsyncKeyState_(#VK_F9)
  GetAsyncKeyState_(#VK_F10)
  GetAsyncKeyState_(#VK_F11)
  GetAsyncKeyState_(#VK_F12)
  GetAsyncKeyState_(#VK_F13)
  GetAsyncKeyState_(#VK_F14)
  GetAsyncKeyState_(#VK_F15)
  GetAsyncKeyState_(#VK_F16)
  GetAsyncKeyState_(#VK_F17)
  GetAsyncKeyState_(#VK_F18)
  GetAsyncKeyState_(#VK_F19)
  GetAsyncKeyState_(#VK_F20)
  GetAsyncKeyState_(#VK_F21)
  GetAsyncKeyState_(#VK_F22)
  GetAsyncKeyState_(#VK_F23)
  GetAsyncKeyState_(#VK_F24)
  GetAsyncKeyState_(#VK_NUMLOCK)   ;Numlook
  GetAsyncKeyState_(#VK_NUMPAD0)   ;Numblock Zahlen
  GetAsyncKeyState_(#VK_NUMPAD1)
  GetAsyncKeyState_(#VK_NUMPAD2)
  GetAsyncKeyState_(#VK_NUMPAD3)
  GetAsyncKeyState_(#VK_NUMPAD4)
  GetAsyncKeyState_(#VK_NUMPAD5)
  GetAsyncKeyState_(#VK_NUMPAD6)
  GetAsyncKeyState_(#VK_NUMPAD7)
  GetAsyncKeyState_(#VK_NUMPAD8)
  GetAsyncKeyState_(#VK_NUMPAD9)
  GetAsyncKeyState_(#VK_ESCAPE)    ;Escape
  GetAsyncKeyState_(#VK_SNAPSHOT)  ;Druck
  GetAsyncKeyState_(#VK_INSERT)    ;Einfg
  GetAsyncKeyState_(#VK_DELETE)    ;Entf
  GetAsyncKeyState_(#VK_SCROLL)    ;Rollen
  GetAsyncKeyState_(#VK_HOME)      ;Pos1
  GetAsyncKeyState_(#VK_END)       ;Ende
  GetAsyncKeyState_(#VK_PAUSE)     ;Pause
  GetAsyncKeyState_(#VK_PRIOR)     ;Bild UP
  GetAsyncKeyState_(#VK_NEXT)      ;Bild Down
  GetAsyncKeyState_(#VK_LEFT)      ;Pfeil Links
  GetAsyncKeyState_(#VK_UP)        ;Pfeil Hoch
  GetAsyncKeyState_(#VK_RIGHT)     ;Pfeil Rechts
  GetAsyncKeyState_(#VK_DOWN)      ;Pfeil Runter
  GetAsyncKeyState_(#VK_TAB)       ;Tabulator
  GetAsyncKeyState_(#VK_RETURN)    ;Enter
  GetAsyncKeyState_(#VK_SHIFT)     ;Shift
  GetAsyncKeyState_(#VK_LSHIFT)    ;Shift Links
  GetAsyncKeyState_(#VK_CAPITAL)   ;Capslook
  GetAsyncKeyState_(#VK_LCONTROL)  ;Strg Links
  GetAsyncKeyState_(#VK_RCONTROL)  ;Strg Rechts
  GetAsyncKeyState_(#VK_MENU)      ;Alt Links
  GetAsyncKeyState_(#VK_LMENU)     ;Alt Rechts
  GetAsyncKeyState_(#VK_LWIN)      ;Windows Taste Links
  GetAsyncKeyState_(#VK_RWIN)      ;Windows Taste Rechts
  GetAsyncKeyState_(#VK_APPS)      ;Menü
  GetAsyncKeyState_(#VK_ADD)       ;Addition
  GetAsyncKeyState_(#VK_SUBTRACT)  ;Subtraction
  GetAsyncKeyState_(#VK_DIVIDE)    ;Divisuin
  GetAsyncKeyState_(#VK_MULTIPLY)  ;Multiplizieren
EndProcedure

Procedure.l GetPreferenceGroupAmount(PreferenceFile.s)
  FileID.l
  AktZeile.s
  EntryAmount.l
  FileID = ReadFile(#PB_Any, PreferenceFile)
  If FileID
    While Eof(FileID) = 0
      AktZeile = RTrim(LTrim(ReadString(FileID)))
      If Left(AktZeile, 1) = "[" And Right(AktZeile, 1) = "]"
        EntryAmount = EntryAmount + 1
      EndIf
    Wend
    If EntryAmount = 0
      EntryAmount = -1
    EndIf
    CloseFile(FileID)
    ProcedureReturn EntryAmount
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

Procedure.s GetPreferenceGroupName(PreferenceFile.s, Group.l)
  FileID.l
  AktZeile.s
  EntryAmount.l
  FileID = ReadFile(#PB_Any, PreferenceFile)
  If FileID
    While Eof(FileID) = 0
      AktZeile = RTrim(LTrim(ReadString(FileID)))
      If Left(AktZeile, 1) = "[" And Right(AktZeile, 1) = "]"
        EntryAmount = EntryAmount + 1
      EndIf
      If EntryAmount = Group
        CloseFile(FileID)
        ProcedureReturn Right(Left(AktZeile,Len(AktZeile)-1),Len(AktZeile)-2)
      EndIf
    Wend
    CloseFile(FileID)
    ProcedureReturn ""
  Else
    ProcedureReturn ""
  EndIf
EndProcedure

Procedure.l GetPreferenceGroupPos(PreferenceFile.s, Group.s)
  FileID.l
  AktZeile.s
  EntryAmount.l
  FileID = ReadFile(#PB_Any, PreferenceFile)
  If FileID
    While Eof(FileID) = 0
      AktZeile = RTrim(LTrim(ReadString(FileID)))
      If Left(AktZeile, 1) = "[" And Right(AktZeile, 1) = "]"
        EntryAmount = EntryAmount + 1
        If Right(Left(AktZeile,Len(AktZeile)-1),Len(AktZeile)-2) = Group
          CloseFile(FileID)
          ProcedureReturn EntryAmount
        EndIf
      EndIf
    Wend
    CloseFile(FileID)
    ProcedureReturn #False
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

Procedure WritePreferenceValue(PreferenceFile.s, Group.s, Key.s, Value.s)
  If WritePrivateProfileString_(Group, Key, " "+Value, PreferenceFile)
    a.s = Space(50)
    If GetPrivateProfileString_(Group, Key, "", @a, Len(a), PreferenceFile)
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

Procedure DesktopScreenshot(Image, Curr = 0, Format = #PB_ImagePlugin_BMP)
  Protected iImage.i, iDC.i, iDesktopDC.i, iForegroundWin, R.RECT, iResult.i
  Protected X.i, Y.i, Width.i, Height.i
  
  If Curr
    iForegroundWin = GetForegroundWindow_()
    If GetWindowRect_(iForegroundWin, @R)
      X      = R\left
      Y      = R\top
      Width  = R\right - R\left
      Height = R\bottom - R\top
    EndIf
    If X < 0 Or Y < 0
      X = 0
      Y = 0
      Width  = GetSystemMetrics_(#SM_CXSCREEN)
      Height = GetSystemMetrics_(#SM_CYSCREEN)
    EndIf
  Else
    X      = 0
    Y      = 0
    Width  = GetSystemMetrics_(#SM_CXSCREEN)
    Height = GetSystemMetrics_(#SM_CYSCREEN)
  EndIf
  
  If Trim(ImagePath$) <> ""
    iImage = CreateImage(Image, Width, Height)
    If iImage <> 0
      iDC = StartDrawing(ImageOutput(iImage))
      If iDC
        iDesktopDC = GetDC_(GetDesktopWindow_())
        BitBlt_(iDC, 0, 0, Width, Height, iDesktopDC, X, Y, #SRCCOPY)
        StopDrawing()
        ReleaseDC_(GetDesktopWindow_(), iDesktopDC)
      EndIf
      ProcedureReturn 1
    Else
      iResult = -1
    EndIf
  Else
    iResult = 0
  EndIf
  
  ProcedureReturn iResult
EndProcedure 

Procedure HideWindowFromShowingInTaskbar(WindowID, NewWindowHandle, show)
  If show = 1
    HideWindow(WindowID,1)
  EndIf
  SetWindowLong_(WindowID(WindowID),#GWL_HWNDPARENT,NewWindowHandle)
  If show = 1
    HideWindow(WindowID,0)
  EndIf
  ProcedureReturn
EndProcedure

Procedure OpenUrl(Url.s)
  RunProgram("RunDll32.exe", "Url.dll,FileProtocolHandler " + Url, "")
EndProcedure

Procedure GetMouseOverGadget(WindowID.l, GadgetID.l)
  GetCursorPos_(@p.POINT)
  ScreenToClient_(WindowID(WindowID), @p)
  If ChildWindowFromPoint_(WindowID(WindowID),@p) = GadgetID(GadgetID)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

hwnd_1 = OpenWindow(#TempWindow,0,0,0,0,#Programmname,#PB_Window_ScreenCentered|#PB_Window_Invisible)
hwnd_2 = OpenWindow(#Hauptfenster,0 ,0, 499, 317,#Programmname, #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_TitleBar|#PB_Window_MinimizeGadget|#PB_Window_Invisible)
If hwnd_2
  If CreateStatusBar(#StatusBar_Hauptfenster,WindowID(#Hauptfenster))
    AddStatusBarField(WindowWidth(#Hauptfenster)-2)
  EndIf

  ;ScreenTaste
  CheckBoxGadget(#CheckBox_SKSTRG, 15, 30, 40, 15, "")
  CheckBoxGadget(#CheckBox_SKALT, 65, 30, 40, 15, "")
  ComboBoxGadget(#Combo_ScreenKey3, 110, 26, 95, 20)
  ;Speicherformat
  OptionGadget(#Radio_BMP, 15, 80, 205, 20, "")
  OptionGadget(#Radio_JPG, 15, 100, 205, 20, "")
  OptionGadget(#Radio_PNG, 15, 120, 205, 20, "")
  ;Speicherort
  CheckBoxGadget(#CheckBox_ExpDir, 15, 170, 155, 20, "")
  ButtonGadget(#Button_SearchDir_SaveOrt, 175, 168, 40, 20, "")
  StringGadget(#String_DisplayPath, 15, 190, 200, 18, "", #PB_String_ReadOnly)
  ;Automatische Speicherung
  TextGadget(#Text_SaveIntervall, 15, 245, 120, 15, "")
  TrackBarGadget(#TrackBar_SaveIntervall, 10, 260, 145, 20, 2, 320)
  TextGadget(#Text_SaveIntervallDisp, 160, 262, 55, 12, "", #PB_Text_Center)
  CheckBoxGadget(#CheckBox_SaveIntervall, 145, 245, 70, 14, "")
  ;TextHinzufügen
  OptionGadget(#Radio_LO, 240, 25, 110, 14, "")
  OptionGadget(#Radio_LU, 240, 40, 110, 14, "")
  OptionGadget(#Radio_RO, 360, 25, 110, 14, "")
  OptionGadget(#Radio_RU, 360, 40, 110, 14, "")
  CheckBoxGadget(#CheckBox_OT, 240, 65, 100, 14, "")
  CheckBoxGadget(#CheckBox_AddTimeDate, 240, 80, 100, 14, "")
  StringGadget(#String_OT, 345, 63, 140, 18, "")
  ButtonGadget(#Button_Font, 415, 86, 65, 20, "")
  ;Optionen
  CheckBoxGadget(#CheckBox_Signalton, 240, 140, 235, 20, "")
  CheckBoxGadget(#CheckBox_DeskModeTest, 240, 160, 235, 20, "")
  CheckBoxGadget(#CheckBox_AutoClipboardSave, 240, 180, 235, 20, "")
  ;Speichername
  OptionGadget(#Radio_SNTime, 240, 230, 110, 15, "")
  OptionGadget(#Radio_SNDate, 240, 245, 110, 15, "")
  OptionGadget(#Radio_SNTimeDate, 240, 260, 110, 15, "")
  OptionGadget(#Radio_SNNummeriert, 365, 230, 110, 15, "")
  ;Frames - Wichtig! Erst hier nach andere Gadgets erstellen
  Frame3DGadget(#F3D_ScreenButton, 5, 5, 220, 50, "")
  Frame3DGadget(#F3D_Speicherformat, 5, 60, 220, 90, "")
  Frame3DGadget(#F3D_Speicherort, 5, 155, 220, 65, "")
  Frame3DGadget(#F3D_AutoSpeicher, 5, 220, 220, 70, "")
  Frame3DGadget(#F3D_Hinzufuegen, 230, 5, 260, 110, "")
  Frame3DGadget(#F3D_Optionen, 230, 120, 260, 85, "")
  Frame3DGadget(#F3D_Speichername, 230, 210, 260, 80, "")
  ;Fenstereigenschaften
  SendMessage_(GadgetID(#String_OT),#EM_SETLIMITTEXT,50,0)
  SetGadgetFont(#CheckBox_DeskModeTest, FontID1)
  SetGadgetFont(#Text_SaveIntervall, FontID1)
  SetGadgetFont(#Text_SaveIntervallDisp, FontID1)
  SetGadgetFont(#CheckBox_SaveIntervall, FontID1)
  SetGadgetFont(#Radio_BMP, FontID1)
  SetGadgetFont(#Radio_JPG, FontID1)
  SetGadgetFont(#Radio_PNG, FontID1)
  SetGadgetFont(#Radio_LO, FontID1)
  SetGadgetFont(#Radio_LU, FontID1)
  SetGadgetFont(#Radio_RO, FontID1)
  SetGadgetFont(#Radio_RU, FontID1)
  SetGadgetFont(#CheckBox_Signalton, FontID1)
  SetGadgetFont(#CheckBox_ExpDir, FontID1)
  SetGadgetFont(#Button_SearchDir_SaveOrt, FontID1)
  SetGadgetFont(#CheckBox_SKSTRG, FontID1)
  SetGadgetFont(#CheckBox_SKALT, FontID1)
  SetGadgetFont(#Combo_ScreenKey3, FontID1)
  SetGadgetFont(#CheckBox_AutoClipboardSave, FontID1)
  SetGadgetFont(#Radio_SNDate, FontID1)
  SetGadgetFont(#Radio_SNTime, FontID1)
  SetGadgetFont(#Radio_SNTimeDate, FontID1)
  SetGadgetFont(#Radio_SNNummeriert, FontID1)
  SetGadgetFont(#String_OT, FontID1)
  SetGadgetFont(#CheckBox_OT, FontID1)
  SetGadgetFont(#CheckBox_AddTimeDate, FontID1)
  SetGadgetFont(#String_DisplayPath, FontID1)

EndIf

If OpenWindow(#InfoFenster, 0, 0, 180, 255, #Programmname, #PB_Window_SystemMenu|#PB_Window_TitleBar|#PB_Window_Invisible|#PB_Window_WindowCentered, WindowID(#Hauptfenster))

  TextGadget(#Text_Info, 0, 145, 180, 90, "", #PB_Text_Center)
  ImageGadget(#Image_Info, 0, 0, 180, 144, Image0)
  HyperLinkGadget(#URL_HPage, 25, 240, 135, 15, "", RGB(69,159,239))
  SetGadgetFont(#Text_Info, FontID1)
  SetGadgetFont(#URL_HPage, FontID1)

EndIf

If OpenWindow(#FirstStart, 0, 0, 235, 275,#Programmname, #PB_Window_SystemMenu|#PB_Window_TitleBar|#PB_Window_Invisible|#PB_Window_ScreenCentered, WindowID(#Hauptfenster))

  ImageGadget(#Image_FirstStart_Info, 20, 100, 191, 110, Image1, #PB_Image_Border)
  TextGadget(#Text_FirstStart_Info1, 0, 0, 235, 30, "", #PB_Text_Center)
  TextGadget(#Text_FirstStart_Info2, 15, 30, 205, 65, "", #PB_Text_Center)
  CheckBoxGadget(#CheckBox_FirstStart_Show, 25, 215, 185, 15, "")
  ButtonGadget(#Button_FirstStart_OK, 75, 240, 85, 25, "")
  SetGadgetFont(#Text_FirstStart_Info1, FontID1)

EndIf

;- Sprache verändern
Procedure SetLanguage(Sprache.s)
  ;Sprache einlesen
  If OpenPreferences(ExecutableDirectory() + "Language.ini")
    PreferenceGroup("Main")
    LanguageName = ReadPreferenceString("Language", Sprache)
    If PreferenceGroup(LanguageName) = #False
      MessageRequester("Fehler", "Die Sprache " + LanguageName + " konnte nicht gefunden werden.", #MB_OK|#MB_ICONERROR)
      End
    EndIf
    ;Fensterelemente
    Global Dim LanguageGadget.s(40)
    For a = 0 To 40
      LanguageGadget(a) = ReadPreferenceString("g"+Str(a),"")
      If LanguageGadget(a) = ""
        MessageRequester("Fehler","Sprache:" + " " + LanguageName +Chr(13)+ "Eintrag:" + " " + "g"+Str(a), #MB_OK|#MB_ICONERROR)
        End
      EndIf
    Next
    ;Menuelemente
    Global Dim LanguageMenuT.s(10)
    For a = 0 To 10
      LanguageMenuT(a) = ReadPreferenceString("m"+Str(a),"")
      If LanguageMenuT(a) = ""
        MessageRequester("Fehler","Sprache:" + " " + LanguageName +Chr(13)+ "Eintrag:" + " " + "m"+Str(a), #MB_OK|#MB_ICONERROR)
        End
      EndIf
    Next
    ;Dialoge
    Global Dim LanguageDialog.s(9)
    For a = 0 To 9
      LanguageDialog(a) = ReadPreferenceString("d"+Str(a),"")
      If LanguageDialog(a) = ""
        MessageRequester("Fehler","Sprache:" + " " + LanguageName +Chr(13)+ "Eintrag:" + " " + "d"+Str(a), #MB_OK|#MB_ICONERROR)
        End
      EndIf
    Next
    ;AktiveHilfe
    Global Dim LanguageHelp.s(26)
    For a = 0 To 26
      LanguageHelp(a) = ReadPreferenceString("h"+Str(a),"")
      If LanguageHelp(a) = ""
        MessageRequester("Fehler","Sprache:" + " " + LanguageName +Chr(13)+ "Eintrag:" + " " + "h"+Str(a), #MB_OK|#MB_ICONERROR)
        End
      EndIf
    Next
    ClosePreferences()
  Else
    MessageRequester("Fehler", "Die Sprachdatei Language.ini konnte nicht geöffnet werden.", #MB_OK|#MB_ICONERROR)
    End
  EndIf

  ;Fensterelemente
  ;Hauptfenster
  SetGadgetText(#F3D_ScreenButton, LanguageGadget(0))
  SetGadgetText(#CheckBox_SKSTRG, LanguageGadget(1))
  SetGadgetText(#CheckBox_SKALT, LanguageGadget(2))
  SetGadgetText(#F3D_Speicherformat, LanguageGadget(3))
  SetGadgetText(#Radio_BMP, LanguageGadget(4))
  SetGadgetText(#Radio_JPG, LanguageGadget(5))
  SetGadgetText(#Radio_PNG, LanguageGadget(6))
  SetGadgetText(#F3D_Speicherort, LanguageGadget(7))
  SetGadgetText(#CheckBox_ExpDir, LanguageGadget(8))
  SetGadgetText(#Button_SearchDir_SaveOrt, LanguageGadget(9))
  SetGadgetText(#F3D_AutoSpeicher, LanguageGadget(10))
  SetGadgetText(#Text_SaveIntervall, LanguageGadget(11))
  SetGadgetText(#Text_SaveIntervallDisp, Str(GetGadgetState(#TrackBar_SaveIntervall)) + " " + LanguageGadget(12))
  SetGadgetText(#CheckBox_SaveIntervall, LanguageGadget(13))
  SetGadgetText(#F3D_Hinzufuegen, LanguageGadget(14))
  SetGadgetText(#Radio_LO, LanguageGadget(15))
  SetGadgetText(#Radio_RO, LanguageGadget(16))
  SetGadgetText(#Radio_LU, LanguageGadget(17))
  SetGadgetText(#Radio_RU, LanguageGadget(18))
  SetGadgetText(#CheckBox_OT, LanguageGadget(19))
  SetGadgetText(#CheckBox_AddTimeDate, LanguageGadget(20))
  SetGadgetText(#Button_Font, LanguageGadget(21))
  SetGadgetText(#F3D_Optionen, LanguageGadget(22))
  SetGadgetText(#CheckBox_Signalton, LanguageGadget(23))
  SetGadgetText(#CheckBox_DeskModeTest, LanguageGadget(24))
  SetGadgetText(#CheckBox_AutoClipboardSave, LanguageGadget(25))
  SetGadgetText(#F3D_Speichername, LanguageGadget(26))
  SetGadgetText(#Radio_SNTime, LanguageGadget(27))
  SetGadgetText(#Radio_SNDate, LanguageGadget(28))
  SetGadgetText(#Radio_SNTimeDate, LanguageGadget(29))
  SetGadgetText(#Radio_SNNummeriert, LanguageGadget(30))
  ;InfoFenster
  SetWindowTitle(#InfoFenster, LanguageGadget(31))
  SetGadgetText(#Text_Info, #Programmname + " " + #Programmvers +Chr(13)+Chr(10)+Chr(13)+Chr(10)+LanguageGadget(32)+Chr(13)+Chr(10)+LanguageGadget(33))
  SetGadgetText(#URL_HPage, LanguageGadget(34))
  ;FirststartFenster
  SetWindowTitle(#FirstStart, LanguageGadget(35))
  SetGadgetText(#Text_FirstStart_Info1, LanguageGadget(36))
  SetGadgetText(#Text_FirstStart_Info2, Chr(13)+Chr(10)+LanguageGadget(37)+Chr(13)+Chr(10)+LanguageGadget(38))
  SetGadgetText(#CheckBox_FirstStart_Show, LanguageGadget(39))
  SetGadgetText(#Button_FirstStart_OK, LanguageGadget(40))

  ;Menu
  If IsMenu(#Menu_Hauptfenster)
    FreeMenu(#Menu_Hauptfenster)
  EndIf
  If CreatePopupMenu(#Menu_Hauptfenster)
    MenuItem(#Menu_Hauptfenster_OpenWindow,LanguageMenuT(0))
    MenuItem(#Menu_Hauptfenster_OpenScreenFolder,LanguageMenuT(1))
    MenuBar()
    MenuItem(#Menu_Hauptfenster_Info, LanguageMenuT(2))
    MenuItem(#Menu_Hauptfenster_Help, LanguageMenuT(3))
    MenuBar()
    OpenSubMenu(LanguageMenuT(4))
    MenuItem(#Menu_Hauptfenster_ClearClipboard, LanguageMenuT(5))
    MenuBar()
    MenuItem(#Menu_Hauptfenster_ShowFirstWindow, LanguageMenuT(6))
    MenuBar()
    MenuItem(#Menu_Hauptfenster_ShowEndMsg, LanguageMenuT(7))
    MenuItem(#Menu_Hauptfenster_ShowSPMsg, LanguageMenuT(8))
    CloseSubMenu()
    MenuBar()
    OpenSubMenu(LanguageMenuT(9))
    Global Dim LanguageMenu.l(GetPreferenceGroupAmount(ExecutableDirectory() + "Language.ini")-1)
    LanguageMenu(0) = GetPreferenceGroupAmount(ExecutableDirectory() + "Language.ini")-1
    For a = 1 To LanguageMenu(0)
      MenuItem(#Menu_Hauptfenster_MinLanguage-1+a, GetPreferenceGroupName(ExecutableDirectory() + "Language.ini", a+1))
      LanguageMenu(a) = #Menu_Hauptfenster_MinLanguage-1+a
    Next
    CloseSubMenu()
    MenuBar()
    MenuItem(#Menu_Hauptfenster_Beenden, LanguageMenuT(10))
  Else
    MessageRequester("Fehler","Das Menü konnte nicht erstellt werden.", #MB_OK|#MB_ICONERROR)
    End
  EndIf
  For a = 1 To LanguageMenu(0)
    If GetPreferenceGroupPos(ExecutableDirectory() + "Language.ini", LanguageName)-1 = a
      SetMenuItemState(#Menu_Hauptfenster, LanguageMenu(a), #True)
    EndIf
  Next
  ;Status des Menüs
  If ClearClipboardbyStart: SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard, #True): EndIf
  If FirstStart: SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #True): EndIf
  If ShowEndMsg: SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg, #True): EndIf
  If ShowQMsg: SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg, #True): EndIf
  ;DisableMenuItem(#Menu_Hauptfenster_Help, #True) ;Beta
EndProcedure
SetLanguage(LanguageName)

Procedure AddScreenshotKeys()
  Temp.l = 0
  AktZeile.s
  If FileSize(ExecutableDirectory()+"ScreenKeys.ini")
    If ReadFile(#TestFile, ExecutableDirectory()+"ScreenKeys.ini")
      While Eof(#TestFile) = 0
        Temp = Temp + 1
        AktZeile = ReadString(#TestFile)
        If StringField(AktZeile,1,",") = "" Or StringField(AktZeile,2,",") = "" Or Val(StringField(AktZeile,2,",")) = #False
          MessageRequester(LanguageDialog(0),LanguageDialog(9) + " " + Str(Temp) + ".",#MB_OK|#MB_ICONERROR)
          End
        EndIf
        If Temp > 100: Temp = 100: EndIf
      Wend
      FileSeek(#TestFile, 0)
      Global Dim KeyValue.l(Temp-1)
      AddGadgetItem(#Combo_ScreenKey3,-1,"")
      For a = 1 To Temp
        AktZeile = ReadString(#TestFile)
        AddGadgetItem(#Combo_ScreenKey3,a,StringField(AktZeile,1,","))
        KeyValue(a-1) = Val(StringField(AktZeile,2,","))
      Next
      CloseFile(#TestFile)
    Else
      MessageRequester(LanguageDialog(0),LanguageDialog(8),#MB_OK|#MB_ICONERROR)
      End
    EndIf
  Else
    MessageRequester(LanguageDialog(0),LanguageDialog(8),#MB_OK|#MB_ICONERROR)
    End
  EndIf
EndProcedure

;- Einstellungen lesen
If OpenPreferences(ExecutableDirectory() + "ScreenshotManager.ini")
  PreferenceGroup("Main")

  ;FirstStart Fenster
  FirstStart = ReadPreferenceLong("FirstStart", 1)
  If FirstStart < 0 Or FirstStart > 1
    FirstStart = 1
  EndIf
  If FirstStart = 0
    SetGadgetState(#CheckBox_FirstStart_Show, #True)
  EndIf

  ClearClipboardbyStart = ReadPreferenceLong("ClearClipboardbyStart", 0)
  If ClearClipboardbyStart < 0 Or ClearClipboardbyStart > 1
    ClearClipboardbyStart = 0
  EndIf

  ;Screenshot Taste
  CtrlKey = ReadPreferenceLong("CtrlKey", 0)
  If Ctrl < 0 Or Ctrl > 1
    Ctrl = 0
  EndIf
  If Ctrl: SetGadgetState(#CheckBox_SKSTRG, #True): EndIf

  AltKey = ReadPreferenceLong("AltKey", 0)
  If AltKey < 0 Or AltKey > 1
    AltKey = 0
  EndIf
  If AltKey
    SetGadgetState(#CheckBox_SKALT, #True)
  EndIf

  ScreenKey = ReadPreferenceLong("ScreenKey", 0)
  If ScreenKey < 0 Or ScreenKey > 100
    ScreenKey = 0
  EndIf
  SetGadgetState(#Combo_ScreenKey3, ScreenKey)

  ;Speicherformat
  SaveFormat = ReadPreferenceLong("SaveFormat", 1)
  If SaveFormat < 1 Or SaveFormat > 3
    SaveFormat = 1
  EndIf
  Select SaveFormat
    Case 1: SetGadgetState(#Radio_BMP, #True)
    Case 2: SetGadgetState(#Radio_JPG, #True)
    Case 3: SetGadgetState(#Radio_PNG, #True)
  EndSelect

  SavePathExport = ReadPreferenceLong("SavePathExport", 1)
  If SavePathExport < 0 Or SavePathExport > 1
    SavePathExport = 1
  EndIf
  If SavePathExport
    SetGadgetState(#CheckBox_ExpDir, #True)
    DisableGadget(#Button_SearchDir_SaveOrt, #True)
  EndIf

  SavePath = ReadPreferenceString("SavePath", ExecutableDirectory() + "Export")
  If FileSize(SavePath) = -1
    MessageRequester(LanguageDialog(0), LanguageDialog(1)+Chr(13)+Chr(10)+LanguageDialog(2),#MB_OK|#MB_ICONWARNING)
    SavePath = ExecutableDirectory() + "Export"
  EndIf

  ;Automatische Speicherung
  SaveIntervall = ReadPreferenceLong("SaveIntervall", 2)
  If SaveIntervall < 2
    SaveIntervall = 2
  ElseIf SaveIntervall > 320
    SaveIntervall = 320
  EndIf
  SetGadgetState(#TrackBar_SaveIntervall, SaveIntervall)
  SetGadgetText(#Text_SaveIntervallDisp, Str(SaveIntervall) + " " + LanguageGadget(12))

  ;Text hinzufügen
  GraphicPosition = ReadPreferenceLong("GraphicPosition", 3)
  If GraphicPosition < 1 Or GraphicPosition > 4
    GraphicPosition = 3
  EndIf
  Select GraphicPosition
    Case 1: SetGadgetState(#Radio_LO, #True)
    Case 2: SetGadgetState(#Radio_RO, #True)
    Case 3: SetGadgetState(#Radio_LU, #True)
    Case 4: SetGadgetState(#Radio_RU, #True)
  EndSelect

  AddownText = ReadPreferenceLong("AddownText", 0)
  If AddownText < 0 Or AddownText > 1
    AddownText = 0
  EndIf
  If AddownText
    SetGadgetState(#CheckBox_OT, #True)
  EndIf

  OwnText = ReadPreferenceString("OwnText", "")
  If OwnText = ""
    OwnText = "Screenshot Manager"
  EndIf
  If Len(OwnText) > 50
    Left(OwnText, 50)
  EndIf

  AddDateandTime = ReadPreferenceLong("AddDateandTime", 0)
  If AddDateandTime < 0 Or AddDateandTime > 1
    AddDateandTime = 0
  EndIf
  If AddDateandTime
    SetGadgetState(#CheckBox_AddTimeDate, #True)
  EndIf

  Fontname = ReadPreferenceString("Fontname", "Arial")
  If Fontname = ""
    Fontname = "Arial"
  EndIf

  Fontsize = ReadPreferenceLong("Fontsize", 20)
  If Fontsize < 8 Or Fontsize > 48
    Fontsize = 20
  EndIf

  Fontcolor = ReadPreferenceLong("Fontcolor", 0)
  If Fontcolor < 0 Or Fontcolor > 16777215
    Fontcolor = 0
  EndIf

  Fontstyle = ReadPreferenceLong("Fontstyle", -1)
  If Fontstyle < -1 Or Fontstyle > 768
    Fontstyle = -1
  EndIf

  ;Weitere Optionen
  ScreenSound = ReadPreferenceLong("ScreenSound", 0)
  If ScreenSound < 0 Or ScreenSound > 1
    ScreenSound = 0
  EndIf
  If ScreenSound
    SetGadgetState(#CheckBox_Signalton, #True)
  EndIf
  If FileSize(ExecutableDirectory() + "SaveSound.wav") = #False Or SoundUmgebung = 0
    SetGadgetState(#CheckBox_Signalton, #False)
    DisableGadget(#CheckBox_Signalton, #True)
  Else
    LoadSound(#SaveSound, ExecutableDirectory() + "SaveSound.wav")
  EndIf

  DesktopModeTest = ReadPreferenceLong("DesktopModeTest", 1)
  If DesktopModeTest < 0 Or DesktopModeTest > 1
    DesktopModeTest = 1
  EndIf
  If DesktopModeTest
    SetGadgetState(#CheckBox_DeskModeTest, #True)
  EndIf

  AutoClipboardSave = ReadPreferenceLong("AutoClipboardSave", 1)
  If AutoClipboardSave < 0 Or AutoClipboardSave > 1
    AutoClipboardSave = 1
  EndIf
  If AutoClipboardSave
    SetGadgetState(#CheckBox_AutoClipboardSave, #True)
  EndIf

  ;Speichername
  SaveName = ReadPreferenceLong("SaveName", 3)
  If SaveName < 1 Or SaveName > 4
    SaveName = 3
  EndIf
  Select SaveName
    Case 1: SetGadgetState(#Radio_SNTime, #True)
    Case 2: SetGadgetState(#Radio_SNDate, #True)
    Case 3: SetGadgetState(#Radio_SNTimeDate, #True)
    Case 4: SetGadgetState(#Radio_SNNummeriert, #True)
  EndSelect

  PreferenceGroup("Debug")
  ShowEndMsg = ReadPreferenceLong("ShowEndMsg", 1)
  If ShowEndMsg < 0 Or ShowEndMsg > 1
    ShowEndMsg = 1
  EndIf

  ShowQMsg = ReadPreferenceLong("ShowQMsg", 0)
  If ShowQMsg < 0 Or ShowQMsg > 1
    ShowQMsg = 0
  EndIf

  ClosePreferences()
Else ;- Einstellungen schreiben
  CreatePreferences(ExecutableDirectory() + "ScreenshotManager.ini")
  PreferenceComment("Preferences File for Screenshot Manager")
  PreferenceComment("")
  PreferenceGroup("Main")
  WritePreferenceString("Firststart", "1")
  FirstStart = 1
  WritePreferenceString("ClearClipboardbyStart", "0")
  ClearClipboardbyStart = 0
  WritePreferenceString("CtrlKey", "0")
  CtrlKey = 0
  WritePreferenceString("AltKey", "0")
  AltKey = 0
  WritePreferenceString("ScreenKey", "0")
  ScreenKey = 0
  WritePreferenceString("SaveFormat", "1")
  SaveFormat = 1
  WritePreferenceString("SavePathExport", "1")
  SavePathExport = 1
  WritePreferenceString("SavePath", ExecutableDirectory()+"Export")
  SavePath = ExecutableDirectory()+"Export"
  WritePreferenceString("SaveIntervall", "2")
  SaveIntervall = 2
  WritePreferenceString("GraphicPosition", "3")
  GraphicPosition = 3
  WritePreferenceString("AddownText", "0")
  AddownText = 0
  WritePreferenceString("OwnText", "Screenshot Manager")
  OwnText = "Screenshot Manager"
  WritePreferenceString("AddDateandTime", "0")
  AddDateandTime = 0
  WritePreferenceString("Fontname", "Arial")
  Fontname = "Arial"
  WritePreferenceString("Fontsize", "20")
  Fontsize = 20
  WritePreferenceString("Fontcolor", "0")
  Fontcolor = 0
  WritePreferenceString("Fontstyle", "-1")
  Fontstyle = -1
  WritePreferenceString("Screensound", "0")
  ScreenSound = 0
  WritePreferenceString("DesktopModeTest", "1")
  DesktopModeTest = 1
  WritePreferenceString("AutoClipboardSave", "1")
  AutoClipboardSave = 1
  WritePreferenceString("SaveName", "3")
  SaveName = 3
  PreferenceComment("")
  PreferenceGroup("Debug")
  WritePreferenceString("ShowEndMsg", "1")
  ShowEndMsg = 1
  WritePreferenceString("ShowQMsg", "0")
  ShowQMsg = 0
  ClosePreferences()
EndIf

;- Einstellungen verarbeiten
;Screenshot Taste
If CtrlKey: SetGadgetState(#CheckBox_SKSTRG, #True): EndIf

If AltKey: SetGadgetState(#CheckBox_SKALT, #True): EndIf

AddScreenshotKeys()

SetGadgetState(#Combo_ScreenKey3, ScreenKey)

;Speicherformat
Select SaveFormat
  Case 1: SetGadgetState(#Radio_BMP, #True)
  Case 2: SetGadgetState(#Radio_JPG, #True)
  Case 3: SetGadgetState(#Radio_PNG, #True)
EndSelect

;Speicherort
If SavePathExport
  SetGadgetState(#CheckBox_ExpDir, #True)
  DisableGadget(#Button_SearchDir_SaveOrt, #True)
  SetGadgetText(#String_DisplayPath, ExecutableDirectory()+"Export")
Else
  SetGadgetText(#String_DisplayPath, SavePath)
EndIf

If FileSize(SavePath) = -1
  MessageRequester(LanguageDialog(0), LanguageDialog(1)+Chr(13)+Chr(10)+LanguageDialog(2),#MB_OK|#MB_ICONWARNING)
  SavePath = ExecutableDirectory() + "Export"
  SetGadgetText(#String_DisplayPath, ExecutableDirectory()+"Export")
EndIf

;Automatische Speicherung
SetGadgetState(#TrackBar_SaveIntervall, SaveIntervall)
SetGadgetText(#Text_SaveIntervallDisp, Str(SaveIntervall) + " " + LanguageGadget(12))

Select GraphicPosition
  Case 1: SetGadgetState(#Radio_LO, #True)
  Case 2: SetGadgetState(#Radio_RO, #True)
  Case 3: SetGadgetState(#Radio_LU, #True)
  Case 4: SetGadgetState(#Radio_RU, #True)
EndSelect

;Text hinzufügen
If AddownText
  SetGadgetState(#CheckBox_OT, #True)
  SetGadgetText(#String_OT, OwnText)
Else
  SetGadgetText(#String_OT, OwnText)
  DisableGadget(#String_OT, #True)
EndIf

If AddDateandTime: SetGadgetState(#CheckBox_AddTimeDate, #True): EndIf

If GetGadgetState(#CheckBox_OT) = #False And GetGadgetState(#CheckBox_AddTimeDate) = #False
  DisableGadget(#Button_Font, #True)
EndIf

;Weitere Optionen
If ScreenSound: SetGadgetState(#CheckBox_Signalton, #True): EndIf
If FileSize(ExecutableDirectory() + "SaveSound.wav") = #False Or SoundUmgebung = 0
  SetGadgetState(#CheckBox_Signalton, #False)
  DisableGadget(#CheckBox_Signalton, #True)
Else

EndIf

If DesktopModeTest: SetGadgetState(#CheckBox_DeskModeTest, #True): EndIf
If AutoClipboardSave: SetGadgetState(#CheckBox_AutoClipboardSave, #True): EndIf

;Speichername
Select SaveName
  Case 1: SetGadgetState(#Radio_SNTime, #True)
  Case 2: SetGadgetState(#Radio_SNDate, #True)
  Case 3: SetGadgetState(#Radio_SNTimeDate, #True)
  Case 4: SetGadgetState(#Radio_SNNummeriert, #True)
EndSelect

;Debug Bereich
If ShowEndMsg
  SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg, #True)
EndIf
If ShowQMsg
  SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg, #True)
EndIf

;***********************************************************
;- Funtionen
;***********************************************************
;Verändert den Statusbar Text, für akt. Hilfe.
Procedure SetStatusBarText(Text.s)
  If Len(Text) > 100
    Text = Left(Text, 98) + ".."
  EndIf
  Static LastText.s
  If Text <> LastText
    StatusBarText(#StatusBar_Hauptfenster, 0, Text, #PB_StatusBar_Center)
  EndIf
  LastText = Text
EndProcedure

;Zeigt und versteckt die Fenster
;Für minimieren ect!
Procedure HidingWindow(Fenster, Status)
  Select Fenster
    Case #Hauptfenster
      If Status = #True
        HideWindow(#Hauptfenster, #True)
        HideWindow(#InfoFenster, #True)
      Else
        HideWindow(#Hauptfenster, #False)
      EndIf
    Case #InfoFenster
      If Status = #True
        HideWindow(#InfoFenster, #True)
      Else
        HideWindow(#InfoFenster, #False)
      EndIf
  EndSelect
EndProcedure

;Speichert die Einstellungen ab
Procedure SavePreferences()
  If CreatePreferences(ExecutableDirectory() + "ScreenshotManager.ini")
    PreferenceComment("Preferences File for Screenshot Manager")
    PreferenceComment("")
    PreferenceGroup("Main")
    WritePreferenceString("Firststart", Str(GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow)))

    WritePreferenceString("ClearClipboardbyStart", Str(GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard)))

    WritePreferenceString("CtrlKey", Str(GetGadgetState(#CheckBox_SKSTRG)))

    WritePreferenceString("AltKey", Str(GetGadgetState(#CheckBox_SKALT)))

    WritePreferenceString("ScreenKey", Str(GetGadgetState(#Combo_ScreenKey3)))

    If GetGadgetState(#Radio_BMP): SaveFormat = 1: EndIf
    If GetGadgetState(#Radio_JPG): SaveFormat = 2: EndIf
    If GetGadgetState(#Radio_PNG): SaveFormat = 3: EndIf
    WritePreferenceString("SaveFormat", Str(SaveFormat))

    WritePreferenceString("SavePathExport", Str(GetGadgetState(#CheckBox_ExpDir)))

    WritePreferenceString("SavePath", SavePath)

    WritePreferenceString("SaveIntervall", Str(GetGadgetState(#TrackBar_SaveIntervall)))

    If GetGadgetState(#Radio_LO): GraphicPosition = 1: EndIf
    If GetGadgetState(#Radio_RO): GraphicPosition = 2: EndIf
    If GetGadgetState(#Radio_LU): GraphicPosition = 3: EndIf
    If GetGadgetState(#Radio_RU): GraphicPosition = 4: EndIf
    WritePreferenceString("GraphicPosition", Str(GraphicPosition))

    WritePreferenceString("AddownText", Str(GetGadgetState(#CheckBox_OT)))

    If GetGadgetText(#String_OT) = ""
      OwnText = "Screenshot Manager"
    Else
      OwnText = GetGadgetText(#String_OT)
    EndIf
    WritePreferenceString("OwnText", OwnText)

    WritePreferenceString("AddDateandTime", Str(GetGadgetState(#CheckBox_AddTimeDate)))

    WritePreferenceString("Fontname", Fontname)

    WritePreferenceString("Fontsize", Str(Fontsize))

    WritePreferenceString("Fontcolor", Str(Fontcolor))

    WritePreferenceString("Fontstyle", Str(Fontstyle))

    WritePreferenceString("Screensound", Str(GetGadgetState(#CheckBox_Signalton)))

    WritePreferenceString("DesktopModeTest", Str(GetGadgetState(#CheckBox_DeskModeTest)))

    WritePreferenceString("AutoClipboardSave", Str(GetGadgetState(#CheckBox_AutoClipboardSave)))

    If GetGadgetState(#Radio_SNTime): SaveName = 1: EndIf
    If GetGadgetState(#Radio_SNDate): SaveName = 2: EndIf
    If GetGadgetState(#Radio_SNTimeDate): SaveName = 3: EndIf
    If GetGadgetState(#Radio_SNNummeriert): SaveName = 4: EndIf
    WritePreferenceString("SaveName", Str(SaveName))

    PreferenceComment("")
    PreferenceGroup("Debug")
    WritePreferenceString("ShowEndMsg", Str(GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg)))

    WritePreferenceString("ShowQMsg", Str(GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg)))

    ClosePreferences()
  Else
    MessageRequester("Fehler", "Die Einstellungen konnten nicht gespeichert werden.", #MB_OK|#MB_ICONERROR)
  EndIf
EndProcedure

;Beendet das Programm
Procedure Beenden()
  If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg)
    If MessageRequester(LanguageDialog(3), LanguageDialog(4), #MB_YESNO|#MB_ICONQUESTION) = #IDYES
      If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg)
        If MessageRequester(LanguageDialog(5), LanguageDialog(6), #MB_YESNO|#MB_ICONQUESTION) = #IDYES
          SavePreferences()
        EndIf
      Else
        SavePreferences()
      EndIf
      End
    EndIf
  Else
    If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg)
      If MessageRequester(LanguageDialog(5), LanguageDialog(6), #MB_YESNO|#MB_ICONQUESTION) = #IDYES
        SavePreferences()
      EndIf
    Else
      SavePreferences()
    EndIf
    End
  EndIf
EndProcedure

;Spielt den Speichersound ab
Procedure PlaySaveSound()
  If GetGadgetState(#CheckBox_Signalton) And FileSize(ExecutableDirectory() + "SaveSound.wav")
    If IsSound(#SaveSound): PlaySound(#SaveSound): EndIf
  EndIf
EndProcedure

;Gibt dir Nummer des aktuell zu speichernden Screenshots wieder
;Für die Option Speichername > Nummeriert
Procedure.s GetScreenshotNumber()
  ScreenshotAmount.l = 0
  FileTyp.l
  If GetGadgetState(#Radio_BMP)
    ExamineDirectory(#Dir , SavePath, "*.bmp")
  ElseIf GetGadgetState(#Radio_JPG)
    ExamineDirectory(#Dir , SavePath, "*.jpg")
  ElseIf GetGadgetState(#Radio_PNG)
    ExamineDirectory(#Dir , SavePath, "*.png")
  EndIf
  Repeat
    FileTyp = NextDirectoryEntry(#Dir)
    If FileTyp = 1
      ScreenshotAmount = ScreenshotAmount + 1
    EndIf
  Until FileTyp = 0
  ProcedureReturn Str(ScreenshotAmount)
EndProcedure

;Erstellt einen Screenshot
Procedure.l CreateScreenshot()
  ImageHandle.l
  ExamineDesktops()
  If IsImage(#TestFile)
    FreeImage(#TestFile)
  EndIf
  ImageHandle = CreateImage(#TestFile, DesktopWidth(0), DesktopHeight(0))
  DC = StartDrawing(ImageOutput(ImageHandle))
  BitBlt_(DC,0,0,ImageWidth(ImageHandle),ImageHeight(ImageHandle),GetDC_(GetDesktopWindow_()),0,0,#SRCCOPY)
  StopDrawing()
  ProcedureReturn ImageHandle
EndProcedure

;Speichert, benennt und verarbeitet einen Screenshot
Procedure TakeAShot(CBImageID.l)
  CISaveName.s
  CISaveExtansion.s
  CISaveFormat.l
  TempSavePath.s
  
  DesktopScreenshot(#Screenshot_Save)

  ;Speicherordner
  If GetGadgetState(#CheckBox_ExpDir)
    TempSavePath = ExecutableDirectory() + "Export"
  Else
    TempSavePath = SavePath
  EndIf

  ;Speichername
  If GetGadgetState(#Radio_SNTime)
    CISaveName = FormatDate("%hh-%ii-%ss", Date())
  ElseIf GetGadgetState(#Radio_SNDate)
    CISaveName = FormatDate("%dd-%mm-%yyyy",Date())
  ElseIf GetGadgetState(#Radio_SNTimeDate)
    CISaveName = FormatDate("%hh-%ii-%ss_%dd-%mm-%yyyy", Date())
  ElseIf GetGadgetState(#Radio_SNNummeriert)
    CISaveName = GetScreenshotNumber()
  EndIf

  ;Speicherformat
  If GetGadgetState(#Radio_BMP)
    CISaveExtansion = "bmp"
    CISaveFormat = #PB_ImagePlugin_BMP
  ElseIf GetGadgetState(#Radio_JPG)
    CISaveExtansion = "jpg"
    CISaveFormat = #PB_ImagePlugin_JPEG
  ElseIf GetGadgetState(#Radio_PNG)
    CISaveExtansion = "png"
    CISaveFormat = #PB_ImagePlugin_PNG
  EndIf

  ;Text einfügen
  Text.s
  If GetGadgetState(#CheckBox_OT)
    Text = GetGadgetText(#String_OT)
  ElseIf GetGadgetState(#CheckBox_AddTimeDate)
    Text = FormatDate("%dd.%mm.%yyyy - %hh:%ii", Date())
  EndIf

  If GetGadgetState(#CheckBox_OT) = #True Or GetGadgetState(#CheckBox_AddTimeDate) = #True
    ScreenFontID = LoadFont(#ScreenFont, Fontname, Fontsize, Fontstyle)
    ;ImageID(#Screenshot_Save)
    StartDrawing(ImageOutput(#Screenshot_Save))
    DrawingMode(1)
    ;Red(Fontcolor),Green(Fontcolor),Blue(Fontcolor)
    DrawingFont(ScreenFontID)
    
    Protected iXi, iY.i
    
    If GetGadgetState(#Radio_LO)
      iX = 10
      iY = 0
    EndIf
    If GetGadgetState(#Radio_RO)
      iX = ImageWidth(#Screenshot_Save)-TextWidth(Text)-10
      iY = 0
    EndIf
    If GetGadgetState(#Radio_LU)
      iX = 10
      iY = (ImageHeight(#Screenshot_Save) -Fontsize) - 25
    EndIf
    If GetGadgetState(#Radio_RU)
      iX = ImageWidth(#Screenshot_Save)-TextWidth(Text)-10
      iY = ImageHeight(#Screenshot_Save)- Fontsize -25
    EndIf
    
    DrawText(iX, iY, Text, Fontcolor)
    
    StopDrawing()
  EndIf

  If GetGadgetState(#CheckBox_DeskModeTest)
    ExamineDesktops()
    If ImageWidth(#Screenshot_Save) = DesktopWidth(0) And ImageHeight(#Screenshot_Save) = DesktopHeight(0)
      SaveImage(#Screenshot_Save, TempSavePath + "\" + CISaveName + "." + CISaveExtansion, CISaveFormat)
      PlaySaveSound()
    EndIf
  Else
    SaveImage(#Screenshot_Save, TempSavePath + "\" + CISaveName + "." + CISaveExtansion, CISaveFormat)
    PlaySaveSound()
  EndIf
  ClearClipboard()
EndProcedure

;- Start Events
AddSysTrayIcon(1,WindowID(#Hauptfenster),Icon)
SysTrayIconToolTip(1,#Programmname)


HideWindowFromShowingInTaskbar(#Hauptfenster,WindowID(#TempWindow),#False)

;FirstStart Window anzeigen
If FirstStart
  HideWindow(#FirstStart, #False)
  SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #True)
EndIf

If ClearClipboardbyStart
  Define iImage.i
    
  iImage = GetClipboardImage(#PB_Any)
  If iImage
    FreeImage(iImage)
    ClearClipboard()
  EndIf
  
  SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard, #True)
EndIf

;- Windows Events abfangen
Procedure WindowCallbacks(hWnd, Msg, wParam, lParam)
  Select Msg
    Case #WM_SYSCOMMAND
      Select wParam&$FFFFFFF0
        Case #SC_MAXIMIZE
          ;maximize..
          ProcedureReturn 0
        Case #SC_MINIMIZE
          ;minimize..
          If EventWindow() = 1
            HidingWindow(#Hauptfenster, #True)
            HidingWindow(#InfoFenster, #True)
          ElseIf EventWindow() = 2
            HidingWindow(#InfoFenster,#True)
          ElseIf EventWindow() = 3
            HideWindow(#FirstStart,#True)
          EndIf
          ProcedureReturn 0
      EndSelect
  EndSelect
  ProcedureReturn #PB_ProcessPureBasicEvents
EndProcedure
SetWindowCallback(@WindowCallbacks())

Define iTime.i

;- Programmschleife
Repeat
  ClipboardImageID = GetClipboardImage(#PB_Any)

  ;AutoClipboardSave
  If ClipboardImageID And GetGadgetState(#CheckBox_AutoClipboardSave) = #True
    TakeAShot(ClipboardImageID)
  EndIf

  ;Screenshot erstellen mit Screentaste
  If GetGadgetState(#Combo_ScreenKey3) <> 0
    ;Strg + Auslösetaste
    If GetGadgetState(#CheckBox_SKSTRG) = #True And GetGadgetState(#CheckBox_SKALT) = #False And GetAsyncKeyState_(#VK_LCONTROL) And KeyReleasedSM(KeyValue(GetGadgetState(#Combo_ScreenKey3)-1)) = #True
      TakeAShot(CreateScreenshot())
    EndIf

    ;Alt + Auslösetaste
    If GetGadgetState(#CheckBox_SKSTRG) = #False And GetGadgetState(#CheckBox_SKALT) = #True And GetAsyncKeyState_(#VK_LMENU) And KeyReleasedSM(KeyValue(GetGadgetState(#Combo_ScreenKey3)-1)) = #True
      TakeAShot(CreateScreenshot())
    EndIf

    ;Strg + Alt + Auslösetaste
    If GetGadgetState(#CheckBox_SKSTRG) = #True And GetGadgetState(#CheckBox_SKALT) = #True And GetAsyncKeyState_(#VK_LCONTROL) And GetAsyncKeyState_(#VK_MENU) And KeyReleasedSM(KeyValue(GetGadgetState(#Combo_ScreenKey3)-1)) = #True
      TakeAShot(CreateScreenshot())
    EndIf

    ;Nur Auslösetaste
    If GetGadgetState(#CheckBox_SKSTRG) = #False And GetGadgetState(#CheckBox_SKALT) = #False And KeyReleasedSM(KeyValue(GetGadgetState(#Combo_ScreenKey3)-1)) = #True
      TakeAShot(CreateScreenshot())
    EndIf
  EndIf

  ;AutoIntervallSave
  If GetGadgetState(#CheckBox_SaveIntervall)
    
    If timeGetTime_() - iTime  >= (1000 * GetGadgetState(#TrackBar_SaveIntervall))
      iTime = timeGetTime_()
      TakeAShot(CreateScreenshot())
    EndIf
  EndIf

  ;Aktive Hilfe in der Statusbar
  If GetMouseOverGadget(#Hauptfenster, #CheckBox_SKSTRG)
    SetStatusBarText(LanguageHelp(1))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_SKALT)
    SetStatusBarText(LanguageHelp(2))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Combo_ScreenKey3)
    SetStatusBarText(LanguageHelp(3))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_BMP)
    SetStatusBarText(LanguageHelp(4))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_JPG)
    SetStatusBarText(LanguageHelp(5))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_PNG)
    SetStatusBarText(LanguageHelp(6))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_ExpDir)
    SetStatusBarText(LanguageHelp(7))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Button_SearchDir_SaveOrt)
    SetStatusBarText(LanguageHelp(8))
  ElseIf GetMouseOverGadget(#Hauptfenster, #String_DisplayPath)
    SetStatusBarText(LanguageHelp(9))
  ElseIf GetMouseOverGadget(#Hauptfenster, #TrackBar_SaveIntervall)
    SetStatusBarText(LanguageHelp(10))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_SaveIntervall)
    SetStatusBarText(LanguageHelp(11))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_LO)
    SetStatusBarText(LanguageHelp(12))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_RO)
    SetStatusBarText(LanguageHelp(13))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_LU)
    SetStatusBarText(LanguageHelp(14))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_RU)
    SetStatusBarText(LanguageHelp(15))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_OT)
    SetStatusBarText(LanguageHelp(16))
  ElseIf GetMouseOverGadget(#Hauptfenster, #String_OT)
    SetStatusBarText(LanguageHelp(17))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_AddTimeDate)
    SetStatusBarText(LanguageHelp(18))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Button_Font)
    SetStatusBarText(LanguageHelp(19))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_Signalton)
    SetStatusBarText(LanguageHelp(20))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_DeskModeTest)
    SetStatusBarText(LanguageHelp(21))
  ElseIf GetMouseOverGadget(#Hauptfenster, #CheckBox_AutoClipboardSave)
    SetStatusBarText(LanguageHelp(22))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_SNTime)
    SetStatusBarText(LanguageHelp(23))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_SNDate)
    SetStatusBarText(LanguageHelp(24))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_SNTimeDate)
    SetStatusBarText(LanguageHelp(25))
  ElseIf GetMouseOverGadget(#Hauptfenster, #Radio_SNNummeriert)
    SetStatusBarText(LanguageHelp(26))
  Else
    SetStatusBarText(LanguageHelp(0))
  EndIf

  Event = WindowEvent()
  If Event

    If Event = #PB_Event_SysTray
      If EventType() = #PB_EventType_RightClick
        DisplayPopupMenu(#Menu_Hauptfenster,WindowID(#Hauptfenster))
      EndIf

      If EventType() = #PB_EventType_LeftClick
        HidingWindow(#Hauptfenster,#False)
        SetForegroundWindow_(WindowID(#Hauptfenster))
      EndIf
    EndIf

    ;- GadgetEvent Bereich
    If Event = #PB_Event_Gadget
      Select EventGadget()

        Case #CheckBox_ExpDir
          If GetGadgetState(#CheckBox_ExpDir)
            DisableGadget(#Button_SearchDir_SaveOrt, #True)
            SetGadgetText(#String_DisplayPath, ExecutableDirectory()+"Export")
          Else
            DisableGadget(#Button_SearchDir_SaveOrt, #False)
            If SavePath <> ""
              SetGadgetText(#String_DisplayPath, SavePath)
            EndIf
          EndIf

        Case #Button_SearchDir_SaveOrt
          TestString = ""
          TestString = PathRequester(LanguageDialog(7), SavePath)
          If TestString <> "" And FileSize(TestString) = -2
            SavePath = TestString
            SetGadgetText(#String_DisplayPath, SavePath)
          Else
            SavePath = ExecutableDirectory() + "Export"
            DisableGadget(#Button_SearchDir_SaveOrt, #True)
            SetGadgetState(#CheckBox_ExpDir, #True)
            SetGadgetText(#String_DisplayPath, ExecutableDirectory()+"Export")
          EndIf

        Case #CheckBox_AutoClipboardSave
          ClearClipboard() ;Damit nicht sofort der Clipboard Inhalt unerwünscht gespeichert wird.

        Case #URL_HPage
          OpenUrl("http://www.kaisnet.de")

        Case #Button_FirstStart_OK
          If GetGadgetState(#CheckBox_FirstStart_Show)
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #False)
          Else
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #True)
          EndIf
          HideWindow(#FirstStart,#True)

        Case #Button_Font
          If FontRequester(Fontname, Fontsize, #PB_FontRequester_Effects, Fontcolor)
            Fontname = SelectedFontName()
            Fontsize = SelectedFontSize()
            Fontstyle = SelectedFontStyle()
            Fontcolor = SelectedFontColor()
          EndIf

        Case #TrackBar_SaveIntervall
          SetGadgetText(#Text_SaveIntervallDisp, Str(GetGadgetState(#TrackBar_SaveIntervall)) + " " + LanguageGadget(12))

        Case #CheckBox_OT
          If GetGadgetState(#CheckBox_OT)
            SetGadgetState(#CheckBox_AddTimeDate, #False)
            DisableGadget(#String_OT, #False)
            DisableGadget(#Button_Font, #False)
          Else
            DisableGadget(#String_OT, #True)
            DisableGadget(#Button_Font, #True)
          EndIf

        Case #CheckBox_AddTimeDate
          If GetGadgetState(#CheckBox_AddTimeDate)
            SetGadgetState(#CheckBox_OT, #False)
            DisableGadget(#String_OT, #True)
            DisableGadget(#Button_Font, #False)
          Else
            DisableGadget(#String_OT, #True)
            DisableGadget(#Button_Font, #True)
          EndIf

      EndSelect
    EndIf

    ;- MenuEvent Bereich
    If Event = #PB_Event_Menu

      ;Aktuelle Sprache im Menu selectieren und aktivieren
      If EventMenu() >= #Menu_Hauptfenster_MinLanguage And EventMenu() <= #Menu_Hauptfenster_MinLanguage-1+LanguageMenu(0)
        For a = 1 To LanguageMenu(0)
          SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_MinLanguage-1+a, #False)
          If #Menu_Hauptfenster_MinLanguage-1+a = EventMenu()
            SetMenuItemState(#Menu_Hauptfenster, EventMenu(), #True)
            LanguageName = GetPreferenceGroupName(ExecutableDirectory()+"Language.ini",a+1)
            WritePreferenceValue(ExecutableDirectory()+"Language.ini", "Main", "Language", GetPreferenceGroupName(ExecutableDirectory()+"Language.ini", EventMenu()-#Menu_Hauptfenster_MinLanguage+2))
            SetLanguage(LanguageName)
          EndIf
        Next
      EndIf

      Select EventMenu()

        Case #Menu_Hauptfenster_Info
          HidingWindow(#InfoFenster, #False)

        Case #Menu_Hauptfenster_Help
          If FileSize(ExecutableDirectory() + "ScreenshotManager.chm") > 0
            OpenHelp(ExecutableDirectory() + "ScreenshotManager.chm", "")
          Else
            MessageRequester("Fehler", "Die Hilfedatei konnte nicht gefunden werden." + Chr(13) + "" + Chr(13) + "'Programmpath\ScreenshotManager.chm'", #MB_OK|#MB_ICONERROR)
          EndIf

        Case #Menu_Hauptfenster_ClearClipboard
          If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard)
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard, #False)
            ClearClipboardbyStart = #False
          Else
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ClearClipboard, #True)
            ClearClipboardbyStart = #True
          EndIf

        Case #Menu_Hauptfenster_OpenWindow
          HidingWindow(#Hauptfenster, #False)

        Case #Menu_Hauptfenster_OpenScreenFolder
          If GetGadgetState(#CheckBox_ExpDir)
            SavePath = ExecutableDirectory()+"Export"
          EndIf
          RunProgram("explorer.exe",SavePath,"")

        Case #Menu_Hauptfenster_Beenden
          Beenden()

        Case #Menu_Hauptfenster_ShowFirstWindow
          If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow)
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #False)
            FirstStart = 0
          Else
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowFirstWindow, #True)
            FirstStart = 1
          EndIf

        Case #Menu_Hauptfenster_ShowEndMsg
          If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg)
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg, #False)
            ShowEndMsg = 0
          Else
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowEndMsg, #True)
            ShowEndMsg = 1
          EndIf

        Case #Menu_Hauptfenster_ShowSPMsg
          If GetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg)
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg, #False)
            ShowQMsg = 0
          Else
            SetMenuItemState(#Menu_Hauptfenster, #Menu_Hauptfenster_ShowSPMsg, #True)
            ShowQMsg = 1
          EndIf

      EndSelect
    EndIf

    If Event = #PB_Event_CloseWindow
      Select EventWindow()
        Case #Hauptfenster
          Beenden()
        Case #InfoFenster
          HideWindow(#InfoFenster, #True)
        Case #FirstStart
          HideWindow(#FirstStart, #True)
      EndSelect
    EndIf

  Else
    Delay(10)
  EndIf
ForEver
; IDE Options = PureBasic 4.40 Beta 5 (Windows - x86)
; CursorPosition = 1177
; FirstLine = 1156
; Folding = -----
; EnableAsm
; EnableXP
; UseIcon = Icon1.ico
; Executable = ScreenshotManager.exe
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 8
; EnableBuildCount = 0
; EnableExeConstant