VERSION=0.1.4

all: full net

full:
	cp hadoop-*.tar.gz hadoop4win-setup/my_packages/hadoop/.
	cp jdk*.zip hadoop4win-setup/my_packages/jdk/.
	zip -r hadoop4win-setup-full_${VERSION}.zip hadoop4win-setup

net:
	rm -f hadoop4win-setup/my_packages/hadoop/hadoop-*.tar.gz
	rm -f hadoop4win-setup/my_packages/jdk/jdk*.zip
	zip -r hadoop4win-setup-net_${VERSION}.zip hadoop4win-setup

clean:
	rm -f hadoop4win-setup-full_${VERSION}.zip hadoop4win-setup-net_${VERSION}.zip
