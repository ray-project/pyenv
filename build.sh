#!/bin/bash

set -euo pipefail

set -x

MINIFORGE_VERSION="23.1.0-1"

PLATFORM="${PLATFORM:-Linux-x86_64}"

curl -sL "https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/Miniforge3-${PLATFORM}.sh" > miniforge.sh
chmod +x miniforge.sh

rm -rf conda pyenv
mkdir -p conda pyenv

./miniforge.sh -b -f -p conda

CONDA="./conda/condabin/conda"

"${CONDA}" create -y -p ./pyenv
"${CONDA}" env update -f ./env.yaml -p ./pyenv
"${CONDA}" clean -a -y

rm -f "conda-${PLATFORM}.zip"
(
	cd conda
	zip -Xr "../conda-${PLATFORM}.zip" *
)

rm -f "pyenv-${PLATFORM}.zip"
(
	cd pyenv
	zip -Xr "../pyenv-${PLATFORM}.zip" *
)

