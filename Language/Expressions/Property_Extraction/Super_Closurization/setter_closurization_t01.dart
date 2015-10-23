/*
 * Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The closurization of setter f with respect to superclass S is 
 * defined to be equivalent to (a) {return super.m = a;} if f is named m=, 
 * except that iff two closurizations were created by code declared in the same
 * class with identical bindings of this then super1#m= == super2#m=.
 *
 * @description Check that closurization of setter is equivalent to
 * (a){return super.m = a;}
 *
 * @author sgrekhov@unipro.ru
 */
import '../../../../Utils/expect.dart';

class A {
  int mValue = 0;
  void set m(int val) {
    this.mValue = val;
  }
}

class C extends A {
  void test() {
    var f1 = super#m=;
    var f2 = (a) {return super.m = a;};

    f1(1);
    Expect.equals(1, super.mValue);
    f2(2);
    Expect.equals(2, super.mValue);    
  }
}

main() {
  C o = new C();
  o.test();
}
