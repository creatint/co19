/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion MutableRectangle<T> boundingBox(MutableRectangle<T> other)
 * Returns a new rectangle which completely contains this and other.
 * @description checks that this operation is symmetric.
 * @author kaigorodov
 */
import "dart:math";
import "../../../Utils/expect.dart";

const List<num> values = const [
   0, -1, 1, 10, -10, 100, -100,
   -4.5035996273704955E15, -4.294967296000001E9, -4.294967296E9, -4.2949672959999995E9, -6031769.5,
   -101.0, -100.00000000000001, -100.0, -99.99999999999999, -99.0, -10.0, -1.0000000000000002, -1.0,
   -.9999999999999999, -.7, .9999999999999999, 1.0, 1.0000000000000002, 10.0, 99.0, 99.99999999999999,
   100.0, 100.00000000000001, 101.0, 6031769.5, 4.2949672959999995E9, 4.294967296E9, 4.294967296000001E9,
   4.5035996273704955E15, 4.503599627370496E15, 4.503599627370497E15, 3.273390607896142,
 ];
  
Random rand = new Random(817);

num randomVal() {
  int k = rand.nextInt(values.length);
  return values[k];
}

main() {
  for(int i = 0; i < 1000; i++) {
    num x = randomVal();
    num y = randomVal();
    num z = randomVal();
    num w = randomVal();
    
    MutableRectangle r1=new MutableRectangle(x, y, max(z, 0), max(w, 0));
    MutableRectangle r2=new MutableRectangle(z, w, max(x, 0), max(y, 0));
    Rectangle bb1=r1.boundingBox(r2);
    Rectangle bb2=r2.boundingBox(r1);
    Expect.equals(bb1, bb2, "i=$i; x=$x, y=$y, z=$z, w=$w, bb1=$bb1, bb2=$bb2");
  }
}