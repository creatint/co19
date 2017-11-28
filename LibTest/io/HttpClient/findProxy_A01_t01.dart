/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void findProxy=(
 *  String f(
 *  Uri url
 *  )
 *  )
 * Sets the function used to resolve the proxy server to be used for opening a
 * HTTP connection to the specified url. If this function is not set, direct
 * connections will always be used.
 *
 * The string returned by f must be in the format used by browser PAC (proxy
 * auto-config) scripts. That is either
 *
 * "DIRECT"
 * for using a direct connection or
 *
 * "PROXY host:port"
 * for using the proxy server host on port port.
 *
 * A configuration can contain several configuration elements separated by
 * semicolons, e.g.
 *
 * "PROXY host:port; PROXY host2:port2; DIRECT"
 * The static function findProxyFromEnvironment on this class can be used to
 * implement proxy server resolving based on environment variables.
 * @description Checks that this setter sets the function used to resolve the
 * proxy server to be used for opening a HTTP connection to the specified url.
 * Test "DIRECT" connection and Basic authentication
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import 'dart:async';
import "dart:convert";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

test() async {
  bool authenticateProxyCalled = false;
  int requestCounter = 0;

  HttpServer server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 0);
  server.listen((HttpRequest request) {
    Expect.isNull(request.headers[HttpHeaders.PROXY_AUTHORIZATION]);
    if (requestCounter++ == 0) {
      request.response.statusCode = HttpStatus.UNAUTHORIZED;
      request.response.headers
          .set(HttpHeaders.PROXY_AUTHENTICATE, 'Basic, realm=realm');
      request.response.statusCode = HttpStatus.PROXY_AUTHENTICATION_REQUIRED;
      request.response.close();
    } else  {
      Expect.isTrue(authenticateProxyCalled);
      request.response.close();
      server.close();
      asyncEnd();
    }
  });
  HttpClient client = new HttpClient();
  client.findProxy = (Uri uri) {
    authenticateProxyCalled = true;
    return "DIRECT";
  };

  client.authenticateProxy =
      (String host, int port, String scheme, String realm) {
    Completer completer = new Completer();
    completer.complete(true);
    return completer.future;
  };

  client
      .getUrl(Uri.parse(
          "http://${InternetAddress.LOOPBACK_IP_V4.address}:${server.port}"))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) {
    response.transform(UTF8.decoder).listen((content) {});
  });
}

main() {
  asyncStart();
  test();
}
