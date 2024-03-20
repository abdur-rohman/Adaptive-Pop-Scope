import 'dart:io';

import 'package:flutter/cupertino.dart';

class AdaptivePopScope extends StatefulWidget {
  /// The shwon widget (can be swiped if user used the apple device)
  final Widget child;

  /// Callback when tried to navigate back to previous page, it will be popped if the return was [true]
  final Future<bool> Function()? onWillPop;
  final double? swipeWidth;
  final double? swipeThreshold;

  const AdaptivePopScope({
    Key? key,
    this.swipeWidth,
    this.swipeThreshold,
    this.onWillPop,
    required this.child,
  }) : super(key: key);

  @override
  State<AdaptivePopScope> createState() => _AdaptivePopScopeState();
}

class _AdaptivePopScopeState extends State<AdaptivePopScope>
    with SingleTickerProviderStateMixin {
  late final _marginLeftNotifier = ValueNotifier(0.0);

  bool get _isApple => Platform.isMacOS || Platform.isIOS;

  double get _currentMarginLeft => _marginLeftNotifier.value;
  double get _swipeWidth =>
      widget.swipeWidth ?? MediaQuery.of(context).size.width;
  double get _swipeThreshold => widget.swipeThreshold ?? (_swipeWidth / 2);

  @override
  void dispose() {
    _marginLeftNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: widget.onWillPop == null,
        onPopInvoked: (didPop) {
          if (didPop || _isApple) return;
          widget.onWillPop?.call();
        },
        child: _isApple && widget.onWillPop != null
            ? GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final isSwipedRight = (details.primaryDelta ?? 0) > 0;
                  final isSwiped = _currentMarginLeft > 0;
                  if (isSwipedRight) {
                    _marginLeftNotifier.value = details.globalPosition.dx;
                  } else if (isSwiped) {
                    _marginLeftNotifier.value = details.globalPosition.dx;
                  }
                },
                onHorizontalDragDown: (_) {
                  _marginLeftNotifier.value = 0;
                },
                onHorizontalDragCancel: () {
                  _marginLeftNotifier.value = 0;
                },
                onHorizontalDragEnd: (_) {
                  final isThresholdExcedeed =
                      _currentMarginLeft >= _swipeThreshold;
                  if (isThresholdExcedeed) {
                    widget.onWillPop?.call().then((canBack) {
                      if (canBack) Navigator.pop(context);
                    }).whenComplete(() => _marginLeftNotifier.value = 0);
                  } else {
                    _marginLeftNotifier.value = 0;
                  }
                },
                child: ValueListenableBuilder<double>(
                  valueListenable: _marginLeftNotifier,
                  builder: (_, margin, __) => AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    offset: Offset(margin / _swipeWidth, 0),
                    child: widget.child,
                  ),
                ),
              )
            : widget.child,
      );
}
