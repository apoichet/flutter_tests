import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PerfAnimation extends StatefulWidget {
  const PerfAnimation({Key? key}) : super(key: key);

  @override
  _PerfAnimationState createState() => _PerfAnimationState();
}

class _PerfAnimationState extends State<PerfAnimation> {
  late bool start;
  late int degree;
  late int speed;
  late int loop;
  late Widget widgetRotation;
  Timer? timer;

  @override
  void initState() {
    start = false;
    speed = 1;
    loop = 1;
    degree = 0;
    widgetRotation = _RectangleRotation(
      degree: degree,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgetRotation,
            SizedBox(
              height: 48,
            ),
            _TextButton(
              callback: _startOrStopAnimation,
              backgroundColor: start ? Colors.red : Colors.green,
              text: start ? "Stop Animation" : "Start Animation",
            ),
            SizedBox(
              height: 8,
            ),
            _TextButton(
              callback: _resetAnimation,
              backgroundColor: Colors.orange,
              text: "Reset Animation",
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "Speed :",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _RadioListTile<int>(title: "X 1", value: 1, groupValue: speed, onChanged: _onChangedSpeed),
                  _RadioListTile<int>(title: "X 2", value: 2, groupValue: speed, onChanged: _onChangedSpeed),
                  _RadioListTile<int>(title: "X 3", value: 3, groupValue: speed, onChanged: _onChangedSpeed),
                  _RadioListTile<int>(title: "X 4", value: 4, groupValue: speed, onChanged: _onChangedSpeed),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "Loop :",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _RadioListTile<int>(title: "1", value: 1, groupValue: loop, onChanged: _onChangedLoop),
                  _RadioListTile<int>(title: "10", value: 10, groupValue: loop, onChanged: _onChangedLoop),
                  _RadioListTile<int>(title: "100", value: 100, groupValue: loop, onChanged: _onChangedLoop),
                  _RadioListTile<int>(title: "1000", value: 1000, groupValue: loop, onChanged: _onChangedLoop),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangedSpeed(value) {
    setState(() {
      speed = value ?? 0;
      if (_isTimerActive()) {
        timer?.cancel();
        timer = _buildTimer();
      }
    });
  }

  void _onChangedLoop(value) {
    setState(() {
      loop = value ?? 0;
      if (_isTimerActive()) {
        timer?.cancel();
        timer = _buildTimer();
      }
    });
  }

  bool _isTimerActive() => timer?.isActive ?? false;

  void _resetAnimation() {
    setState(() {
      degree = 0;
      speed = 1;
      start = false;
      loop = 1;
      widgetRotation = _RectangleRotation(
        degree: degree,
      );
      timer?.cancel();
    });
  }

  void _bigCalculate() {
    for (int i = 0; i < loop * 1000000; i++) {
      if (!start) {
        break;
      }
    }
  }

  Timer _buildTimer() {
    return Timer.periodic(Duration(milliseconds: 16 ~/ speed), (timer) {
      setState(() {
        widgetRotation = _RectangleRotation(
          degree: degree++,
        );
        _bigCalculate();
      });
    });
  }

  void _startOrStopAnimation() {
    if (!_isTimerActive()) {
      if (!start) {
        timer = _buildTimer();
      } else {
        timer?.cancel();
      }
    } else {
      timer?.cancel();
    }
    setState(() {
      start = !start;
    });
  }
}

class _RectangleRotation extends StatelessWidget {
  final int degree;
  final Color? color;
  final double? height;
  final double? width;

  const _RectangleRotation({required this.degree, this.color, this.height, this.width, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(degree / 360),
      child: Container(
        color: color ?? Colors.purpleAccent,
        height: height ?? 200,
        width: width ?? 200,
      ),
    );
  }
}

class _RadioListTile<int> extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final void Function(int?) onChanged;

  const _RadioListTile(
      {required this.title, required this.value, required this.groupValue, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile<int>(
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          value: value,
          dense: true,
          contentPadding: EdgeInsets.all(0.0),
          groupValue: groupValue,
          onChanged: onChanged),
    );
  }
}

class _TextButton extends StatelessWidget {
  final VoidCallback callback;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String text;

  const _TextButton({required this.callback, required this.text, this.foregroundColor, this.backgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: Text(
        text,
        style: TextStyle(fontSize: 19),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor ?? Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor ?? Colors.blue),
      ),
    );
  }
}
