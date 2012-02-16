/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion variableDeclaration: declaredIdentifier (',' identifier)* ;
 * initializedVariableDeclaration: declaredIdentifier ('=' expression)? (',' initializedIdentifier)* ;
 * initializedIdentifierList: initializedIdentifier (',' initializedIdentifier)* ;
 * initializedIdentifier: identifier ('=' expression)? ;
 * declaredIdentifier: finalVarOrType identifier ;
 * finalVarOrType: final type? | var | type ;
 * @description Checks that a statement cannot be used instead of expression in the initialized declaration.
 * @author iefremov
 * @compile-error
 */

main() {
  try {
    var x = return 0;
  }
  catch(var x) {}
}
