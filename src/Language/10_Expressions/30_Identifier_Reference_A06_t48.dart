/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion It is a compile-time error if a built-in identifier is
 * used as the declared name of a class, type parameter or type alias.
 * @description Checks that it is a compile-time error when a built-in identifier
 * set is used as the declared name of a type alias.
 * @compile-error
 * @author rodionov
 * @reviewer iefremov
 */

typedef int set();

main() {
  try {
    null is set;
  } catch (anything) {
  }
}