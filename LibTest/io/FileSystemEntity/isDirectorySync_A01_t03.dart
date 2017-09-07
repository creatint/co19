/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool isDirectorySync(String path)
 * Synchronously checks if typeSync(path) returns
 * FileSystemEntityType.DIRECTORY.
 *
 * @description Checks that this property Synchronously checks if typeSync(path)
 * returns FileSystemEntityType.DIRECTORY. Test Directory
 * @issue 30410
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/file_utils.dart";

main() {
  Link link = getTempLinkSync();
  try {
    Expect.isFalse(FileSystemEntity.isDirectorySync(link.path));
    Expect.equals(
        FileSystemEntity.typeSync(link.path), FileSystemEntityType.LINK);
  } finally {
    deleteLinkWithTarget(link);
  }
}