import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimerPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AI(),
    );
  }
}

class AI extends StatefulWidget {
  const AI({Key? key}) : super(key: key);

  @override
  State<AI> createState() => _TimerPageState();
}

class _TimerPageState extends State<AI> {
  int _counter = 0;
  Timer? _timer;
  int? _alarmTime;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          _counter++;
          if (_alarmTime != null && _counter >= _alarmTime!) {
            _showNotification();
            _alarmTime = null; // Reset the alarm after it goes off
          }
        });
      },
    );
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '時間だよ！！',
      '時間だよ！！！',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _setAlarm() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('アラーム'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              _alarmTime = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('決定'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 16,
            top: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('戻る'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _startTimer,
                      child: const Text('Start'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _stopTimer,
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: ElevatedButton(
              onPressed: _setAlarm,
              child: const Text('Set Alarm'),
            ),
          ),
        ],
      ),
    );
  }
}
