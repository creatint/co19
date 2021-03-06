/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Iterable<E> skip(int n)
 * Returns an Iterable that skips the first n elements.
 * If this has fewer than n elements, then the resulting Iterable is empty.
 * It is an error if n is negative.
 * @description checks that a RangeError is thrown if n is negative.
 * @author kaigorodov
 */
import "dart:collection";
import "../../../Utils/expect.dart";
import "LinkedList.lib.dart";

check(List a0, int n) {
  LinkedList<MyLinkedListEntry> a=toLinkedList(a0);
  Iterable res;
  Expect.throws(() {
      res=a.skip(n);
    },
    (e) => e is RangeError
  );
}

main() {
  check([1,2,-3,4], -1);
  check(const[1,2,-5,-6, 100], -1);
  check(const[null,2,-5,-6, 100], -1000);
}