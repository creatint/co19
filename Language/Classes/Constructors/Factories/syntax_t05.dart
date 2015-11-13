/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A factory is a constructor prefaced by the built-in identifier
 * factory.
 * factoryConstructorSignature:
 *   factory identifier ('.' identifier)? formalParameterList
 * ;
 * @description Checks that it is a compile-time error if a factory constructor
 * is constant.
 * @compile-error
 * @author msyabro
 * @reviewer iefremov
 */

class C {
  const factory C();
}

main() {
  try {
    new C();
  } catch (x) {}
}