#!/bin/bash

die() {
    echo $1
    exit 1
}

which virtualenv > /dev/null
[[ $? -eq 0 ]] || die "virtualenv required for this script, please install"
[[ ! -z ${JP_BASE} ]] || die "JP_BASE variable not set, not sure where to install JPype from"
[[ ! -z ${BP_BASE} ]] || die "BP_BASE variable not set, not sure where to install python-boilerpipe from"

SCRIPT_DIR=$(dirname $0)
HOME_DIR=$(dirname ${SCRIPT_DIR})
VENV_DIR=${HOME_DIR}/phrecommend-py
Echo "Home dir: ${HOME_DIR}"

#Create python environment
virtualenv ${VENV_DIR}

#Activate environment in order to setup builds
source ${VENV_DIR}/bin/activate

#Project dependencies go here
pip install chardet 

#Install Jpype
cd lib/${JP_BASE}
chmod +x setup.py
python setup.py install
cd -

#Install python-boilerpipe
cd lib/${BP_BASE}
chmod +x setup.py
python setup.py install
cd -

#Create environment setup script
echo -e "#!/bin/bash\nsource ${VENV_DIR}/bin/activate" > ${HOME_DIR}/env.sh
chmod a+x ${VENV_DIR}/bin/activate
echo -e "Setup complete, run \"source env.sh\" to set the python environment with the required dependencies,\nand \"deactivate\" to exit the environment"
