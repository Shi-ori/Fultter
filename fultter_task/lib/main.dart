import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentTime = '';

  @override
  void initState() { //タイマ更新
    super.initState();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20), 
            const Text(
              '!!!!!!こんにちは!!!!!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), 
            const Text(
              'Current Time:',
            ),
            Text(
              _currentTime,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 60), 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( //メニュー遷移
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const memu()),
          );
        },
        tooltip: 'Next Page',
        child: const Text('MENU'),
      ), // This trailing comma makes a
    );
  }
}
