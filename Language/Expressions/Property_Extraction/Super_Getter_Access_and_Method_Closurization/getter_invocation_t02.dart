/*
 * Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Evaluation of a property extraction i of the form super.m
 * proceeds as follows:
 * ...
 * Otherwise, i is a getter invocation. Let f be the result of looking up
 * getter m in Sdynamic with respect to L. The body of f is executed with this
 * bound to the current value of this. The value of i is the result returned
 * by the call to the getter function.
 * @description Check that the value of i is the result returned by the
 * call to the getter function.
 * @author sgrekhov@unipro.ru
 */
import '../../../../Utils/expect.dart';

class A {
  int get m => 1;
}

class C extends A {
  int get m => 2;

  void test() {
    var i = super.m;
    Expect.equals(1, i);
  }
}

main() {
  C c = new C();
  c.test();
}
