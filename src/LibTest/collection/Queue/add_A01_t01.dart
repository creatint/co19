/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Adds [value] at the end of the queue.
 * @description Checks that [value] is added to the end of the queue
 * and length is extended by one.
 * @author msyabro
 * @reviewer varlax
 */
import "dart:collection";

main() {
  Queue queue = new Queue();
  for (var i = 0; i <= 10000; i++) {
    queue.add(i);
    Expect.equals(i, queue.last);
    Expect.equals(i+1, queue.length);
  }
}