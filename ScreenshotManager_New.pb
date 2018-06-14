EnableExplicit

Enumeration 
  #Win_Main
EndEnumeration

Enumeration 
  #G_FR_Main_ScreenshotKey
  #G_CH_Main_ScreenshotKeyStrg
  #G_CH_Main_ScreenshotKeyAlt
  #G_CH_Main_ScreenshotKeyShift
  #G_CB_Main_ScreenshotKeyMisc
  #G_FR_Main_SaveFormat
  #G_OP_Main_SaveFormatBMP
  #G_OP_Main_SaveFormatJPG
  #G_OP_Main_SaveFormatPNG
  #G_FR_Main_SavePath
  #G_CH_Main_SavePathExport
  #G_BN_Main_SavePathChange
  #G_SR_Main_SavePath
  #G_FR_Main_AutoSave
  #G_TX_Main_AutoSaveDescription
  #G_CH_Main_AutoSaveActive
  #G_TB_Main_AutoSaveIntervall
  #G_TX_Main_AutoSaveIntervall
  #G_FR_Main_AddText
  #G_TX_Main_AddTextPos
  #G_CB_Main_AddTextPos
  #G_OP_Main_AddTextCustom
  #G_OP_Main_AddTextDate
  #G_SR_Main_AddTextCustom
  #G_BN_Main_AddTextFont
  #G_FR_Main_SaveName
  #G_CB_Main_SaveName
  #G_SR_Main_SaveName
  #G_FR_Main_Preferences
  #G_CH_Main_Prefs_SaveSound
  #G_CH_Main_Prefs_CheckDesktopSize
  #G_CH_Main_Prefs_SaveClipboard
EndEnumeration

Enumeration 
  #StatusBar_Main
EndEnumeration

Enumeration 
  #Menu_SysTray
EndEnumeration

Enumeration 
  #Mnu_SysTray_ShowWindow
  #Mnu_SysTray_SaveFolder
  #Mnu_SysTray_Info
  #Mnu_SysTray_Help
  #Mnu_SysTray_Pref_ClearClipboard
  #Mnu_SysTray_Pref_ShowFirstStart
  #Mnu_SysTray_Pref_AskEnd
  #Mnu_SysTray_Pref_AskSavePref
  #Mnu_SysTray_End
  #Mnu_SysTray_Language
EndEnumeration

#PrgName = "Screenshot Manager"
#PrgVers = 200

Structure _Event
  WindowEvent.i
  EventWindow.i
  EventGadget.i
  EventMenu.i
  EventType.i
EndStructure

Procedure OpenWindow_Main()
  If IsWindow(#Win_Main)
    HideWindow(#Win_Main, 0)
    SetActiveWindow(#Win_Main)
  Else
    If OpenWindow(#Win_Main, 0, 0, 492, 355, #PrgName, #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_ScreenCentered)
      ; Gadgets
      Frame3DGadget(#G_FR_Main_ScreenshotKey, 5, 5, 250, 55, "Screenshot Taste")
        CheckBoxGadget(#G_CH_Main_ScreenshotKeyStrg, 15, 25, 50, 20, "Strg")
        CheckBoxGadget(#G_CH_Main_ScreenshotKeyAlt, 65, 25, 50, 20, "Alt")
        CheckBoxGadget(#G_CH_Main_ScreenshotKeyShift, 115, 25, 50, 20, "Shift")
        ComboBoxGadget(#G_CB_Main_ScreenshotKeyMisc, 165, 25, 80, 20)
      Frame3DGadget(#G_FR_Main_SaveFormat, 5, 65, 250, 90, "Speicherformat")
        OptionGadget(#G_OP_Main_SaveFormatBMP, 15, 85, 225, 20, "Bitmap (*.bmp)")
        OptionGadget(#G_OP_Main_SaveFormatJPG, 15, 105, 225, 20, "Joint Photographic Experts Group (*.jpg)")
        OptionGadget(#G_OP_Main_SaveFormatPNG, 15, 125, 225, 20, "Portable Network Graphics (*.png)")
      Frame3DGadget(#G_FR_Main_SavePath, 5, 160, 250, 80, "Speicherort")
        CheckBoxGadget(#G_CH_Main_SavePathExport, 15, 180, 180, 20, "Export Ordner")
        ButtonGadget(#G_BN_Main_SavePathChange, 210, 180, 35, 20, "...")
        StringGadget(#G_SR_Main_SavePath, 15, 205, 230, 20, "", #PB_String_ReadOnly)
      Frame3DGadget(#G_FR_Main_AutoSave, 5, 245, 250, 80, "Automatische Speicherung")
        TextGadget(#G_TX_Main_AutoSaveDescription, 15, 270, 150, 20, "Speicherintervall", #SS_CENTERIMAGE)
        TrackBarGadget(#G_TB_Main_AutoSaveIntervall, 15, 290, 165, 20, 5, 600)
        CheckBoxGadget(#G_CH_Main_AutoSaveActive, 170, 270, 75, 20, "Aktiviert")
        TextGadget(#G_TX_Main_AutoSaveIntervall, 185, 290, 60, 20, "5 Sek.", #SS_CENTERIMAGE)
      Frame3DGadget(#G_FR_Main_AddText, 260, 5, 225, 135, "Text hinzufügen")
        TextGadget(#G_TX_Main_AddTextPos, 270, 25, 175, 15, "Position")
        ComboBoxGadget(#G_CB_Main_AddTextPos, 270, 40, 205, 20)
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Oben - Links")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Oben - Mitte")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Oben - Rechts")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Mitte - Links")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Mitte - Mitte")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Mitte - Rechts")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Unten - Links")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Unten - Mitte")
          AddGadgetItem(#G_CB_Main_AddTextPos, -1, "Unten - Rechts")
        OptionGadget(#G_OP_Main_AddTextDate, 270, 65, 150, 20, "Datum und Zeit")
        OptionGadget(#G_OP_Main_AddTextCustom, 270, 85, 150, 20, "Eigener Text")
        StringGadget(#G_SR_Main_AddTextCustom, 270, 105, 140, 20, "Screenshot Manager")
        ButtonGadget(#G_BN_Main_AddTextFont, 415, 105, 60, 20, "Font")
      Frame3DGadget(#G_FR_Main_SaveName, 260, 145, 225, 85, "Speichername")
        ComboBoxGadget(#G_CB_Main_SaveName, 270, 165, 205, 20)
          AddGadgetItem(#G_CB_Main_SaveName, -1, "Datum")
          AddGadgetItem(#G_CB_Main_SaveName, -1, "Zeit")
          AddGadgetItem(#G_CB_Main_SaveName, -1, "Datum und Zeit")
          AddGadgetItem(#G_CB_Main_SaveName, -1, "Nummeriert")
          AddGadgetItem(#G_CB_Main_SaveName, -1, "Formatiert")
        StringGadget(#G_SR_Main_SaveName, 270, 195, 205, 20, "")
      Frame3DGadget(#G_FR_Main_Preferences, 260, 235, 225, 90, "Sonstiges")
        CheckBoxGadget(#G_CH_Main_Prefs_SaveSound, 270, 255, 205, 20, "Signalton beim Speichern")
        CheckBoxGadget(#G_CH_Main_Prefs_CheckDesktopSize, 270, 275, 205, 20, "Grafiken auf Destkopauflösung testen")
        CheckBoxGadget(#G_CH_Main_Prefs_SaveClipboard, 270, 295, 205, 20, "Zwischenablage Speichern")
      ; Statusbar
      If CreateStatusBar(#StatusBar_Main, WindowID(#Win_Main))
        AddStatusBarField(#PB_Ignore)
      Else
        MessageRequester("Fehler", "StatusBar 'Main' konnte nicht erstellt werden.", #MB_ICONERROR|#MB_OK) : End
      EndIf
      
      HideWindow(#Win_Main, 0)
    Else
      MessageRequester("Fehler", "Fenster 'Main' konnte nicht erstellt werden.", #MB_ICONERROR|#MB_OK) : End
    EndIf
  EndIf
EndProcedure

Procedure EndApplication()
  End
EndProcedure

Procedure WinLoop()
  OpenWindow_Main()
  
  Protected Event._Event
  
  Repeat
    Event\WindowEvent = WaitWindowEvent()
    Select Event\WindowEvent
      Case #PB_Event_CloseWindow
        Select Event\EventWindow
          Case #Win_Main
            EndApplication()
        EndSelect
    EndSelect
  ForEver
  
EndProcedure

WinLoop()
; IDE Options = PureBasic 4.40 Beta 5 (Windows - x86)
; CursorPosition = 59
; FirstLine = 48
; Folding = --
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 220
; EnableBuildCount = 0
; EnableExeConstant