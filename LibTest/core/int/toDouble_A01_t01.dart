/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion double toDouble()
 * Returns the double value represented by this object.
 * @description Checks that this method returns correct value (rounded to the nearest finite double
 * for very large integers).
 * @author vasya
 * @reviewer msyabro
 */
import "../../../Utils/expect.dart";

import "dart:math" as Math;

main() {
  final double MIN_DOUBLE = Math.pow(2.0, -1074);
  final double NEG_MIN_DOUBLE = -1 * MIN_DOUBLE; 
  final double MAX_DOUBLE = (2 - Math.pow(2.0, -52)) * Math.pow(2.0, 1023);
  final double NEG_MAX_DOUBLE = -1 * MAX_DOUBLE; 

  check(0, 0.0);
  check(2147483647, 2147483647.0);
  check(-2147483648, -2147483648.0);
  check(4294967295, 4294967295.0);
  check(-4294967296, -4294967296.0);
  check(9223372036854775807, 9223372036854775807.0);
  check(-9223372036854775808, -9223372036854775808.0);
  check(-18446744073709551617, -18446744073709551617.0);
  check(1 << 1024, double.INFINITY);
  check(1 << 1124, double.INFINITY);
  check(-(1 << 1024), double.NEGATIVE_INFINITY);
  check(-(1 << 1124), double.NEGATIVE_INFINITY);
  check(179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368, MAX_DOUBLE);
  check(-179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368, NEG_MAX_DOUBLE);
}

void check(int x, double ex) {
  double d = x.toDouble();
  Expect.isTrue(d is double);
  Expect.equals(ex, d);
}
