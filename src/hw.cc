#include <iostream>

#include "bricks/strings/join.h"

int main() {
  std::cout << current::strings::Join({"Hello", "World!"}, ", ") << std::endl;
}
