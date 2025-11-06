import 'package:adaptive_pop_scope/adaptive_pop_scope.dart';

import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => const ThirdPage(),
      );

  @override
  State<ThirdPage> createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) => AdaptivePopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Third Page'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: const Center(child: Text('Hello World')),
        ),
      );
}
