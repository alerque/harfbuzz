#!/usr/bin/env bash
set -e
set -o pipefail

if [[ -z $GITHUB_TOKEN ]]; then
	echo "No GITHUB_TOKEN secret found, artifact publishing skipped"
	exit
fi

mkdir -p $HOME/.local/bin
export _GHR_VER=v0.13.0
export _GHR=ghr_${_GHR_VER}_linux_amd64
curl -sfL https://github.com/tcnksm/ghr/releases/download/$_GHR_VER/$_GHR.tar.gz |
	tar xz -C $HOME/.local/bin --strip-components=1 $_GHR/ghr

echo $PATH
env
ls -al $HOME/.local/bin
which ghr

ghr -replace \
	-u $CIRCLE_PROJECT_USERNAME \
	-r $CIRCLE_PROJECT_REPONAME \
	$CIRCLE_TAG \
	$1
