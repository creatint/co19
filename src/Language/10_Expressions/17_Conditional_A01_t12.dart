/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A conditional expression evaluates one of two expressions
 * based on a boolean condition.
 * conditionalExpression:
 *   logicalOrExpression ('?' expression ':' expression)?
 * ;
 * @description Checks that a reference to an interface declaration
 * can't be used as the condition in a conditional expression.
 * @compile-error
 * @author msyabro
 * @reviewer kaigorodov
 */

interface I {}

main() {
  try {
    I ? 1 : 2;
  } catch(var e) {}
}