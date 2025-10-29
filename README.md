 <div align="center">
    <img  src="https://raw.githubusercontent.com/abdur-rohman/Adaptive-Pop-Scope/main/assets/adaptive-pop-scope.png"/>
 </div>
 </br>

<div align="center">

[![Buy Me Coffee Badge](https://img.shields.io/badge/-Buy_Me_a_Coffee-FFDD00?style=for-the-badge&logo=buymeacoffee&logoColor=535353)](https://www.buymeacoffee.com/abdurrohmaj)
[![Linkedin Badge](https://img.shields.io/badge/linkedin-0a66c2?style=for-the-badge&logo=linkedin&logoColor=ffffff)](https://www.linkedin.com/in/abdur-rohman-dev/)
[![Instagram Badge](https://img.shields.io/badge/instagram-F3F3F3?style=for-the-badge&logo=instagram&logoColor=d62976)](https://www.instagram.com/abdur_rohman.dev/)
[![Pub Dev Badge](https://img.shields.io/badge/Pub-1.0.2-42A5F5?style=for-the-badge&logo=flutter)](https://pub.dev/packages/adaptive_pop_scope)

</div>

Adaptive pop scope a custom pop scope widget to allow apple user backs with apple back gesture

## Preview

| iOS                                                                                                | Android                                                                                                |
| -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| <img src="https://raw.githubusercontent.com/abdur-rohman/Adaptive-Pop-Scope/main/assets/ios.gif"/> | <img src="https://raw.githubusercontent.com/abdur-rohman/Adaptive-Pop-Scope/main/assets/android.gif"/> |

## Getting started

Add the `adaptive_will_pop` lib to your `pubspec.yaml` then run the `flutter pub get`

```yaml
dependencies:
  adaptive_will_pop_scope:
```

import the lib by adding this line code

```dart
import 'package:adaptive_will_pop_scope/adaptive_will_pop_scope.dart';
```

## Usage

Adaptive Will Pop Scope adds two optional params `swipeWidth` to determines the maximum width that user can swipe (by default it was assigned to the screen width) and `swipeThreshold` to indicates the `onWillPop` will be called if the user swipe over this value (by default it was assigned to one third of the `swipeWidth`).

```dart
class SeconPage extends StatefulWidget {
  const SeconPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(builder: (_) => const SeconPage());

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
      swipeThreshold: screenWidth / 3,
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
```
