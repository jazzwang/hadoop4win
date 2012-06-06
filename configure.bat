wget 
REM 純下載 Cygwin Base 分類下的檔案
cyg-setup.exe -q -D -O -s http://mirror.mcs.anl.gov/cygwin -C base -P cygrunsrv,file,openssh,perl,procps,ncurses,rsync,sharutils,shutdown,subversion,tcp_wrappers,termcap,unzip,wget,zip,zlib
REM 把 http 開頭的目錄搬到 cygwin_mirror
move http* cygwin_mirror
