#!/bin/bash

set -e

DIR=$(dirname "${BASH_SOURCE[0]}")

if ! js --version >/dev/null ; then
  echo 'No `jq`.'
else
  (cd "${DIR}/../.vscode";
   for i in *.json ; do cat "${i}" | jq --indent 2 . >"${i}.tmp" ; mv "${i}.tmp" "${i}"; done)
fi
