// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:api_doc_updater/api_doc_updater_cli.dart';

/// See [ApiDocUpdaterCLI].
Future<Null> main(List<String> args) async {
  final updater = new ApiDocUpdaterCLI();
  updater.setArgs(args);
  if (!updater.argsAreValid) return;
  await updater.processArgs();
  if (exitCode == 0) {
    final msg = 'Processed ${updater.numFiles} Dart files: '
        '${updater.numUpdatedFrag} out of '
        '${updater.numSrcDirectives} fragments needed updating.';
    print(msg);
  }
}
