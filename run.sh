#!/bin/bash

set -e

echo '# Running the code and the test.'
echo

for RUN in "cmake -B build" "cmake --build build" build/cmake/hw build/cmake/test_add ; do
  echo '$ '${RUN}
  ${RUN}
  echo
done

echo '# Making sure the `cmake/CMakeLists.txt` file is not modified unnecessarily.'
echo
for RUN in "stat cmake/CMakeLists.txt" "cmake -B build" "stat cmake/CMakeLists.txt" ; do
  echo '$ '${RUN}
  ${RUN}
  echo
done

echo '# Making sure the altered `cmake/CMakeLists.txt` is overwritten.'
echo
echo "# Dummy." >> cmake/CMakeLists.txt
for RUN in "stat cmake/CMakeLists.txt" "cmake -B build" "stat cmake/CMakeLists.txt" ; do
  echo '$ '${RUN}
  ${RUN}
  echo
done

echo '# All done.'
