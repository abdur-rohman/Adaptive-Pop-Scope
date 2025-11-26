import 'package:adaptive_pop_scope/couple.dart';
import 'package:adaptive_pop_scope/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => const FourthPage(),
      );

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  late final _nameInput = TextEditingController();

  @override
  void dispose() {
    _nameInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AdaptivePopScope(
      onWillPop: () async {
        final shouldPop = await _showAlertDialog(context);
        final name = _nameInput.text.trim();
        return Couple(shouldPop ?? false, name.isEmpty ? null : name);
      },
      swipeWidth: screenWidth,
      swipeThreshold: screenWidth / 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fourth Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Enter your name'),
            controller: _nameInput,
          ),
        ),
      ),
    );
  }

  Future<bool?> _showAlertDialog(BuildContext context) {
    final name = _nameInput.text.trim();
    if (name.isEmpty) return Future.value(true);
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
