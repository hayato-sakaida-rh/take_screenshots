import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart';

Future<void> takeScreenshot(FlutterDriver driver, String path) async {
  print('will take screenshot $path');
  await driver.waitUntilNoTransientCallbacks();
  final pixels = await driver.screenshot();
  final dir = Directory('.screenshots');
  if (!dir.existsSync()) {
    dir.createSync();
  }
  final file = File(join(dir.path, path));
  await file.writeAsBytes(pixels);
  print('wrote $file');
}
