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
      builder: (context, ref, _) {
        return MaterialApp(
          title: 'Screenshot Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: ref.watch(primarySwatchProvider),
            brightness: ref.watch(brightnessProvider),
          ),
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              builder: (context, ref, _) {
                return Text(
                  '${ref.watch(counterProvider)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
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
      body: Consumer(
        builder: (context, ref, _) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: ref.watch(brightnessProvider.notifier).state ==
                    Brightness.dark,
                onChanged: (value) {
                  if (value) {
                    ref.read(brightnessProvider.notifier).state =
                        Brightness.dark;
                  } else {
                    ref.read(brightnessProvider.notifier).state =
                        Brightness.light;
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Theme Color'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildColor(ref, Colors.blue),
                    _buildColor(ref, Colors.red),
                    _buildColor(ref, Colors.green),
                    _buildColor(ref, Colors.yellow),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildColor(WidgetRef ref, MaterialColor color) {
    return Consumer(
      builder: (context, watch, _) {
        return InkWell(
          child: Container(
            width: 50,
            height: 36,
            color: color,
            child: Offstage(
              offstage: ref.watch(primarySwatchProvider) != color,
              child: Icon(
                Icons.check,
                color: color.computeLuminance() > 0.56
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          onTap: () => ref.read(primarySwatchProvider.notifier).state = color,
        );
      },
    );
  }
}
