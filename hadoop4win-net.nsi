;Modified from NSIS Modern User Interface
;Example Script Written by Joost Verburg
;including "Multilingual","Header Bitmap"
;and "Start Menu Folder"

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "hadoop4win"
  OutFile "hadoop4win-setup-net.exe"

  ;Default installation folder
  InstallDir "c:\hadoop4win"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\hadoop4win" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Interface Settings

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "hadoop-nsis.bmp"
  !define MUI_ABORTWARNING

  XPStyle on

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "Software\hadoop4win" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\hadoop4win"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

  !insertmacro MUI_PAGE_LICENSE "LICENSE"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages
;first language is the default language
  !insertmacro MUI_LANGUAGE "TradChinese"
  !insertmacro MUI_LANGUAGE "SimpChinese"
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "SpanishInternational"
  !insertmacro MUI_LANGUAGE "Japanese"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "NorwegianNynorsk"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "Greek"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "PortugueseBR"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Ukrainian"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Croatian"
  !insertmacro MUI_LANGUAGE "Bulgarian"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Thai"
  !insertmacro MUI_LANGUAGE "Romanian"
  !insertmacro MUI_LANGUAGE "Latvian"
  !insertmacro MUI_LANGUAGE "Macedonian"
  !insertmacro MUI_LANGUAGE "Estonian"
  !insertmacro MUI_LANGUAGE "Turkish"
  !insertmacro MUI_LANGUAGE "Lithuanian"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Serbian"
  !insertmacro MUI_LANGUAGE "SerbianLatin"
  !insertmacro MUI_LANGUAGE "Arabic"
  !insertmacro MUI_LANGUAGE "Farsi"
  !insertmacro MUI_LANGUAGE "Hebrew"
  !insertmacro MUI_LANGUAGE "Indonesian"
  !insertmacro MUI_LANGUAGE "Mongolian"
  !insertmacro MUI_LANGUAGE "Luxembourgish"
  !insertmacro MUI_LANGUAGE "Albanian"
  !insertmacro MUI_LANGUAGE "Breton"
  !insertmacro MUI_LANGUAGE "Belarusian"
  !insertmacro MUI_LANGUAGE "Icelandic"
  !insertmacro MUI_LANGUAGE "Malay"
  !insertmacro MUI_LANGUAGE "Bosnian"
  !insertmacro MUI_LANGUAGE "Kurdish"
  !insertmacro MUI_LANGUAGE "Irish"
  !insertmacro MUI_LANGUAGE "Uzbek"
  !insertmacro MUI_LANGUAGE "Galician"
  !insertmacro MUI_LANGUAGE "Afrikaans"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Esperanto"

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections

Section "Cygwin 1.7" Cygwin 

  SectionIn RO
  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  ;Download Cygwin Setup File
  NSISdl::download /TIMEOUT=30000 http://cygwin.com/setup.exe $INSTDIR\cyg-setup.exe
  Pop $0
  StrCmp $0 "success" +3
    MessageBox MB_OK "Download failed: $0"
    Quit

SectionEnd

Section "JDK 1.6.0 update 18"
  ; JDK 1.6.0 update 18 is about 
  AddSize 43531

  ;SectionIn RO
  SetOutPath "$INSTDIR\usr\src"

  ;Download JDK Package
  NSISdl::download /TIMEOUT=30000 http://www.classcloud.org/hadoop4win/jdk1.6.0_18.zip $INSTDIR\usr\src\jdk1.6.0_18.zip
  Pop $0
  StrCmp $0 "success" +3
    MessageBox MB_OK "Download failed: $0"
    Quit
SectionEnd

Section "Hadoop 0.20.2" Hadoop
  ; hadoop-0.20.2.tar.gz is about 43,531 KB
  AddSize 43531

  ;SectionIn RO
  SetOutPath "$INSTDIR"

  ;Download Hadoop Package
  NSISdl::download /TIMEOUT=30000 http://ftp.twaren.net/Unix/Web/apache/hadoop/core/hadoop-0.20.2/hadoop-0.20.2.tar.gz $INSTDIR\usr\src\hadoop-0.20.2.tar.gz
  Pop $0
  StrCmp $0 "success" +3
    MessageBox MB_OK "Download failed: $0"
    Quit

  ;Related Script
  SetOutPath "$INSTDIR\etc\postinstall"
  File /oname=z1_hadoop4win.sh  my_packages/hadoop/bin/hadoop4win-init
  SetOutPath "$INSTDIR\bin"
  File my_packages/hadoop/bin/hadoop4win-init
  File my_packages/hadoop/bin/stop-hadoop
  File my_packages/hadoop/bin/start-hadoop
SectionEnd

Section "Ant 1.8.2" 
  ; ant-0.20.2.tar.gz is about 43,531 KB
  AddSize 43531

  SetOutPath "$INSTDIR"

  ;Download Package
  NSISdl::download /TIMEOUT=30000 http://ftp.twaren.net/Unix/Web/apache/ant/ant-current-bin.zip $INSTDIR\usr\src\ant-current-bin.zip
  Pop $0
  StrCmp $0 "success" +3
    MessageBox MB_OK "Download failed: $0"
    Quit

  ;Related Script
  SetOutPath "$INSTDIR\etc\postinstall"
  File /oname=z2_ant.sh my_packages/ant/bin/ant-init
  SetOutPath "$INSTDIR\bin"
  File my_packages/ant/bin/ant-init
SectionEnd

Section "HBase 0.20.6"
  ;hbase-0.20.6.tar.gz is about 43,531 KB
  AddSize 43531

  SetOutPath "$INSTDIR"

  ;Download HBase Package
  NSISdl::download /TIMEOUT=30000 http://ftp.twaren.net/Unix/Web/apache/hbase/hbase-0.20.6/hbase-0.20.6.tar.gz $INSTDIR\usr\src\hbase-0.20.6.tar.gz
  Pop $0
  StrCmp $0 "success" +3
    MessageBox MB_OK "Download failed: $0"
    Quit

  ;Related Script
  SetOutPath "$INSTDIR\etc\postinstall"
  File /oname=z3_hbase.sh my_packages/hbase/bin/hbase-init
  SetOutPath "$INSTDIR\bin"
  File my_packages/hbase/bin/hbase-init
  File my_packages/hbase/bin/stop-hbase
  File my_packages/hbase/bin/start-hbase
  File my_packages/hbase/bin/start-hbase-daemon
SectionEnd

Section "" Install

  SetOutPath "$INSTDIR"

  ;Start Installation Process of Cygwin
  nsExec::Exec '"$INSTDIR\cyg-setup.exe" -q -D -O -s http://mirror.mcs.anl.gov/cygwin -P cygrunsrv,file,openssh,perl,procps,ncurses,rsync,sharutils,shutdown,subversion,tcp_wrappers,termcap,unzip,wget,zip,zlib'
  nsExec::Exec 'cmd /c move "$INSTDIR\http*" "$INSTDIR\cygwin_mirror"'
  nsExec::Exec '"$INSTDIR\cyg-setup.exe" -q -d -N -L -l "$INSTDIR\cygwin_mirror" -R "$INSTDIR" -P cygrunsrv,file,openssh,perl,procps,ncurses,rsync,sharutils,shutdown,subversion,tcp_wrappers,termcap,unzip,wget,zip,zlib'

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"

  ;Create Start Menu Folder
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  ;Create shortcuts
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\hadoop4win.lnk" "$INSTDIR\Cygwin.bat"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

  ;Store installation folder
  WriteRegStr HKCU "Software\hadoop4win" "" $INSTDIR
SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  ;Check if there are more than two installers running
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "myMutex") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "Another installer is running!"
    Abort

  ;Check internet connection
  Call ConnectInternet

  ;Show Multi-Language Selection
  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
;Descriptions

  ;USE A LANGUAGE STRING IF YOU WANT YOUR DESCRIPTIONS TO BE LANGAUGE SPECIFIC

  ;Assign descriptions to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Cygwin} "Linux-like environment for Windows (required)."
  !insertmacro MUI_DESCRIPTION_TEXT ${Hadoop} "Open-source data processing framework"
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\uninstall.exe"
  RMDir /r /REBOOTOK "$INSTDIR\bin"
  RMDir /r /REBOOTOK "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir /r /REBOOTOK "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\hadoop4win"

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd

; ConnectInternet (使用 Dialer 插件)
; Written by Joost Verburg 
;
; 當沒有可用連接時該函數嘗試去建立一個網際網路連接。
; 如果你不能確認使用該安裝程式前已有可用的連接的話
; 在用 NSISdl 插件下載前最好先調用這個函數。
; 
; 這個函數需要 Internet Explorer 3，但是如果 IE3 未安裝的話
; 將會詢問是否手動連接。

Function ConnectInternet

  Push $R0
    
    ClearErrors
    Dialer::AttemptConnect
    IfErrors noie3
    
    Pop $R0
    StrCmp $R0 "online" connected
      MessageBox MB_OK|MB_ICONSTOP "Cannot connect to the internet."
      Quit ;這裡將會登出安裝程式。你可以改為你自己的錯誤處理代碼。
    
    noie3:
  
    ; IE3 未安裝
    MessageBox MB_OK|MB_ICONINFORMATION "Please connect to the internet first!"
    
    connected:
  
  Pop $R0
  
FunctionEnd
