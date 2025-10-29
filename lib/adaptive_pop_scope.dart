import 'dart:io';

import 'package:flutter/cupertino.dart';

class AdaptivePopScope extends StatefulWidget {
  /// The shown widget (can be swiped if user used the Apple device)
  final Widget child;

  /// Callback when tried to navigate back to previous page, it will be popped if the return was [true]
  final Future<bool> Function()? onWillPop;
  final double? swipeWidth;
  final double? swipeThreshold;

  const AdaptivePopScope({
    super.key,
    this.swipeWidth,
    this.swipeThreshold,
    this.onWillPop,
    required this.child,
  });

  @override
  State<AdaptivePopScope> createState() => _AdaptivePopScopeState();
}

class _AdaptivePopScopeState extends State<AdaptivePopScope>
    with SingleTickerProviderStateMixin {
  late final _marginLeftNotifier = ValueNotifier(0.0);
  double? _startDx;
  double? _startDy;
  bool _isSwiping = false;

  bool get _isApple => Platform.isMacOS || Platform.isIOS;

  double get _currentMarginLeft => _marginLeftNotifier.value;
  double get _swipeWidth =>
      widget.swipeWidth ?? MediaQuery.of(context).size.width;
  double get _swipeThreshold => widget.swipeThreshold ?? (_swipeWidth / 3);
  double get _swipeStartArea => 50.0;

  @override
  void dispose() {
    _marginLeftNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: widget.onWillPop == null,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop || _isApple) return;
          widget.onWillPop?.call();
        },
        child: _isApple && widget.onWillPop != null
            ? GestureDetector(
                onHorizontalDragStart: (details) {
                  final touchX = details.globalPosition.dx;
                  if (touchX <= _swipeStartArea) {
                    _startDx = touchX;
                    _startDy = details.globalPosition.dy;
                    _isSwiping = true;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (!_isSwiping || _startDx == null || _startDy == null) {
                    return;
                  }

                  final dx = details.globalPosition.dx - _startDx!;
                  final dy = details.globalPosition.dy - _startDy!;

                  if (dx.abs() > dy.abs() * 1.75) {
                    final isSwipedRight = dx > 0;
                    final isSwiped = _currentMarginLeft > 0;
                    if (isSwipedRight) {
                      _marginLeftNotifier.value = dx;
                    } else if (isSwiped) {
                      _marginLeftNotifier.value = dx;
                    }
                  }
                },
                onHorizontalDragEnd: (_) {
                  if (!_isSwiping) return;
                  _isSwiping = false;

                  final isThresholdExceeded =
                      _currentMarginLeft >= _swipeThreshold;
                  if (isThresholdExceeded) {
                    widget.onWillPop?.call().then((canBack) {
                      if (canBack && context.mounted) Navigator.pop(context);
                    }).whenComplete(() => _marginLeftNotifier.value = 0);
                  } else {
                    _marginLeftNotifier.value = 0;
                  }
                },
                onHorizontalDragCancel: () {
                  _isSwiping = false;
                  _marginLeftNotifier.value = 0;
                },
                onHorizontalDragDown: (_) {
                  _isSwiping = false;
                  _marginLeftNotifier.value = 0;
                },
                child: ValueListenableBuilder<double>(
                  valueListenable: _marginLeftNotifier,
                  builder: (_, margin, __) => AnimatedSlide(
                    duration: const Duration(milliseconds: 200),
                    offset: Offset(margin / _swipeWidth, 0),
                    child: widget.child,
                  ),
                ),
              )
            : widget.child,
      );
}
