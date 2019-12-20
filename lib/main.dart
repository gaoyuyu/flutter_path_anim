import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new AnimatedPathDemo(),
    );
  }
}

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
//  Animation animation;
//
//  AnimationController controller;
//  List<double> arr = [0, 0, 0, 0, 0, 0];
//  double currentPathLength = 0;
//
//  initState() {
//    super.initState();
//    controller = new AnimationController(
//        duration: const Duration(milliseconds: 2000), vsync: this);
//    final CurvedAnimation curve =
//        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
//    animation = new Tween(begin: 0.0, end: 1.0).animate(curve)
//      ..addListener(() {
//        print("va-->${animation.value}");
//        setState(() {
//          arr = [
//            animation.value,
//            animation.value,
//            animation.value,
//            animation.value,
//            animation.value,
//            animation.value
//          ];
//        });
//      });
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text("自定义View"),
//        ),
//        body: Column(
//          children: <Widget>[
//            Container(
//              child: MaterialButton(
//                color: Colors.blue,
//                textColor: Colors.white,
//                child: new Text('点我'),
//                onPressed: () {
//                  controller.forward();
//                },
//              ),
//            ),
//            Container(
//              width: 200,
//              height: 200,
//              child: CustomPaint(
//                painter: MyPainter(6, arr),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class MyPainter extends CustomPainter {
//  ///多边形几个边
//  var sideNum = 6;
//
//  ///默认几圈多边形
//  var layerNum = 6;
//
//  ///view的中心点
//  double viewCenterX;
//  double viewCenterY;
//
//  ///半径
//  double maxRadius;
//  Path mPath;
//  final double CIRCLE_ANGLE = 360;
//
//  ///画线的画笔
//  Paint mPaint;
//
//  ///画覆盖层的画笔
//  Paint mLayerPaint;
//
//  ///测试用的画笔
//  Paint mTestPaint;
//
//  //数据
//  List<double> arr = [0.2, 0.5, 0.7, 0.5, 0.4, 0.7];
//
//  setArr(List<double> newArr) {
//    this.arr = newArr;
//  }
//
//  MyPainter(int sideNum, [List<double> arr]) {
//    this.sideNum = sideNum;
//    this.arr = arr;
//    mPaint = new Paint()
//      ..color = Colors.blueAccent
//      ..isAntiAlias = true
//      ..style = PaintingStyle.stroke;
//
//    mPath = new Path();
//
//    mLayerPaint = new Paint()
//      ..color = Colors.black38
//      ..isAntiAlias = true
//      ..style = PaintingStyle.fill;
//
//    mTestPaint = new Paint()
//      ..color = Colors.purpleAccent
//      ..isAntiAlias = true
//      ..strokeWidth = 5
//      ..style = PaintingStyle.fill;
//  }
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    viewCenterX = size.width / 2;
//    viewCenterY = size.height / 2;
//    print("viewCenterX-->$viewCenterX");
//    print("viewCenterY-->$viewCenterY");
//    maxRadius = max(viewCenterX, viewCenterY);
//    print("maxRadius-->$maxRadius");
//    canvas.save();
//
//    drawPolygon(canvas);
//
//    drawMaskLayer(canvas);
//
//    canvas.restore();
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return oldDelegate != this;
//  }
//
//  double eachRadius;
//  double eachAngle;
//
//  ///绘制多边形
//  void drawPolygon(Canvas canvas) {
//    eachAngle = CIRCLE_ANGLE / sideNum;
//
//    List<List<Offset>> data = [];
//    for (var j = 0; j <= sideNum; j++) {
//      data.add([]);
//    }
//
//    ///画一圈圈的多边形
//    for (var i = 0; i < layerNum; i++) {
//      mPath.reset();
//      eachRadius = maxRadius / layerNum * (i + 1);
//
//      for (var j = 0; j <= sideNum; j++) {
//        if (j == 0) {
//          mPath.moveTo(viewCenterX + eachRadius, viewCenterY);
//          data[j].add(Offset(viewCenterX + eachRadius, viewCenterY));
//        } else {
//          double x = viewCenterX + eachRadius * cos(degToRad(eachAngle * j));
//          double y = viewCenterY + eachRadius * sin(degToRad(eachAngle * j));
//          mPath.lineTo(x, y);
//          data[j].add(Offset(x, y));
//        }
//      }
//      mPath.close();
//      canvas.drawPath(mPath, mPaint);
//      linkPoints(data, canvas);
//    }
//  }
//
//  void linkPoints(List<List<Offset>> data, Canvas canvas) {
//    for (int i = 0; i < data.length; i++) {
//      List<Offset> line = data[i];
//
//      mPath.reset();
//      mPath.moveTo(viewCenterX, viewCenterY);
//      for (int k = 0; k < line.length; k++) {
//        mPath.lineTo(line[k].dx, line[k].dy);
//      }
//      mPath.close();
//      canvas.drawPath(mPath, mPaint);
//    }
//  }
//
//  void drawMaskLayer(Canvas canvas) {
//    mPath.reset();
//    for (int i = 0; i < sideNum; i++) {
//      double mRandomInt = arr[i];
//      print("radb--$mRandomInt");
//      double x =
//          viewCenterX + maxRadius * cos(degToRad(eachAngle * i)) * mRandomInt;
//      double y =
//          viewCenterY + maxRadius * sin(degToRad(eachAngle * i)) * mRandomInt;
//      if (i == 0) {
//        mPath.moveTo(x, viewCenterY);
//      } else {
//        mPath.lineTo(x, y);
//      }
//    }
//    mPath.close();
//    canvas.drawPath(mPath, mLayerPaint);
//  }
//
//  num degToRad(num deg) => deg * (pi / 180.0);
//
//  num radToDeg(num rad) => rad * (180.0 / pi);
//
//  double randomInt() {
//    Random random = new Random();
//    return (random.nextInt(10) + 1) / 10;
//  }
//}

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;

  AnimatedPathPainter(this._animation) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(size.height / 4, size.height / 4)
      ..lineTo(size.height, size.width / 2)
      ..lineTo(size.height / 2, size.width)
      ..quadraticBezierTo(size.height / 2, 100, size.width, size.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = this._animation.value;

    print("Painting + $animationPercent - $size");

    final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    // ComputeMetrics can only be iterated once!
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
    print("totalLength-->$totalLength");
    /*
    上面的代码相当于累加
    double length = 0;
    PathMetrics pathMetrics = originalPath.computeMetrics(forceClosed: false);
    Iterator<PathMetric> metricsIterator = pathMetrics.iterator;
    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;
      length = length + metric.length;
    }
    print("length-->$length");
  */
    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(
    Path originalPath,
    double currentLength,
  ) {
    var pathSegment = new Path();
    var metricsIterator = originalPath.computeMetrics().iterator;
    var length = originalPath.computeMetrics().length;
    print("originalPath.computeMetrics()->$length");
    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;
      if (currentLength < metric.length) {
        pathSegment = metric.extractPath(0.0, currentLength);
      } else {
        pathSegment = metric.extractPath(0.0, metric.length);
      }
    }
    return pathSegment;
  }
/*
//其他写法
//https://stackoverflow.com/questions/50978603/how-to-animate-a-path-in-flutter/57233047#57233047
  Path extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = new Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        // There might be a more efficient way of extracting an entire path
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }
  */
}

class AnimatedPathDemo extends StatefulWidget {
  @override
  _AnimatedPathDemoState createState() => _AnimatedPathDemoState();
}

class _AnimatedPathDemoState extends State<AnimatedPathDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.forward();
//    _controller.repeat(
//      period: Duration(seconds: 5),
//    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('Animated Paint')),
      body: SizedBox(
        height: 300,
        width: 300,
        child: new CustomPaint(
          painter: new AnimatedPathPainter(_controller),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _startAnimation,
        child: new Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
