import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahtzee/player.dart';

void main() {
  runApp(MyApp());
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
  Player player1 = Player(name: 'usagi');
  List<bool> isSelected = List.generate(20, (_) => false);

  final _diceEmojis = [
    '⚀',
    '⚁',
    '⚂',
    '⚃',
    '⚄',
    '⚅',
  ];
  List<int> _diceIndex = [0, 0, 0, 0, 0];
  List<String> categories = [
    'Ones',
    'Twos',
    'Threes',
    'Fours',
    'Fives',
    'Sixes'
  ];
  List<String> categories2 = [
    'Three_of_a_kind',
    'Four_of_a_kind',
    'Small_Straight',
    'Large_Straight',
    'Yahtzee',
    'Chance',
    'Full_House',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yahtzee"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  player1.name,
                  style: GoogleFonts.shadowsIntoLight(
                    fontSize: 30,
                  ),
                ),
                Text('SCORE:' + player1.score.toString()),
              ],
            ),
            Row(
                //目前記錄
                children: [
                  Expanded(
                    child: Container(
                      height: 350,
                      margin: EdgeInsets.only(left: 100),
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          String category = categories[index];
                          int score = player1.getScore(category);
                          return ListTile(
                            title: Text('$category: $score'),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: categories2.length,
                        itemBuilder: (context, index) {
                          String category = categories2[index];
                          int score = player1.getScore(category);
                          return ListTile(
                            title: Text('$category: $score'),
                          );
                        },
                      ),
                    ),
                  ),
                ]),
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _diceIndex.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10), // 添加水平间距
                      child: Text(
                        '${_diceEmojis[_diceIndex[index]]}',
                        style: TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < 5; i++) {
                        _diceIndex[i] = Random().nextInt(6);
                      }
                    });
                  },
                  child: const Text('Roll Dice'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //將骰子的值存入player
                    });
                  },
                  child: const Text('Play'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
