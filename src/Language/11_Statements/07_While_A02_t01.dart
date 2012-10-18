/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Execution of a while statement of the form while (e) s; proceeds as follows:
 * The expression e is evaluated to an object o. In checked mode, it is a dynamic
 * type error if o is not of type bool. Otherwise, o is then subjected to boolean
 * conversion (10.4.1), producing an object r. If r is true, then s is executed and
 * then the while statement is re-executed recursively. If r is false, execution of
 * the while statement is complete. 
 * @description Checks that the number of iterations is correct for various valid expressions.
 * @author vasya
 * @reviewer rodionov
 * @reviewer iefremov
 */

main() {
  var count = 0;
  while (false) {
    ++count;
  }
  Expect.equals(0, count);

  count = 0;
  while (true) {
    ++count;
    if (count == 7)
      break;
  }
  Expect.equals(7, count);
  
  count = 0;
  while (count < 2) {
    ++count;
  }
  Expect.equals(2, count);
  
  count = 0;
  var it = [0,1].iterator();
  while (it.hasNext()) {
    it.next();
    ++count;
  }
  Expect.equals(2, count);
  
  count = 0;
  while (++count < 3) {  }
  Expect.equals(3, count);
}