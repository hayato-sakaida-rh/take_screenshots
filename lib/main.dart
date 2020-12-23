import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
final primarySwatchProvider = StateProvider((_) => Colors.blue);
final brightnessProvider = StateProvider((_) => Brightness.light);
final counterProvider = StateProvider((_) => 0);

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return MaterialApp(
          title: 'Screenshot Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: watch(primarySwatchProvider).state,
            brightness: watch(brightnessProvider).state,
          ),
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screenshot Demo Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SettingsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer(
              builder: (context, watch, _) {
                return Text(
                  '${watch(counterProvider).state}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read(counterProvider).state++,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Consumer(
            builder: (context, watch, _) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: watch(brightnessProvider).state == Brightness.dark,
                onChanged: (value) {
                  if (value) {
                    context.read(brightnessProvider).state = Brightness.dark;
                  } else {
                    context.read(brightnessProvider).state = Brightness.light;
                  }
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Theme Color'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildColor(Colors.blue),
                _buildColor(Colors.red),
                _buildColor(Colors.green),
                _buildColor(Colors.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColor(MaterialColor color) {
    return Consumer(
      builder: (context, watch, _) {
        return InkWell(
          child: Container(
            width: 50,
            height: 36,
            color: color,
            child: Offstage(
              offstage: watch(primarySwatchProvider).state != color,
              child: Icon(
                Icons.check,
                color: color.computeLuminance() > 0.56
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          onTap: () => context.read(primarySwatchProvider).state = color,
        );
      },
    );
  }
}
