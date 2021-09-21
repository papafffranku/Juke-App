import 'dart:ui';

import 'package:flutter/animation.dart';

class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect? begin,
    required Rect? end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    var value1 = lerpDouble(begin!.left, end!.left, elasticCurveValue); // 15
    var value2 = lerpDouble(begin!.top, end!.top, elasticCurveValue); // 15
    var value3 = lerpDouble(begin!.right, end!.right, elasticCurveValue); // 15
    var value4 =
    lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue); // 15
    return Rect.fromLTRB(value1!, value2!, value3!, value4!);
  }
}