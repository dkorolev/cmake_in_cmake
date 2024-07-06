#!/bin/bash

set -e

DIR=$(dirname "${BASH_SOURCE[0]}")

rm -f "${DIR}/CMakeLists.txt.tmp"
if curl -s https://raw.githubusercontent.com/dkorolev/current/add_c5t_project_root/cmake/CMakeLists.txt > "${DIR}/CMakeLists.txt.tmp" ; then
  # TODO(dkorolev): Use a different project name in `C5T/Current/stable/cmake/CMakeLists.txt`.
  sed -i s/c5t_user_project/demo_cmake_in_cmake_project/ "${DIR}/CMakeLists.txt.tmp"
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
