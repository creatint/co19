/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Completer()
 * Create a completer
 * @description Checks that [Completer] creates an object of type Completer
 * which have all methods of Completer interface.
 * @author msyabro
 * @reviewer kaigorodov
 */

main() {
  Completer completer = new Completer();
  Expect.isTrue(completer is Completer);
}