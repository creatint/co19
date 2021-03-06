/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @description This tests XmlSerializer.serializeToString() on a newly created
 * DocumentType node does not throw since the node has an associated document.
 */
import "dart:html";
import "../../testcommon.dart";

main() {
  var docType = window.document.implementation
    .createDocumentType("aDocTypeName", "aPublicID", "aSystemID");
  var serializer = new XmlSerializer();

  var text;
  shouldNotThrow(() => text = serializer.serializeToString(docType));
  shouldBeEqualToString(text, 
      "<!DOCTYPE aDocTypeName PUBLIC \"aPublicID\" \"aSystemID\">");
}
