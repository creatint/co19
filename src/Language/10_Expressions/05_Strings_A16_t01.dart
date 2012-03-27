/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion All string literals implement the built-in interface String.
 * @description Checks that string literals implement interface String.
 * @author msyabro
 * @reviewer kaigorodov
 */

main() {
  Expect.isTrue("" is String);
  Expect.isTrue('' is String);
  Expect.isTrue(@"" is String);
  Expect.isTrue(@'' is String);
  Expect.isTrue("""""" is String);
  Expect.isTrue('''''' is String);
  Expect.isTrue(@"""""" is String);
  Expect.isTrue(@'''''' is String);

  Expect.isTrue("String" is String);
  Expect.isTrue('\x00\x01\x02' is String);
  Expect.isTrue(@"\\\\\\\\" is String);
  Expect.isTrue(@'$$$$$' is String);
  Expect.isTrue("""
                new line """ is String);
}