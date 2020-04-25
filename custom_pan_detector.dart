import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class CustomPanGestureDetector extends OneSequenceGestureRecognizer {
  final VoidCallback onPanStart;
  final VoidCallback onPanEnd;
  var _startedPanning = false;

  CustomPanGestureDetector({@required this.onPanStart, @required this.onPanEnd})
      : assert(onPanStart != null),
        assert(onPanEnd != null);

  @override
  void addPointer(PointerEvent event) {
    if (event is PointerDownEvent) {
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.rejected);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      if(!_startedPanning) {
        _startedPanning = true;
        onPanStart();
      }
    } else if (event is PointerUpEvent) {
      if (_startedPanning) {
        _startedPanning = false;
        onPanEnd();
      }
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  String get debugDescription => 'customPanDetector';
}
