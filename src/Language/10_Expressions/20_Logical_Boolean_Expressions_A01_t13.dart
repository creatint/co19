/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The logical boolean expressions combine boolean objects using the boolean
 * conjunction and disjunction operators.
 * logicalOrExpression:
 *   logicalAndExpression ('||' logicalAndExpression)*
 * ;
 * logicalAndExpression:
 *   bitwiseOrExpression ('&&' bitwiseOrExpression)*
 * ;
 * A logical boolean expression is either a bitwise expression, or an
 * invocation of a logical boolean operator on an expression e1 with argument e2.
 * @description Checks that a reference to a type alias declaration can be used as
 * the second operand in a logical boolean expression.
 * @author msyabro
 * @reviewer kaigorodov
 */

typedef int fun();

main() {
  try {
    false && fun;
  } catch(e) {}
}