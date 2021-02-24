import 'package:flutter/material.dart';
import 'package:goodmeal/utils/colors.dart';

import 'graph_utils.dart';

class GraphLinePainter extends CustomPainter {
  int highlightedIndex;
  List<int> dataY;

  GraphLinePainter({this.dataY, this.highlightedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = CustomColors.red;
    paint.strokeWidth = 1.0;
    paint.style = PaintingStyle.stroke;

    List<Offset> locationInCanvas =
        calculateLocationInCanvas(canvasSize: size, dataY: dataY);

    var path = Path();
    for (int i = 0; i < locationInCanvas.length; i++) {
      if (i == 0) {
        Offset pos = locationInCanvas[i];
        path.moveTo(pos.dx, pos.dy);
        continue;
      }
      Offset pos = locationInCanvas[i];
      path.lineTo(pos.dx, pos.dy);
    }
    canvas.drawPath(path, paint);

    Offset circlePos = locationInCanvas[highlightedIndex];
    paint.style = PaintingStyle.fill;
    paint.color = CustomColors.lightRed;
    canvas.drawCircle(circlePos, 11.0, paint);
    paint.color = CustomColors.red;
    canvas.drawCircle(circlePos, 5.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
