// @dart=2.9
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _CustomPainter(this, onChanged);
  }
  // @override
  // _CustomPainter createBoxPainter([VoidCallback onChanged]) {
  //   return new _CustomPainter(this, onChanged);
  // }
}

class _CustomPainter extends BoxPainter {
  final CustomIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = Offset(offset.dx + configuration.size.width / 13,
            (configuration.size.height / 6)) &
        Size(configuration.size.width / 1.2, configuration.size.height / 1.5);
    final Paint paint = Paint();
    paint.color = Colors.grey.shade800;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(15.0)), paint);
  }
}
