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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: MyHomePage(),
      ),
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
  List<String> _diceEmojis = [
    'casino',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
  ];
  List<int> _diceIndex = [0, 0, 0, 0, 0];
  List<String> categories = [
    'Ones',
    'Twos',
    'Threes',
    'Fours',
    'Fives',
    'Sixes',
    'Bonus',
  ];
  List<String> categories2 = [
    'Three_of_a_kind',
    'Four_of_a_kind',
    'Small_Straight',
    'Large_Straight',
    'Yahtzee',
    'Chance',
    'Full_House'
  ];

  int calculateScore(List<int> dice, String category) {
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

  Widget scoreWidget(int index, List<String> categoryList, int offset) {
    bool isSelected = index + offset == chooseCategory;
    Color bgColor = isSelected ? Color(0xFFAE98B6) : Colors.transparent;
    return GestureDetector(
      onTap: () {
        setState(() {
          chooseCategory = index + offset;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: AssetImage('dice/${categoryList[index]}.png'),
                width: 45,
                height: 45,
              ),
            ), // Placeholder for any image or icon
            SizedBox(width: 10),
            clipContainer('${player1.getScore(categoryList[index])}'),
            SizedBox(width: 10),
            clipContainer('${calculateScore(_diceIndex, categoryList[index])}'),
          ],
        ),
      ),
    );
  }

  Widget clipContainer(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 45,
        height: 45,
        color: Color(0xFFEAE0E9),
        child: Center(child: Text(text)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: screenHeight * 0.3,
          left: 0,
          right: 0,
          child: Container(
            color: Color(0xFF846E89),
            child: Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(categories.length,
                          (index) => scoreWidget(index, categories, 0)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(categories2.length,
                          (index) => scoreWidget(index, categories2, 10)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
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
                                    _selectedDice[index] =
                                        !_selectedDice[index];
                                  }
                                });
                              },
                              child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: _selectedDice[index]
                                        ? Color(0xFFEAE0E9)
                                        : Colors
                                            .transparent, // Change color on selection
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: AssetImage(
                                            'dice/${_diceEmojis[_diceIndex[index]]}.png'),
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                          var total = calculateScore(_diceIndex,
                                              categories[chooseCategory]);
                                          player1.setScore(
                                              categories[chooseCategory],
                                              total);
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
                                          var total = calculateScore(_diceIndex,
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
