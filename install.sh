#!/bin/bash

set -euo pipefail

set -x

CONDA_VERSION="23.1.0-1"

curl -sL "https://github.com/conda-forge/miniforge/releases/download/${CONDA_VERSION}/Miniforge3-Linux-x86_64.sh" > miniforge.sh
chmod +x miniforge.sh

rm -rf conda pyenv
mkdir -p conda pyenv

./miniforge.sh -b -f -p conda

CONDA="./conda/condabin/conda"

"${CONDA}" create -y -p ./pyenv
"${CONDA}" env update -f ./env.yaml -p ./pyenv
"${CONDA}" clean -a -y

rm -f pyenv_base.zip
(
	cd pyenv
	zip -Xr ../pyenv_base.zip *
)

if [[ -e env_plus.yaml ]]; then
	"${CONDA}" env update -f ./env_plus.yaml -p ./pyenv

	rm -f pyenv_plus.zip
	(
		cd pyenv
		zip -Xr ../pyenv_plus.zip *
	)
fi
