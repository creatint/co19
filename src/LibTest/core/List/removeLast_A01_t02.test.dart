/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion abstract E removeLast()
 * Pops and returns the last element of the list.
 * @description Checks that exception is thrown as expected.
 * @author vasya
 * @reviewer msyabro
 * @reviewer varlax
 */
import "../../../Utils/expect.dart";

check(a) {
  try {
    a.removeLast();
    Expect.fail("RangeError expected when calling a.removeLast()");
  } on RangeError catch(ok) {}
}

main() {
  check(new List());
  check([]);
  check(new List.from([]));
}
