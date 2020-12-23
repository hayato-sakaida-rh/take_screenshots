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
      screenProvider.overrideWithValue(
        StateController(Screen.home),
      ),
      primarySwatchProvider.overrideWithValue(
        StateController(Colors.blue),
      ),
      brightnessProvider.overrideWithValue(
        StateController(Brightness.light),
      ),
      counterProvider.overrideWithValue(
        StateController(0),
      ),
    ],
  );

  enableFlutterDriverExtension(
    handler: (action) async {
      switch (action) {
        case 'screen::home':
          providerContainer.updateOverrides([
            screenProvider.overrideWithValue(
              StateController(Screen.home),
            ),
          ]);
          break;
        case 'screen::settings':
          providerContainer.updateOverrides([
            screenProvider.overrideWithValue(
              StateController(Screen.settings),
            ),
          ]);
          break;
        case 'primarySwatch::blue':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWithValue(
              StateController(Colors.blue),
            ),
          ]);
          break;
        case 'primarySwatch::red':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWithValue(
              StateController(Colors.red),
            ),
          ]);
          break;
        case 'primarySwatch::green':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWithValue(
              StateController(Colors.green),
            ),
          ]);
          break;
        case 'primarySwatch::yellow':
          providerContainer.updateOverrides([
            primarySwatchProvider.overrideWithValue(
              StateController(Colors.yellow),
            ),
          ]);
          break;
        case 'brightness::light':
          providerContainer.updateOverrides([
            brightnessProvider.overrideWithValue(
              StateController(Brightness.light),
            ),
          ]);
          break;
        case 'brightness::dark':
          providerContainer.updateOverrides([
            brightnessProvider.overrideWithValue(
              StateController(Brightness.dark),
            ),
          ]);
          break;
        case 'counter::small':
          providerContainer.updateOverrides([
            counterProvider.overrideWithValue(
              StateController(10),
            ),
          ]);
          break;
        case 'counter::large':
          providerContainer.updateOverrides([
            counterProvider.overrideWithValue(
              StateController(99999999),
            ),
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
        builder: (context, watch, _) {
          Widget screen;
          switch (watch(screenProvider).state) {
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
              primarySwatch: watch(primarySwatchProvider).state,
              brightness: watch(brightnessProvider).state,
            ),
            home: screen,
          );
        },
      ),
    ),
  );
}
