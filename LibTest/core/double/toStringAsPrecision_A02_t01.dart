import "../../../Utils/expect.dart";
/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
 /**
 * @assertion String toStringAsPrecision(int precision)
 * Throws [Error] if [fractionDigits] is null.
 * @description Checks that the correct exception is thrown.
 * @author msyabro
 * @needsreview undocumented
 */

main() {
  bool fail = false;
  try {
    .1.toStringAsPrecision(null);
    Expect.fail('Error is expected');
  } on Error catch(e) {}
}
