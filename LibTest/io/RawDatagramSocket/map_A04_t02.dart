/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Stream<S> map<S>(S convert(T event))
 * Creates a new stream that converts each element of this stream to a new value
 * using the convert function.
 * . . .
 * The convert function is called once per data event per listener. If a
 * broadcast stream is listened to more than once, each subscription will
 * individually call convert on each data event.
 *
 * @description Checks that if a broadcast stream is listened to more than once,
 * each subscription will individually call convert on each data event.
 * @author ngl@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

main() {
  asyncStart();
  var address = InternetAddress.LOOPBACK_IP_V4;
  RawDatagramSocket.bind(address, 0).then((producer) {
    RawDatagramSocket.bind(address, 0).then((receiver) {
      int sent = 0;
      int counter1 = 0;
      int counter2 = 0;
      int cCounter = 0;
      List list1 = [];
      List list2 = [];
      List expected = [1, 2, 2, 3];
      int convert(e) {
        cCounter++;
        return (e == RawSocketEvent.WRITE
            ? 1
            : (e == RawSocketEvent.READ
                ? 2
                : (e == RawSocketEvent.CLOSED ? 3 : 0)));
      }

      producer.send([sent++], address, receiver.port);
      producer.send([sent++], address, receiver.port);
      producer.send([sent++], address, receiver.port);
      producer.close();

      new Timer(const Duration(milliseconds: 200), () {
        Expect.isNull(receiver.receive());
        receiver.close();
      });

      Stream bcs = receiver.asBroadcastStream();
      Stream stream = bcs.map(convert);
      stream.listen((event) {
        list1.add(event);
        receiver.receive();
        counter1++;
      });

      stream.listen((event) {
        list2.add(event);
        counter2++;
      }, onDone: () {
        Expect.equals(8, counter1 + counter2);
        Expect.equals(8, cCounter);
        Expect.listEquals(expected, list1);
        Expect.listEquals(expected, list2);
        asyncEnd();
      });
    });
  });
}