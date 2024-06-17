import 'dart:js_interop';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart'; //こういうパッケージがありました

class Stopwatch extends StatefulWidget {
  const Stopwatch({Key? key}) : super(key: key);

  @override
  State<Stopwatch> createState() => _stopwatch();
}

class _stopwatch extends State<Stopwatch> {
  final _stopwatchTimer = StopWatchTimer();

  @override //初期化
  void initState() {
    super.initState();
  }

  @override //終わった時のクリーンアップ
  void dispose() {
    _stopwatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopwatchTimer.rawTime, //経過ミリ秒
      initialData: _stopwatchTimer.rawTime.value,
      builder: (context, snapshot) {
        final displayTime = StopWatchTimer.getDisplayTime(
          //getDisplayTimeはパッケージのやつ
          snapshot.data!, //非同期で受け取ったデータ [!]がつくとNULLにはならない
        );
        return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            displayTime,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _stopwatchTimer.onExecute.add(StopWatchExecute.start);
            },
            child: Text('Start'),
          )
        ]));
      },
    );
  }
}
