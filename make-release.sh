#!/bin/bash
VERSION=$(cat VERSION)
if [ ! -f /usr/bin/wget ]; then echo "please install wget"; exit; fi
if [ ! -f /usr/bin/zip ];  then echo "please install zip";  exit; fi
if [ ! -d /tmp/hadoop4win-src ]; then 
  mkdir -p /tmp/hadoop4win-src
  git archive master | tar -x -C /tmp/hadoop4win-src
  if [ ! -f /tmp/hadoop4win-src/files/cyg-setup.exe ]; then
    wget http://cygwin.com/setup.exe -O /tmp/hadoop4win-src/files/cyg-setup.exe
  fi
  if [ ! -f /tmp/hadoop4win-src/make-release.sh ]; then
    rm /tmp/hadoop4win-src/make-release.sh
  fi
  (cd /tmp; zip -r hadoop4win-src-${VERSION}.zip hadoop4win-src; )
  mv /tmp/hadoop4win-src-${VERSION}.zip .
  rm -rf /tmp/hadoop4win-src
fi
