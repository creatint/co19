/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Additive expressions invoke the addition operators on objects.
 * additiveExpression:
 *   multiplicativeExpression (additiveOperator multiplicativeExpression)* |
 *   super (additiveOperator multiplicativeExpression)+
 * ;
 * additiveOperator:
 *   '+' |
 *   '-'
 * ;
 * An additive expression is either a multiplicative expression, or an
 * invocation of an additive operator on either super or an expression e1, with
 * argument e2.
 * @description Checks that an additive expression of the form
 * super ('-' multiplicativeExpression)+
 * must have at least two operands.
 * @compile-error
 * @author msyabro
 * @reviewer kaigorodov
 */

class S {
  operator-() {}
}

class A {
  test() {
    try {
      super -;
    } catch(var e) {}
  }
}

main() {
  A a = new A();
  a.test();
}