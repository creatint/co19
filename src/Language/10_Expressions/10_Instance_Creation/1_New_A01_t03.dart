/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The new expression invokes a constructor.
 * newExpression:
 *   new type ('.' identifier)? arguments
 * ;
 * @description Checks that it is a compile-time error if
 * a new expression does not provide the type name.
 * @compile-error
 * @author msyabro
 */

class A {
  A() {}
}

main() {
  try {
    new ();
  } catch(var e) {}
}