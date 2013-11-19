/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion abstract Future addStream(Stream<T> source,
 *                                      {bool cancelOnError: true})
 * If cancelOnError is true, only the first error on source is forwarded to 
 * the controller's stream, and the addStream ends after this.
 * If cancelOnError is false, all errors are forwarded and only a done event
 * will end the addStream.
 * @description Checks that if cancelOnError is true, addStream ends after the
 * first error. Also checks that default value of cancelOnError is true.
 * @author ilya
 */

import "dart:async";
import "../../../Utils/async_utils.dart";
import "../../../Utils/expect.dart";

listen(stream, expectedData, expectedErrors) {
  var actualData = [];
  var actualErrors = [];

  asyncStart();
  stream.listen(
      (x) {
        actualData.add(x);
      },
      onError: (x) {
        actualErrors.add(x);
      },
      onDone: () {
        Expect.listEquals(expectedData, actualData);
        Expect.listEquals(expectedErrors, actualErrors);
        asyncEnd();
      });
}

// new stream, negative data become errors
toDataErrorStream(stream) => stream.map((x) => x < 0 ? throw x : x);

main() {
  var c = new StreamController();
  var iter = [1,2,3,-1,-2,-3,4,5,6];
  var s1 = toDataErrorStream(new Stream.fromIterable(iter));
  var s2 = toDataErrorStream(new Stream.fromIterable(iter));

  listen(c.stream, [1,2,3,1,2,3], [-1,-1]);

  asyncStart();
  c.addStream(s1).then((_) {
    c.addStream(s2, cancelOnError:true).then((_) {
      c.close();
      asyncEnd();
    });
  });
}
