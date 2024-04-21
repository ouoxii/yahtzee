import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
  // chiikawa usagi = chiikawa.forname('usagi');
  // print(usagi.power * 2);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _diceEmojis = [
    '⚀',
    '⚁',
    '⚂',
    '⚃',
    '⚄',
    '⚅',
  ];
  var _diceIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _diceEmojis[_diceIndex],
              style: const TextStyle(
                fontSize: 200,
                color: Colors.orange,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _diceIndex = Random().nextInt(6);
                });
              },
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
