import "dart:math";
import 'dart:ui';

class SizingAndLocation {
  Size size;
  double minHeight;
  double maxHeight;
  double rectWidth;
  double minWidth;
  SizingAndLocation({this.size}) {
    minHeight = (size.height * 0.7);
    maxHeight = size.height * 0.08;
    rectWidth = (minHeight - maxHeight) * 2.0;
    minWidth = (size.width - rectWidth) / 2;
  }

  Offset locateSunPosition(double coverPercent) {
    double theta = pi * coverPercent;
    double radius = rectWidth / 2;
    double originX = minWidth + radius;
    double originY = minHeight;
    double x = originX - radius * cos(theta);
    double y = originY - radius * sin(theta);
    return Offset(x, y);
  }

  Offset locateSunRisePoint() {
    return Offset(minWidth, minHeight);
  }

  Offset locateSunSetPoint() {
    return Offset(size.width - minWidth, minHeight);
  }
}
