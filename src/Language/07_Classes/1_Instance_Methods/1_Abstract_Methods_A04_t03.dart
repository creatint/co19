/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Unless explicitly stated otherwise, all ordinary rules that apply to methods
 * apply to abstract methods.
 * 7.1: It is a compile-time error if an instance method m1 overrides an instance
 * member m2 and m1 does not declare all the named parameters declared by m2 in the same order.
 * @description Checks that a compile-time error is not produced when the overriding non-abstract
 * instance method has more named parameters than the abstract method being overridden (2 vs 1)
 * and both have the same number of required parameters of the same type.
 * @author rodionov
 * @reviewer iefremov
 */

class A {
  abstract f(var r, [var x]);
}

class C extends A {
  f(var r, [var x, var y]) {}
}

main() {
  try {
    new C().f(1, 1, 2);
  } catch(var x) {}

  try {
    new A().f(1, 1);
  } catch(var x) {}
}