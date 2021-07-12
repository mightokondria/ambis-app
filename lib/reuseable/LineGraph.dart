/*
* SIMPLE LINEAR GRAPH NO GESTURE
* BY MUHAMMAD ARIFIN ILHAM
*
* TABLE OF CONTENTS
* GraphLine line 14
* GraphData line 22
* LinearGraph line 31
*  _GraphGenerator line 142
*/

import 'package:flutter/material.dart';

/* HELPER CLASSES */
class GraphLine {
  final String name;
  final double value;

  GraphLine({this.name, this.value});
}

class GraphData {
  final Color color;
  final String name;
  final List<GraphLine> data;

  GraphData({this.color: Colors.blue, this.name, this.data});
}

/* MAIN CLASSES */
class LineGraph extends StatefulWidget {
  final double height, width;
  final List<GraphData> data;
  final int gridCount;
  final bool fill, showGrids, animation;

  LineGraph(
      {Key key,
      this.height: 200,
      this.width: double.infinity,
      this.gridCount: 10,
      @required this.data,
      this.fill: true,
      this.showGrids: true,
      this.animation: false})
      : super(key: key);

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  final List<List<double>> grids = [];
  double max = 0;

  @override
  Widget build(BuildContext context) {
    final gridTextStyle = TextStyle(fontSize: 10, color: Color(0xFF888888));

    // CALCULATE MAXIMUM VALUE
    widget.data.forEach((lines) {
      lines.data.forEach((line) {
        if (max < line.value) max = line.value;
      });
    });

    // IF MAX IS 0
    // AVOID INFINITY LOOP
    max = (max < 1) ? 1 : max;

    // GENERATE GRIDS
    double yPosition = 0;
    for (double i = 0; i <= max; i += max / (widget.gridCount)) {
      grids.add([yPosition, i]);
      yPosition += (widget.height / (widget.gridCount));
    }

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: widget.height,
              child: Stack(
                children: grids.reversed
                    .map((e) => Transform.translate(
                          offset: Offset(0, widget.height - e[0] - 7.5),
                          child: Text(
                            e[1].toInt().toString(),
                            style: gridTextStyle,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: widget.height,
                  child: CustomPaint(
                    painter: _GraphGenerator(this, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.data.length < 2
                ? []
                : widget.data.map((e) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: e.color,
                              borderRadius: BorderRadius.circular(5)),
                          width: 10,
                          height: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          e.name,
                          style:
                              TextStyle(color: Color(0xFF555555), fontSize: 13),
                        )
                      ],
                    );
                  }).toList(),
          ),
        )
      ],
    );
  }
}

/* GRAPH GENERATOR CLASS */
class _GraphGenerator extends CustomPainter {
  final _LineGraphState instance;
  final double progress;

  _GraphGenerator(
    this.instance,
    this.progress,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width,
        height = size.height,
        scale = height / instance.max,
        grids = instance.grids.reversed.toList(),
        translation = Offset(0, 0);

    double xScale = 0;
    instance.widget.data.forEach((x) {
      if (xScale < x.data.length) xScale = x.data.length.toDouble();
    });
    xScale = width / (xScale - 1);

    if (instance.widget.showGrids)
      grids.forEach((e) {
        final gridPath = Path();
        final gridPaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = Color(0xFFEEEEEE)
          ..strokeWidth = 1.0;
        gridPath.moveTo(0, e[0] + translation.dy);
        gridPath.lineTo(width, e[0] + translation.dy);

        canvas.drawPath(gridPath, gridPaint);
      });

    instance.widget.data.forEach((graphData) {
      final graphPathStroke = Path(),
          graphPathFill = Path(),
          data = graphData.data,
          graphStroke = Paint()
            ..style = PaintingStyle.stroke
            ..color = graphData.color
            ..strokeWidth = 2.0
            ..strokeJoin = StrokeJoin.round,
          graphFill = Paint()
            ..style = PaintingStyle.fill
            ..color = graphData.color.withOpacity(.2),
          graphCirclePaint = Paint()
            ..style = PaintingStyle.fill
            ..color = graphData.color;

      graphPathStroke.moveTo(
          0, height + translation.dy - ((data[0].value * scale)));
      graphPathFill.moveTo(0, grids[0][0]);

      data.asMap().forEach((index, line) {
        final x = index * xScale,
            y = (height + translation.dy - ((line.value * scale)));
        graphPathStroke.lineTo(x, y);
        graphPathFill.lineTo(x, y);

        canvas.drawCircle(Offset(x, y), 3, graphCirclePaint);
      });

      graphPathFill.lineTo(xScale * (data.length - 1), grids[0][0]);
      graphPathFill.close();

      canvas.drawPath(graphPathStroke, graphStroke);

      if (instance.widget.fill) canvas.drawPath(graphPathFill, graphFill);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
