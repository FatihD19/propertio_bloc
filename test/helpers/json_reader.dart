import 'dart:io';

String readJson(String fileName) {
  String path =
      '${Directory.current.path}/test/helpers/dummy_data/json/$fileName';
  return File(path).readAsStringSync();
}
