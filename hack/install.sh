#!/bin/bash
set -eux -o pipefail

export DOWNLOADS=/tmp/dl
export BIN=${BIN:-/usr/local/bin}

mkdir -p $DOWNLOADS

ARCHITECTURE=""
case $(uname -m) in
    i386)               ARCHITECTURE="386" ;;
    i686)               ARCHITECTURE="386" ;;
    x86_64)             ARCHITECTURE="amd64" ;;
    arm|armv7l|armv8l)  dpkg --print-architecture | grep -q "arm64" && ARCHITECTURE="arm64" || ARCHITECTURE="arm" ;;
esac

ARCHITECTURE=${DRONE_STAGE_ARCH:-$ARCHITECTURE}

for product in $*; do
  ARCHITECTURE=$ARCHITECTURE "$(dirname $0)/installers/install-${product}.sh"
done
