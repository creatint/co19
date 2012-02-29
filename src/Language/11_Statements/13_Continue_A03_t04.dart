/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Let sc be a continue statement. If sc is of the form continue L;, 
 * then let sE be the the innermost labeled statement or case clause with label L 
 * enclosing sc. If sc is of the form continue; then let sE be the innermost do (11.7),
 * for (11.5) or while (11.6) statement enclosing sc.
 * Furthermore, let s1,...,sn be those try statements that are both
 * enclosed in sE and that enclose sc, and that have a finally clause. Lastly, let
 * fj be the finally clause of sj, 1 <= j <= n. Executing sc first executes f1,...,fn
 * in innermost-clause-first order and then transfers control to sE.
 * @description Checks that the execution of "continue;" statement transfers
 * control to the innermost enclosing loop statement and that all finally 
 * clauses between them are executed in the innermost-clause-first order.
 * @author rodionov
 * @reviewer iefremov
 */

main() {
  List order = new List();

  L:
  do {
    M:
    for(int i in [1,2]) {
      try {
        try {
          continue;
          Expect.fail("This code shouldn't be executed");
        } catch (var ok) {
          Expect.fail("This code shouldn't be executed");
        } finally {
          order.add(3);
        }
        Expect.fail("This code shouldn't be executed");
      } finally {
        order.add(2);
      }
      Expect.fail("This code shouldn't be executed");
    }
    order.add(1);
  } while(false);
  
  Expect.listEquals([3, 2, 3, 2, 1], order);
}