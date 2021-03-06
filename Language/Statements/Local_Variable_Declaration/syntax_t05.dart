/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A variable declaration statement declares a new local variable.
 *   localVariableDeclaration:
 *     initializedVariableDeclaration ’;’
 *   ;
 * @description Checks that the variable 'int id;' declared in a block is not
 * available in a scope that encloses this block.
 * @static-warning
 * @author rodionov
 * @reviewer iefremov
 */
import '../../../Utils/expect.dart';

main() {
  try {
    {
      int id;
    }
    id = null; /// static type warning
    Expect.fail("NoSuchMethodError expected when calling undefined setter.");
  } on NoSuchMethodError catch (ex) {}
}
