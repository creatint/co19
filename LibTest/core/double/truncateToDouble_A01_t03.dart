/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  abstract double truncateToDouble()
 * Returns the integer obtained by discarding any fractional digits from this.
 * @description Checks truncation of NaN.
 * @author pagolubev
 * @reviewer msyabro
 */
import "../../../Utils/expect.dart";

main() {
  double nan = 0 / 0;
  Expect.isTrue(nan.truncateToDouble().isNaN);
  Expect.isTrue((-nan).truncateToDouble().isNaN);
}
