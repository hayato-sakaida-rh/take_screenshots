import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:take_screenshots/main.dart';

enum Screen {
  home,
  settings,
}

final screenProvider = StateProvider((_) => Screen.home);

void main() {
  final providerContainer = ProviderContainer(
    overrides: [
      screenProvider.overrideWith(
        (ref) => Screen.home,
      ),
      primarySwatchProvider.overrideWith(
        (ref) => Colors.blue,
      ),
      brightnessProvider.overrideWith(
        (ref) => Brightness.light,
      ),
      counterProvider.overrideWith(
        (ref) => 0,
      ),
    ],
  );

  enableFlutterDriverExtension(
    handler: (action) async {
      switch (action) {
        case 'screen::home':
          providerContainer.updateOverrides([
            screenProvider.overrideWith((ref) => Screen.home),
          ]);
          break;
        case 'screen::settings':
          providerContainer.updateOverrides([
            screenProvider.overrideWith((ref) => Screen.settings),
          ]);
          break;
        case 'primarySwatch::blue':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWith((ref) => Colors.blue),
          ]);
          break;
        case 'primarySwatch::red':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWith((ref) => Colors.red),
          ]);
          break;
        case 'primarySwatch::green':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWith((ref) => Colors.green),
          ]);
          break;
        case 'primarySwatch::yellow':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWith((ref) => Colors.yellow),
          ]);
          break;
        case 'brightness::light':
          providerContainer.updateOverrides([
            brightnessProvider.overrideWith((ref) => Brightness.light),
          ]);
          break;
        case 'brightness::dark':
          providerContainer.updateOverrides([
            brightnessProvider.overrideWith((ref) => Brightness.dark),
          ]);
          break;
        case 'counter::small':
          providerContainer.updateOverrides([
            counterProvider.overrideWith((ref) => 10),
          ]);
          break;
        case 'counter::large':
          providerContainer.updateOverrides([
            counterProvider.overrideWith((ref) => 99999999),
          ]);
          break;
        default:
          break;
      }
      return '';
    },
  );

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: Consumer(
        builder: (context, ref, _) {
          Widget screen;
          switch (ref.watch(screenProvider.notifier).state) {
            case Screen.settings:
              screen = SettingsScreen();
              break;
            default:
              screen = MyHomePage();
              break;
          }
          return MaterialApp(
            title: 'Screenshot Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: ref.watch(primarySwatchProvider.notifier).state,
              brightness: ref.watch(brightnessProvider.notifier).state,
            ),
            home: screen,
          );
        },
      ),
    ),
  );
}
