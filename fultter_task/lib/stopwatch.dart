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

  final _scrollController = ScrollController(); //スクロール制御

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              //StreamBuilderは非同期に役に立つウィジェット

              stream: _stopwatchTimer.rawTime, //経過ミリ秒
              initialData: _stopwatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final displayTime = StopWatchTimer.getDisplayTime(
                  //getDisplayTimeはパッケージのやつ

                  snapshot.data!, //非同期で受け取ったデータ [!]がつくとNULLにはならない
                );
                return Center(
                  child: SizedBox(
                    width: 144,
                    child: Text(
                      displayTime,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 80,
              child: StreamBuilder<List<StopWatchRecord>>(
                  //ラップ機能
                  stream: _stopwatchTimer.records,
                  initialData: const [],
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<StopWatchRecord>>
                        snapshot, //Streamの最新のスナップショットを取得????
                  ) {
                    final value = snapshot.data;
                    if (value!.isEmpty) {
                      return const Text('No Record');
                    }
                    return ListView.builder(
                        //ListView.builder スクロール可能なリストを作成
                        controller: _scrollController,
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = value[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8), //余白
                                child: Text('${index + 1} ${data.displayTime}'),
                              )
                            ],
                          );
                        });
                  }),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _stopwatchTimer.onStartTimer();
              },
              child: const Text('Start'),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _stopwatchTimer.onStartTimer();
              },
              child: const Text('Start'),

            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _stopwatchTimer.onStartTimer();
              },
              child: const Text('Start'),

            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _stopwatchTimer.onStartTimer();
              },
              child: const Text('Start'),

            ),
          ],
        ),
      ),
    );
  }
}
