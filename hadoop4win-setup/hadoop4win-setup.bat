@echo off

REM ####################################################################
REM # Unattended hadoop for windows installation
REM #
REM # License     : GPL
REM # Author      : Jazz Yao-Tsung Wang <jazz@nchc.org.tw>
REM # Last update : $Date$
REM # Version	  : $Rev$
REM #
REM # Usage: hadoop4win-setup.bat
REM #
REM # References:
REM # [1] Henrik Bengtsson, Unattended Cygwin Installation, June 2, 2004.
REM #     http://www.maths.lth.se/help/windows/cygwin/
REM # [2] DRBL-WinRoll
REM #     http://drbl.nchc.org.tw/drbl-winroll
REM #     This script is modified from winroll-setup.bat
REM ####################################################################

set HADOOP_FILE=hadoop-0.20.1.tar.gz
set HADOOP_MIRROR=http://ftp.twaren.net/Unix/Web/apache/hadoop/core/hadoop-0.20.1/
set JDK_FILE=jdk1.6.0_18.zip
set JDK_MIRROR=http://tsmc.classcloud.org/
set CYGWIN_ROOT=C:\hadoop4win
set LOCAL_REPOSITORY=%cd%
set CYGWIN_SETUP=%LOCAL_REPOSITORY%\cygwin_mirror\cyg-setup.exe
set PATH=%PATH%;%cd%\bin

set MY_PACKAGE=%LOCAL_REPOSITORY%\my_packages
set HADOOP_SRC=%MY_PACKAGE%\hadoop\hadoop-*.gz
set HADOOP_DES=%CYGWIN_ROOT%\usr\src
set JDK_SRC=%MY_PACKAGE%\jdk\jdk*.zip
set JDK_DES=%CYGWIN_ROOT%\usr\src

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
REM Assert that there exists a valid %LOCAL_REPOSITORY% directory.
REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IF NOT EXIST "%LOCAL_REPOSITORY%" (
  echo "ERROR: %LOCAL_REPOSITORY% DON'T EXIST"
  exit /B 1
)

IF NOT EXIST "%LOCAL_REPOSITORY%\cygwin_mirror" (
  echo "ERROR: %LOCAL_REPOSITORY%\cygwin_mirror DON'T EXIST"
  exit /B 1
)

IF NOT EXIST "%LOCAL_REPOSITORY%\cygwin_mirror\release" (
  echo "ERROR: %LOCAL_REPOSITORY%\cygwin_mirror\release DON'T EXIST"
  exit /B 1
)

IF NOT EXIST "%LOCAL_REPOSITORY%\cygwin_mirror\setup.ini" (
  echo "ERROR: %LOCAL_REPOSITORY%\cygwin_mirror\setup.ini DON'T EXIST"
  exit /B 1
)

IF NOT EXIST "%CYGWIN_SETUP%" (
  echo "ERROR: %CYGWIN_SETUP% DON'T EXIST"
  exit /B 1
)

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
REM Create a fake installation skeleton for Cygwin setup
REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
IF NOT EXIST "%CYGWIN_ROOT%" (
  mkdir "%CYGWIN_ROOT%"
)

IF NOT EXIST "%CYGWIN_ROOT%\etc\setup" (
  mkdir "%CYGWIN_ROOT%\etc\setup"
) ELSE (
  del /Q "%CYGWIN_ROOT%\etc\setup\last-*"
)

REM -- Note that last-* must *not* containing whitespace, e.g. " " etc. 
REM -- This is why there below is no space in front of ">".

echo Install> "%CYGWIN_ROOT%\etc\setup\last-action"
echo %LOCAL_REPOSITORY%> "%CYGWIN_ROOT%\etc\setup\last-cache"
echo cygwin_mirror> "%CYGWIN_ROOT%\etc\setup\last-mirror"

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
REM Finally, run Cygwin setup quietly
REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo To run  %CYGWIN_SETUP% -q -d -L -l "%LOCAL_REPOSITORY%\cygwin_mirror" -R "%CYGWIN_ROOT%"

REM real do cygwin installation

"%CYGWIN_SETUP%" -q -d -L -l "%LOCAL_REPOSITORY%\cygwin_mirror" -R "%CYGWIN_ROOT%"

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
REM Installation of Hadoop and JDK
REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

IF NOT EXIST "%HADOOP_SRC%" (
  wget "%HADOOP_MIRROR%/%HADOOP_FILE%" -O "%MY_PACKAGE%\hadoop\%HADOOP_FILE%"
)

IF NOT EXIST "%JDK_SRC%" (
  wget "%JDK_MIRROR%/%JDK_FILE%" -O "%MY_PACKAGE%\jdk\%JDK_FILE%"
)

IF NOT EXIST "%JDK_DES%" (
  mkdir "%JDK_DES%"
)

IF NOT EXIST "%CYGWIN_ROOT%\opt\hadoop" (
  copy "%HADOOP_SRC%" "%HADOOP_DES%"
)

IF NOT EXIST "%CYGWIN_ROOT%\lib\jvm" (
  copy "%JDK_SRC%" "%JDK_DES%"
)

copy /Y "%MY_PACKAGE%\hadoop\bin\*" "%CYGWIN_ROOT%\bin"
xcopy /Y /E /I "%MY_PACKAGE%\hadoop\conf-examples" "%HADOOP_DES%\conf-examples"

cls
echo "====================================================="
echo " Please run `hadoop4win-init' to extract Hadoop and"
echo " JDK to proper PATH. It will format HDFS Namenode, too."
echo " ."
echo " Use `start-hadoop' and `stop-hadoop' to run single"
echo " machine hadoop configuration."
echo " ."
echo " Use `jps' to check java process for troubleshooting."
echo "====================================================="
  
CALL "%CYGWIN_ROOT%\Cygwin.bat"
