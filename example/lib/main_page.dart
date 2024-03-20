import 'package:example/second_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Adaptive Will Pop Scope'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, SeconPage.route);
          },
          child: const Text('Navigate to Second Page'),
        ),
      ),
    );
  }
}
