wget 
REM �¤U�� Cygwin Base �����U���ɮ�
cyg-setup.exe -q -D -O -s http://mirror.mcs.anl.gov/cygwin -C base -P cygrunsrv,file,openssh,perl,procps,ncurses,rsync,sharutils,shutdown,subversion,tcp_wrappers,termcap,unzip,wget,zip,zlib
REM �� http �}�Y���ؿ��h�� cygwin_mirror
move http* cygwin_mirror
