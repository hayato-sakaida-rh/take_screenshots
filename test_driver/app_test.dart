import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'screenshort.dart';

void main() {
  group('screenshots', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('home light', () async {
      await driver?.requestData('brightness::light');
      await takeScreenshot(driver!, 'home_light.png');
    });

    test('home dark', () async {
      await driver?.requestData('brightness::dark');
      await takeScreenshot(driver!, 'home_dark.png');
    });

    test('home light red"', () async {
      await driver?.requestData('brightness::light');
      await driver?.requestData('primarySwatch::red');
      await takeScreenshot(driver!, 'home_light_red.png');
    });

    test('home light yellow"', () async {
      await driver?.requestData('lbrightness::ight');
      await driver?.requestData('primarySwatch::yellow');
      await takeScreenshot(driver!, 'home_light_yellow.png');
    });

    test('home light small counter"', () async {
      await driver?.requestData('brightness::light');
      await driver?.requestData('counter::small');
      await takeScreenshot(driver!, 'home_light_small_counter.png');
    });

    test('home dark large counter', () async {
      await driver?.requestData('brightness::dark');
      await driver?.requestData('counter::large');
      await takeScreenshot(driver!, 'home_dark_large_counter.png');
    });

    test('settings light', () async {
      await driver?.requestData('brightness::light');
      await driver?.requestData('screen::settings');
      await takeScreenshot(driver!, 'settings_light.png');
    });

    test('settings dark', () async {
      await driver?.requestData('brightness::dark');
      await driver?.requestData('screen::settings');
      await takeScreenshot(driver!, 'settings_dark.png');
    });
  });
}
