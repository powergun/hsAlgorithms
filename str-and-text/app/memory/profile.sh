#!/usr/bin/env bash

set -euo pipefail

# cd app/memory
# stack exec -- ghc Main.hs -rtsopts -fforce-recomp -prof
# ./Main +RTS -p -hc
# 
# open Main.ps

BUILDDIR=".build"

preparation() {
    rm -rf "${BUILDDIR}"
    mkdir -p "${BUILDDIR}"
    cp Main.hs "${BUILDDIR}"
    cd "${BUILDDIR}" || exit 1
}

compile() {
    stack exec -- ghc Main.hs -rtsopts -fforce-recomp -prof
}

profile() {
    ./Main +RTS -p -hc
    stack exec -- hp2ps -e8in -c Main.hp
}

preparation
compile
profile
cd ..
