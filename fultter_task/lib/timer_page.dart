import 'package:flutter/material.dart';



class Fullter_Timer extends StatelessWidget {
  const Fullter_Timer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Timer(),
    );
  }
}

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Template'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Hello, Flutter!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
