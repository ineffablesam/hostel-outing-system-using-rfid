import 'package:flutter/material.dart';

class BottomNavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: MyBorderShape(),
          shadows: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.16),
              offset: Offset(0, 0),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.accessibility_new),
              ],
            ),
            _buildMiddleTabItem(),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.accessibility_new),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24),
            Text(''),
          ],
        ),
      ),
    );
  }
}

class MyBorderShape extends ShapeBorder {
  MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path(); // Implement your inner path logic here
  }

  double holeSize = 70;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print(rect.height);
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(rect.height / 2),
          ),
        )
        ..close(),
      Path()
        ..addOval(
          Rect.fromCenter(
            center: rect.center.translate(0, -rect.height / 2),
            height: holeSize,
            width: holeSize,
          ),
        )
        ..close(),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Implement your painting logic here
  }

  @override
  ShapeBorder scale(double t) => this;
}
