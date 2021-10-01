#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original camera-ready build (Oct 2021, TeX Live 2018).
# Requires podman (or docker: export ENGINE=docker). Output: build/main.pdf
# openout_any=a: bibtex runs from /src and must write its .bbl/.blg to /out
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2018-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out main.tex
