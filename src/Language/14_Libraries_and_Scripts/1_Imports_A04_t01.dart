/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion It is a compile-time error if the speciﬁed URI does not refer to
 * a library declaration.
 * @description Checks that it is a compile-time error if the URI in an import directive is an empty string.
 * @compile-error
 * @author vasya
 * @reviewer hlodvig
 * @reviewer msyabro
 * @reviewer rodionov
 */

import "";

main() {
  try {
    var someVar = 0;
  } catch(e) {}
}