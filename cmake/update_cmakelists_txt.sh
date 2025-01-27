#!/bin/bash

set -e

DIR=$(dirname "${BASH_SOURCE[0]}")

rm -f "${DIR}/CMakeLists.txt.tmp0" "${DIR}/CMakeLists.txt.tmp"
if curl -s https://raw.githubusercontent.com/c5t/current/stable/cmake/CMakeLists.txt > "${DIR}/CMakeLists.txt.tmp0" ; then
  cat "${DIR}/CMakeLists.txt.tmp0" | sed s/c5t_user_project/demo_cmake_in_cmake_project/ > "${DIR}/CMakeLists.txt.tmp"
  if ! [ -f "${DIR}/CMakeLists.txt" ] ; then
    echo 'Downloaded the up-to-date `cmake/CMakeLists.txt`.'
    mv "${DIR}/CMakeLists.txt.tmp" "${DIR}/CMakeLists.txt"
  elif diff -q -w "${DIR}/CMakeLists.txt.tmp" "${DIR}/CMakeLists.txt" >/dev/null ; then
    echo 'On the up-to-date `cmake/CMakeLists.txt`.'
    rm "${DIR}/CMakeLists.txt.tmp"
  else
    DATE=$(date +%Y%m%d-%H%M%S)
    echo 'Using the updated `cmake/CMakeLists.txt`, the old one is saved under `cmake/CMakeLists.txt.'${DATE}'`.'
    mv "${DIR}/CMakeLists.txt" "${DIR}/CMakeLists.txt.${DATE}"
    mv "${DIR}/CMakeLists.txt.tmp" "${DIR}/CMakeLists.txt"
  fi
else
  if [ -f "${DIR}/CMakeLists.txt" ] ; then
    echo 'Warning: Could not `curl` the up-to-date `cmake/CMakeLists.txt`, using the current version, which may be out of date.'
  else
    echo 'Error: No `cmake/CMakeLists.txt`, and could not `curl` it.'
    exit 1
  fi
fi

if [[ "$OSTYPE" == "darwin"* ]] ; then
  echo "export GDB_OR_LLDB=lldb" >"${DIR}/../.vscode/gdb_or_lldb.sh"
else
  echo "export GDB_OR_LLDB=gdb" >"${DIR}/../.vscode/gdb_or_lldb.sh"
fi
chmod +x "${DIR}/../.vscode/gdb_or_lldb.sh"
