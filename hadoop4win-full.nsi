;Modified from NSIS Modern User Interface
;Example Script Written by Joost Verburg
;including "Multilingual","Header Bitmap"
;and "Start Menu Folder"

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  !define VERSION "0.1.6"

  ;Name and file
  Name "hadoop4win"
  OutFile "hadoop4win-setup-full_${VERSION}.exe"

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

Section "Cygwin 2.769" Cygwin 
  ; Cygwin Package is about 45 MB
  ; Installed Cygwin is about 177 MB
  AddSize 222000

  SectionIn RO
  SetOutPath "$INSTDIR"
  IfFileExists $INSTDIR\cyg-setup.exe +4 0
	DetailPrint "[*] Copying Cygwin Local Mirror ........"
	File /r cygwin_mirror
	File files\cyg-setup.exe
	File files\apt-cyg
SectionEnd

Section "JDK 1.6.0 update 21"
  ; JDK 1.6.0 update 21 is about 64 MB
  ; /usr/lib/jvm/jdk1.6.0_21 is about 179 MB
  AddSize 141000

  SectionIn RO
  SetOutPath "$INSTDIR\usr\src"

  ;Copying JDK Package
  IfFileExists $INSTDIR\usr\src\jdk1.6.0_21.zip +2 0
      DetailPrint "[*] Copying JDK ........"
      File files\jdk1.6.0_21.zip
SectionEnd

Section "Hadoop 0.20.2" Hadoop
  ; hadoop-0.20.2.tar.gz is about 43 MB
  ; /opt/hadoop is about 135 MB
  AddSize 168000

  SectionIn RO
  SetOutPath "$INSTDIR"
  File my_packages\hadoop\bin\hadoop.ico

  ;Copying Hadoop Package
  SetOutPath "$INSTDIR\usr\src"
  IfFileExists $INSTDIR\usr\src\hadoop-0.20.2.tar.gz +2 0
      DetailPrint "[*] Copying Hadoop Package ........"
      File files\hadoop-0.20.2.tar.gz

  ;Related Script
  SetOutPath "$INSTDIR\bin"
  File my_packages\hadoop\bin\hadoop4win-init
  File my_packages\hadoop\bin\stop-hadoop
  File my_packages\hadoop\bin\start-hadoop
  File my_packages\hadoop\bin\start-hadoop-daemon
SectionEnd

Section "Ant 1.8.4" 
  ; ant-1.8.4-bin.tar.gz is about 43,531 KB
  AddSize 43531

  SetOutPath "$INSTDIR\usr\src"

  ;Copying Ant Package
  IfFileExists $INSTDIR\usr\src\ant-1.8.4-bin.tar.gz +2 0
      DetailPrint "[*] Copying Ant Package ........"
      File files\ant-1.8.4-bin.tar.gz

  ;Related Script
  SetOutPath "$INSTDIR\bin"
  File my_packages\ant\bin\ant-init
SectionEnd

Section "HBase 0.92.1"
  ;hbase-0.92.1.tar.gz is about 43,531 KB
  AddSize 43531

  SetOutPath "$INSTDIR"
  File my_packages\hbase\bin\hbase.ico

  ;Copying HBase Package
  SetOutPath "$INSTDIR\usr\src"
  IfFileExists $INSTDIR\usr\src\hbase-0.92.1.tar.gz +2 0
      DetailPrint "[*] Copying HBase Package ........"
      File files\hbase-0.92.1.tar.gz

  ;Related Script
  SetOutPath "$INSTDIR\bin"
  File my_packages\hbase\bin\hbase-init
  File my_packages\hbase\bin\stop-hbase
  File my_packages\hbase\bin\start-hbase
  File my_packages\hbase\bin\start-hbase-daemon
SectionEnd

Section "Pig 0.10.0"
  ; pig-0.10.0.tar.gz is about 119,208 KB after decompress
  AddSize 119208
  SetOutPath "$INSTDIR"
  File my_packages\pig\bin\pig.ico

  ;Copying Pig Package
  SetOutPath "$INSTDIR\usr\src"
  IfFileExists $INSTDIR\usr\src\pig-0.10.0.tar.gz +2 0
      DetailPrint "[*] Copying Pig ........."
      File files\pig-0.10.0.tar.gz

  ;Related Script
  SetOutPath "$INSTDIR\bin"
  File my_packages\pig\bin\pig-init
SectionEnd

Section "Hive 0.8.1"
  ; hive-0.8.1-bin.tar.gz is about 23,172 KB after decompress
  AddSize 23172
  SetOutPath "$INSTDIR\usr\src"

  ;Copying Hive Package
  IfFileExists $INSTDIR\usr\src\hive-0.8.1-bin.tar.gz +2 0
      DetailPrint "[*] Copying Hive ........."
      File files\hive-0.8.1-bin.tar.gz

  ;Related Script
  SetOutPath "$INSTDIR\bin"
  File my_packages\hive\bin\hive-init
SectionEnd

Section "" Install

  SetOutPath "$INSTDIR"

  ;Start Installation Process of Cygwin
  DetailPrint "[+] Installing Cygwin ........."
  nsExec::ExecToLog '"$INSTDIR\cyg-setup.exe" -q -d -N -L -l "$INSTDIR\cygwin_mirror" -R "$INSTDIR" -P cygrunsrv,file,openssh,perl,procps,ncurses,rsync,sharutils,shutdown,subversion,tcp_wrappers,termcap,unzip,wget,zip,zlib,wget'
  IfFileExists $INSTDIR\bin\hadoop4win-init 0 +2
    DetailPrint "[+] Installing JDK and Hadoop ........."
    nsExec::ExecToLog '"$INSTDIR\bin\bash.exe" --login -c "/bin/hadoop4win-init"'
  IfFileExists $INSTDIR\bin\ant-init 0 +2
    DetailPrint "[+] Installing Ant ........."
    nsExec::ExecToLog '"$INSTDIR\bin\bash.exe" --login -c "/bin/ant-init"'
  IfFileExists $INSTDIR\bin\hbase-init 0 +2
    DetailPrint "[+] Installing HBase ........."
    nsExec::ExecToLog '"$INSTDIR\bin\bash.exe" --login -c "/bin/hbase-init"'
  IfFileExists $INSTDIR\bin\pig-init 0 +2
    DetailPrint "[+] Installing Pig ........."
    nsExec::ExecToLog '"$INSTDIR\bin\bash.exe" --login -c "/bin/pig-init"'
  IfFileExists $INSTDIR\bin\hive-init 0 +2
    DetailPrint "[+] Installing Hive ........."
    nsExec::ExecToLog '"$INSTDIR\bin\bash.exe" --login -c "/bin/hive-init"'

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"

  ;Create Start Menu Folder
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  ;Create shortcuts
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\hadoop4win.lnk" "$INSTDIR\Cygwin.bat"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\start-hadoop.lnk" "cmd.exe" " /k $INSTDIR\bin\bash.exe --login -c /bin/start-hadoop-daemon" "$INSTDIR\hadoop.ico" 0 SW_SHOWMINIMIZED 
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Hadoop_API_JavaDoc.lnk" "$INSTDIR\opt\hadoop\docs\api\index.html"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\NameNode_Web_UI.lnk" "http://localhost:50070"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\JobTracker_Web_UI.lnk" "http://localhost:50030"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\stop-hadoop.lnk"  "cmd.exe" " /k $INSTDIR\bin\bash.exe --login -c /bin/stop-hadoop"         "$INSTDIR\hadoop.ico" 0 SW_SHOWMINIMIZED
  IfFileExists $INSTDIR\bin\hbase-init 0 +2
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\start-hbase.lnk"  "cmd.exe" " /k $INSTDIR\bin\bash.exe --login -c /bin/start-hbase-daemon"  "$INSTDIR\hbase.ico" 0 SW_SHOWMINIMIZED
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\stop-hbase.lnk"   "cmd.exe" " /k $INSTDIR\bin\bash.exe --login -c /bin/stop-hbase" "$INSTDIR\hbase.ico" 0 SW_SHOWMINIMIZED
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\uninstall.lnk" "$INSTDIR\uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

  ;Store installation folder
  WriteRegStr HKCU "Software\hadoop4win" "" $INSTDIR
SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  ; Reference:
  ; http://omega.idv.tw/nsis/SectionC.11.html#C.11
  ; ----------
  ;Check if there are more than two installers running
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "myMutex") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "Another installer is running!"
    Abort

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
