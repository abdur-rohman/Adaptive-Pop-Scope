import 'package:adaptive_pop_scope/adaptive_pop_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeconPage extends StatefulWidget {
  const SeconPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => const SeconPage(),
      );

  @override
  State<SeconPage> createState() => _SeconPageState();
}

class _SeconPageState extends State<SeconPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AdaptivePopScope(
      onWillPop: () async => await _showAlertDialog(context) ?? false,
      swipeWidth: screenWidth,
      swipeThreshold: screenWidth / 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }

  Future<bool?> _showAlertDialog(BuildContext context) =>
      showCupertinoModalPopup<bool>(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Are you sure'),
          content: const Text('you want to navigate away from this page?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );
}
