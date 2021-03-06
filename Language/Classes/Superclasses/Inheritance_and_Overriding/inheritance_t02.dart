/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Let C be a class, let A be a superclass of C, and let S1...Sk
 * be superclasses of C that are also subclasses of A. C inherits all
 * accessible instance members of A that have not been overridden by a
 * declaration in C or in at least one of S1...Sk.
 * A class may override instance members that would otherwise have been
 * inherited from its superclass.
 * @description Checks that it is a warning and not a compile error if you
 * have a static member named m in superclass and an instance member of the
 * same name.
 * @static-warning
 * @author msyabro
 * @reviewer iefremov
 */

class S {
  static var v;
  static int i;
  static method() {}
  static int iMethod() {}
}

class C extends S {
  v() {} /// static type warning
  i() {} /// static type warning
  method() {} /// static type warning
  iMethod() {} /// static type warning
}

main() {
  var c = new C();
  c.v();
  c.i();
  c.method();
  c.iMethod();
}
