import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'stopwatch.dart';
import 'memo.dart';
import 'timer_page.dart';

class memu extends StatelessWidget {
  const memu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEMU'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NextPage()),
                      );
                    },
                    child: const Text('MEMO')),
                const SizedBox(width: 80), // 横スペース
                ElevatedButton(onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Fullter_Timer()),
                  );
                }, child: const Text('TIMER')),
              ],
            ),
            const SizedBox(height: 80), // 縦スペース
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Stopwatch()),
                  );
                }, child: const Text('Stop watch')),
                const SizedBox(width: 80), // 横スペース
                ElevatedButton(onPressed: () {}, child: const Text('ボタン')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
