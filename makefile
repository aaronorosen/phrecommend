SHELL=/bin/sh

PY_ENV_SCRIPT=scripts/env-setup.sh

#JPype deps
JP_VERSION=0.5.4
JP_DOT_VERSION=0.5.4.2
export JP_BASE=JPype-${JP_DOT_VERSION}
JP_ZIP=${JP_BASE}.zip
JP_URL=http://sourceforge.net/projects/jpype/files/JPype/${JP_VERSION}/${JP_ZIP}

#Python-boilerpipe deps
export BP_BASE=python-boilerpipe

dummy : 
	echo "Do nothing"

deps : clean 

	#Update submodules
	git submodule init ; git submodule update

	#Get Jpype
	if [ -d lib/JPype-0.5.4.2 ] ; \
			then echo "JPype-0.5.4.2 exists in lib dir" ; \
	else \
		wget ${JP_URL} -O .tmp/${JP_ZIP} ; \
		if [ ! -d lib ] ; then mkdir lib ; fi ; \
		cd .tmp ; unzip ${JP_ZIP} -d ../lib ; \
	fi

py-env : deps
	bash ${PY_ENV_SCRIPT}

clean : 
	rm -rf .tmp
	mkdir .tmp
