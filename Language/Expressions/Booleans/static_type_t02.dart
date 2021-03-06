/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The static type of a boolean literal is bool.
 * @description Checks that a static warning is produced when assigning a
 * boolean literal to a typed int variable.
 * @static-warning
 * @author msyabro
 * @reviewer rodionov
 */
import '../../../Utils/dynamic_check.dart';

main() {
  checkTypeError(() {
    int i = true; /// static type warning
  });
}
