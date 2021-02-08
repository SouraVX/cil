// RUN: %cml -cpp %s -o %t && %t | FileCheck %s
// XFAIL: *
#include <iostream>

class A {
  public:
    int a;
};

int main() {
  A *val = new A;
  val->a = 11;
  std::cout << val->a << "\n"; // CHECK: 11
  delete val;
  return 0;
}
