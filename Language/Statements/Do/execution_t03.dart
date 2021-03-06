/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Execution of a do statement of the form do s while (e); proceeds
 * as follows:
 *   The statement {s} is executed. Then, the expression e is evaluated to an
 * object o. Then, o is then subjected to boolean conversion, producing an
 * object r. If r is false, execution of the do statement is complete. If r is
 * true, then the do statement is re-executed recursively.
 * @description Checks that boolean conversion is done in checked mode.
 * @static-warning
 * @author vasya
 * @reviewer rodionov
 * @reviewer iefremov
 */

import '../../../Utils/expect.dart';
import '../../../Utils/dynamic_check.dart';

main() {
  int x = 0;
  checkTypeError( () {
    do {
      x = 1;
    } while (1); /// static type warning
  });
  Expect.equals(1, x);
  checkTypeError( () {
    do {
      x = 2;
    } while ("true"); /// static type warning
  });
  Expect.equals(2, x);
}
