/*
 * Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion It is a compile-time error for any type other than the types
 * int and double to attempt to extend, mix in or implement num.
 * @description Checks that num cannot be mixed in abstract class
 * @compile-error
 * @author sgrekhov@unipro.ru
 */

class A {}

abstract class C extends A with num {}

main() {
  C c = null;
}