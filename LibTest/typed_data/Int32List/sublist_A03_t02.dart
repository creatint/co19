/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion List<int> sublist(int start, [int end])
 * It is an error if [start] or [end] are not indices into [this],
 * or if [end] is before [start].
 * @description Checks that it is an error if [start] or [end]
 * are not indices into [this].
 * @author msyabro
 */

import "dart:typed_data";
import "../../../Utils/expect.dart";

check(list, start, end) {
  var l = new Int32List.fromList(list);

  Expect.throws( () {
    l.sublist(start, end);
  });
}

main() {
  check([],0, 1);
  check([0, 0, 0],-1, 1);
  check([0, 0, 0],-1, 2);
  check([0, 0, 0], 0, 4);
  check([0,0 , 0], 2, 100);
  check([0, 0, 0],-10, 10);
}
