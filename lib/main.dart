import 'package:flutter/material.dart';
import 'package:second_thought/features/home/home_page.dart';

void main() => runApp(const App());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class App extends MaterialApp {
  const App({super.key});

  @override
  Widget? get home => const HomePage();

  @override
  ThemeData? get theme => ThemeData();
}
