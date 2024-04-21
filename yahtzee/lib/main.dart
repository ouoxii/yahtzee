import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        title: Text("Yahtzee"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Yahtzee",
              style: GoogleFonts.shadowsIntoLight(
                fontSize: 30,
              ),
            ),
            Text("player1")
          ],
        ),
      ),
    );
  }
}
