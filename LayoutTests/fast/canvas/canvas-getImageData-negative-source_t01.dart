/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Test the handling of negative sourceRect offset in
 * getImageData().
 */
import "dart:html";
import "dart:math" as Math;
import "../../testcommon.dart";
import "../../../Utils/async_utils.dart";

main() {
  var ctx = createContext2d("canvas");

  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 100, 100);
  ctx.fillStyle = 'green';
  ctx.fillRect(0, 0, 6, 6);

  var imageData = ctx.getImageData(-10, 0, 100, 1);
  var imgdata = imageData.data;

  // Fully transparent black
  shouldBe(imgdata[0], 0);
  shouldBe(imgdata[1], 0);
  shouldBe(imgdata[2], 0);
  shouldBe(imgdata[3], 0);

  // Green
  shouldBe(imgdata[60], 0);
  shouldBe(imgdata[61], 128);
  shouldBe(imgdata[62], 0);
  shouldBe(imgdata[63], 255);

  // Red
  shouldBe(imgdata[64], 255);
  shouldBe(imgdata[65], 0);
  shouldBe(imgdata[66], 0);
  shouldBe(imgdata[67], 255);
}
