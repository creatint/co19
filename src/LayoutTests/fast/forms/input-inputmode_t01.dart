/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description Tests the behavior of .inputMode of HTMLInputElement.
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var input = document.createElement('input');

  // .inputMode just reflect the corresponding attributes.
  input.type = 'text';
  shouldBe(input.inputMode, "");
  input.setAttribute('inputmode', '0');
  shouldBe(input.inputMode, "0");
  input.setAttribute('inputmode', 'abc');
  shouldBe(input.inputMode, "abc");

  input.inputMode = 'foo';
  shouldBe(input.getAttribute("inputmode"), "foo");

  input.inputMode = '';
  shouldBe(input.getAttribute("inputmode"), "");

  /*
  // Null.
  debug('Setting null to inputMode:');
  input.inputMode = null;
  shouldBe(input.inputMode, "null");
  shouldBe(input.getAttribute("inputmode"), "null");
  input.setAttribute('inputmode', null);
  shouldBe(input.inputMode, "null");

  // Undefined.
  debug('Setting undefined to inputMode:');
  input.inputMode = undefined;
  shouldBe(input.inputMode, "undefined");
  shouldBe(input.getAttribute("inputmode"), "undefined");
  input.setAttribute('inputmode', undefined);
  shouldBe(input.inputMode, "undefined");

  // Non-string.
  debug('Setting non-string to inputMode:');
  input.inputMode = 256;
  shouldBe(input.inputMode, "256");
  shouldBe(input.getAttribute("inputmode"), "256");
  input.setAttribute('inputmode', 256);
  shouldBe(input.inputMode, "256");
  */
}
