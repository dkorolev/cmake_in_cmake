#!/bin/bash

set -e

echo '# Running the code and the test.'
echo

for RUN in "cmake -B build" "cmake --build build" build/cmake/hw build/cmake/test_add ; do
  echo '$ '${RUN}
  ${RUN}
  echo
done

echo '# All done.'
