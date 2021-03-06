/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Tests that we find controls if they have a range limitation and
 * are out-of-range.
 */
import "dart:html";
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";
import "pwd.dart";

main() {
  var parentDiv = document.createElement('div');
  document.body.append(parentDiv);
  parentDiv.innerHtml = '<input id="number1" type="number" min=0 max=10 value=50><input id="text1" type="text" min=0 max=10 value=50><input id="checkbox1" type="checkbox"><input id="radio1" type="radio">';

  shouldBe(document.querySelector("input[type=number]:out-of-range").id, "number1");
  shouldBe(document.querySelectorAll(":out-of-range").length, 1);

  debug("");
  debug("When the value becomes in-range dynamically, we do not find the control anymore");
  (document.getElementById("number1") as InputElement).value = '5';

  shouldBe(document.querySelector("input[type=number]:out-of-range"), null);
  shouldBe(document.querySelectorAll(":out-of-range").length, 0);
}
