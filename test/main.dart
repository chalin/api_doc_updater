// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:api_doc_updater/api_doc_updater.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

const _testDir = 'test_data';

// TODO: enhance tests so that we can inspect the generated error messages.
// It might be easier to modify the updater to use an IOSink than to try to read stderr.

void main() {
  final apiDocUpdater = new ApiDocUpdater(p.join(_testDir, 'frag'));

  String _readFile(String path) => new File(path).readAsStringSync();

  String _srcFileName2Path(String fileName) => p.join(_testDir, 'src', fileName);

  String getSrc(String relPath) => _readFile(_srcFileName2Path(relPath));
  String getExpected(String relPath) =>
      _readFile(p.join(_testDir, 'expected', relPath));

  group('No change to API doc;', () {
    final _testFileNames = [
      'no_src.dart',
      'no_comment_prefix.dart',
      'basic_no_region.dart',
      'basic_with_region.dart',
      'frag_not_found.dart',
      'invalid_code_block.dart'
    ];

    _testFileNames.forEach((testFileName) {
      test(testFileName, () {
        final testFileRelativePath = p.join('no_change', testFileName);
        final originalSrc = getSrc(testFileRelativePath);
        final updatedApiDocs = apiDocUpdater.generateUpdatedFile(_srcFileName2Path(testFileRelativePath));
        expect(updatedApiDocs, originalSrc);
      });
    });
  });

  group('Basic code updates;', () {
    final _testFileNames = [
      'no_comment_prefix.dart',
      'basic_no_region.dart',
      'basic_with_region.dart'
    ];

    _testFileNames.forEach((testFileName) {
      test(testFileName, () {
        final testFileRelativePath = testFileName;
        // var originalSrc = getSrc(testFileRelativePath);
        final updatedApiDocs = apiDocUpdater.generateUpdatedFile(_srcFileName2Path(testFileRelativePath));
        expect(updatedApiDocs, getExpected(testFileName));
      });
    });
  });
}
