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
  List<bool> _selectedDice = List.filled(5, false);
  final _diceEmojis = [
    '',
    '⚀',
    '⚁',
    '⚂',
    '⚃',
    '⚄',
    '⚅',
  ];
  List<int> _diceIndex = [6, 6, 6, 6, 6];
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                height: 350,
                child: Column(
                  children: List.generate(
                    categories.length,
                    (index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${categories[index]}: ${player1.getScore(categories[index])}',
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 350,
                child: Column(
                  children: List.generate(
                    categories2.length,
                    (index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${categories2[index]}: ${player1.getScore(categories2[index])}',
                      ),
                    ),
                  ),
                ),
              )
            ]),
            Container(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _diceIndex.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDice[index] = !_selectedDice[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedDice[index]
                              ? Colors.blue
                              : Colors.transparent, // Change color on selection
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _diceEmojis[_diceIndex[index]],
                          style: TextStyle(
                              fontSize: 36,
                              color: _selectedDice[index]
                                  ? Colors.white
                                  : Colors.black),
                        ),
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
                        if (!_selectedDice[i]) {
                          _diceIndex[i] = Random().nextInt(6) + 1;
                        }
                      }
                    });
                  },
                  child: const Text('Roll Dice'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
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
