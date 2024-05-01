import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  int chooseCategory = 7;
  int round = 0;
  final _diceEmojis = [
    '🎲',
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
  int caculateScore(List<int> dice, String category) {
    if (category == 'Ones') {
      return dice.where((element) => element == 1).length;
    }
    if (category == 'Twos') {
      return dice.where((element) => element == 2).length * 2;
    }
    if (category == 'Threes') {
      return dice.where((element) => element == 3).length * 3;
    }
    if (category == 'Fours') {
      return dice.where((element) => element == 4).length * 4;
    }
    if (category == 'Fives') {
      return dice.where((element) => element == 5).length * 5;
    }
    if (category == 'Sixes') {
      return dice.where((element) => element == 6).length * 6;
    }
    if (category == 'Three_of_a_kind') {
      if (dice.toSet().length <= 3) {
        return dice.reduce((a, b) => a + b);
      } else
        return 0;
    }
    if (category == 'Four_of_a_kind') {
      if (dice.toSet().length == 2) {
        return dice.reduce((a, b) => a + b);
      } else
        return 0;
    }
    if (category == 'Small_Straight') {
      if (dice.toSet().length == 4) {
        return 30;
      } else
        return 0;
    }
    if (category == 'Large_Straight') {
      if (dice.toSet().length == 5) {
        return 40;
      } else
        return 0;
    }
    if (category == 'Yahtzee') {
      if (dice.toSet().length == 1) {
        return 50;
      } else
        return 0;
    }
    if (category == 'Chance') {
      return dice.reduce((a, b) => a + b);
    }
    if (category == 'Full_House') {
      if (dice.toSet().length == 2) {
        return 25;
      } else
        return 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Title(player1: player1),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 4, 40), // 設置背景顏色
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        categories.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              chooseCategory = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == chooseCategory
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                    image: AssetImage(
                                        'dice/${categories[index]}.png'),
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                Text(
                                  '${player1.getScore(categories[index])}',
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${caculateScore(_diceIndex, categories[index])}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        categories2.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              chooseCategory = index + 10;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index + 10 == chooseCategory
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '${categories2[index]}: ${player1.getScore(categories2[index])} ${caculateScore(_diceIndex, categories2[index])}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                //骰色子區
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        _diceIndex.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (round > 0) {
                                _selectedDice[index] = !_selectedDice[index];
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedDice[index]
                                  ? Colors.blue
                                  : Colors
                                      .transparent, // Change color on selection
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              round++;
                              for (var i = 0; i < 5; i++) {
                                if (!_selectedDice[i] && round < 4) {
                                  _diceIndex[i] = Random().nextInt(6) + 1;
                                }
                              }
                            });
                          },
                          child: const Text('Roll Dice'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              var mode = 0;
                              if ((chooseCategory != 7) && (round > 0)) {
                                (chooseCategory < 6) ? mode = 1 : mode = 2;
                                switch (mode) {
                                  case 1:
                                    if (!player1.getScored(
                                        categories[chooseCategory])) {
                                      var total = caculateScore(_diceIndex,
                                          categories[chooseCategory]);
                                      player1.setScore(
                                          categories[chooseCategory], total);
                                      round = 0;
                                      player1.score = player1.scores.values
                                          .reduce((a, b) => a + b);
                                      // reset the round settings
                                      chooseCategory = 7;
                                      _selectedDice = List.filled(5, false);
                                    }
                                    break;
                                  case 2:
                                    if (!player1.getScored(
                                        categories2[chooseCategory - 10])) {
                                      var total = caculateScore(_diceIndex,
                                          categories2[chooseCategory - 10]);
                                      player1.setScore(
                                          categories2[chooseCategory - 10],
                                          total);
                                      round = 0;
                                      player1.score = player1.scores.values
                                          .reduce((a, b) => a + b);
                                      // reset the round settings
                                      chooseCategory = 7;
                                      _selectedDice = List.filled(5, false);
                                    }
                                    break;
                                }
                              }
                            });
                          },
                          child: const Text('Play'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.player1,
  });

  final Player player1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          player1.name,
          style: TextStyle(
            color: Colors.white, // 設置文字顏色
            fontSize: 20, // 設置文字大小
            fontWeight: FontWeight.bold, // 設置文字加粗
            fontFamily: 'Roboto', // 設置字體
          ),
        ),
        Text('Score:' + player1.score.toString()),
      ],
    );
  }
}
