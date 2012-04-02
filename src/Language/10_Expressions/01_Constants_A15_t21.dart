/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  All possible constant expressions are prescribed in assertions
 * 01_Constants_A01 - 01_Constants_A14. There are no other constant expressions.
 * @description Checks that a prefix increment expression cannot be used to initialize
 * a constant variable.
 * @author iefremov
 * @compile-error
 * @reviewer rodionov
 */

var a = 1;
const m = ++a;

main() {
  try {
    print(m);
  } catch(var x) {}
}
