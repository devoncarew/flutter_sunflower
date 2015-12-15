import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

final double maxSliderValue = 1000.0;

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Sunflower",
      routes: {
        Navigator.defaultRouteName: (_) => new SunflowerDemo()
      }
    )
  );
}

class SunflowerDemo extends StatefulComponent {
  SunflowerState createState() => new SunflowerState();
}

class SunflowerState extends State<SunflowerDemo> {
  double _value = maxSliderValue * 2 / 3;

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        // TODO: On small screens this overflows. How to specify to use ellipsis?
        center: new Text("Flutter Sunflower"),
        right: <Widget>[
          new Slider(
            min: 0.0,
            value: _value,
            max: maxSliderValue,
            activeColor: Theme.of(context).canvasColor,
            onChanged: (double value) {
              setState(() {
                _value = value;
              });
            }
          )
        ]
      ),
      body: new Container(
        child: new CustomPaint(
          painter: new SunflowerPainter(
            color: Colors.orange[500],
            seeds: _value
          )
        ),
        padding: const EdgeDims.all(16.0)
      )
    );
  }
}

class SunflowerPainter extends CustomPainter {
  static final double phi = (math.sqrt(5) + 1) / 2;

  SunflowerPainter({
    this.color,
    this.seeds
  });

  final Color color;
  final double seeds;

  void paint(Canvas canvas, Size size) {
    double maxDimension = math.min(size.width, size.height);
    double scaleFactor = (maxDimension / 2.0) / math.sqrt(maxSliderValue);
    double seedRadius = scaleFactor * 0.6;

    double xCenter = size.width / 2;
    double yCenter = size.height / 2;
    double tauPhiRatio = (math.PI * 2) / phi;

    Paint paint = new Paint()
      ..color = color
      ..style = ui.PaintingStyle.fill;

    for (int i = 0; i < seeds; i++) {
      double theta = i * tauPhiRatio;
      double r = math.sqrt(i) * scaleFactor;

      canvas.drawCircle(new Point(
        xCenter + r * math.cos(theta),
        yCenter - r * math.sin(theta)
      ), seedRadius, paint);
    }
  }

  bool shouldRepaint(SunflowerPainter oldPainter) {
    return oldPainter.color != color || oldPainter.seeds != seeds;
  }
}
