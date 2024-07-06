#include <iostream>
#include "lib_mul.h"

int main() {
  for (int i = 1; i <= 3; ++i) {
    for (int j = 1; j <= 3; ++j) {
      std::cout << ' ' << c5t_lib_mul(i, j) << std::flush;
    }
    std::cout << std::endl;
  }
}
