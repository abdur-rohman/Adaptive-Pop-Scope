import 'package:adaptive_pop_scope/couple.dart';
import 'package:adaptive_pop_scope/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => const SecondPage(),
      );

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AdaptivePopScope(
      onWillPop: () async {
        final shouldPop = await _showAlertDialog(context);
        return Couple(shouldPop ?? false, null);
      },
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

  Future<bool?> _showAlertDialog(BuildContext context) {
    return showCupertinoModalPopup<bool>(
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
}
