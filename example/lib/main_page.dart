import 'package:example/fourth_page.dart';
import 'package:example/second_page.dart';
import 'package:example/third_page.dart';
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
      body: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, SecondPage.route);
              },
              child: const Text('Navigate to Second Page'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, ThirdPage.route);
              },
              child: const Text('Navigate to Third Page'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, FourthPage.route).then((result) {
                  if (result != null && result is String && context.mounted) {
                    final name = result;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Hello, $name!')),
                    );
                  }
                });
              },
              child: const Text('Navigate to Fourth Page'),
            ),
          ),
        ],
      ),
    );
  }
}
