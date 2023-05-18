#!/bin/bash

set -euo pipefail

set -x

MINIFORGE_VERSION="23.1.0-1"

curl -sL "https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/Miniforge3-Linux-x86_64.sh" > miniforge.sh
chmod +x miniforge.sh

rm -rf conda pyenv
mkdir -p conda pyenv

./miniforge.sh -b -f -p conda

CONDA="./conda/condabin/conda"

"${CONDA}" create -y -p ./pyenv
"${CONDA}" env update -f ./env.yaml -p ./pyenv
"${CONDA}" clean -a -y

rm -f pyenv.zip
(
	cd pyenv
	zip -Xr ../pyenv.zip *
)
