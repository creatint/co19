/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description This test checks fieldset.test attribute
 */
import "dart:html";
import "../../../testcommon.dart";
import "../../../../Utils/async_utils.dart";

main() {
  document.body.setInnerHtml('''
      <fieldset id="fs1" name="a"></fieldset>
      ''', treeSanitizer: new NullTreeSanitizer());

  var fs1 = document.getElementById('fs1');
  shouldBe(fs1.type, "fieldset");
}

