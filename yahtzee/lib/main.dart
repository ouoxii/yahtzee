import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahtzee/player.dart';
import 'package:yahtzee/score_display.dart';

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
  Player player2 = Player(name: 'monmonga'); // Added second player
  Player currentPlayer = Player(name: 'default');
  List<bool> _selectedDice = List.filled(5, false);
  int chooseCategory = 7;
  int round = 0;
  bool areAllCategoriesScored() {
    return player1.scores.keys
            .every((category) => player1.getScored(category)) &&
        player2.scores.keys.every((category) => player2.getScored(category));
  }

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
      Map<int, int> counts = {};
      for (int d in dice) {
        counts[d] = (counts[d] ?? 0) + 1;
      }
      if (counts.values.any((count) => count >= 3)) {
        return dice.reduce((a, b) => a + b);
      } else {
        return 0;
      }
    }

    if (category == 'Four_of_a_kind') {
      Map<int, int> counts = {};
      for (int d in dice) {
        counts[d] = (counts[d] ?? 0) + 1;
      }
      if (counts.values.any((count) => count >= 4)) {
        return dice.reduce((a, b) => a + b);
      } else {
        return 0;
      }
    }
    if (category == 'Small_Straight') {
      List<int> sortedDice = dice..sort();
      if ([1, 2, 3, 4].every(sortedDice.contains) ||
          [2, 3, 4, 5].every(sortedDice.contains) ||
          [3, 4, 5, 6].every(sortedDice.contains)) {
        return 30;
      } else {
        return 0;
      }
    }
    if (category == 'Large_Straight') {
      List<int> sortedDice = dice..sort();
      if ([1, 2, 3, 4, 5].every(sortedDice.contains) ||
          [2, 3, 4, 5, 6].every(sortedDice.contains)) {
        return 40;
      } else {
        return 0;
      }
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
      Map<int, int> counts = {};
      for (int d in dice) {
        counts[d] = (counts[d] ?? 0) + 1;
      }
      if (counts.values.toSet().containsAll({2, 3})) {
        return 25;
      } else {
        return 0;
      }
    }

    return 0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showNameEntryDialog());
  }

  void _showNameEntryDialog() {
    TextEditingController player1Controller = TextEditingController();
    TextEditingController player2Controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, // Makes dialog modal
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Player Names"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: player1Controller,
                decoration: InputDecoration(
                  labelText: "Player 1 Name",
                ),
              ),
              TextField(
                controller: player2Controller,
                decoration: InputDecoration(
                  labelText: "Player 2 Name",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Start Game"),
              onPressed: () {
                setState(() {
                  player1.name = player1Controller.text.isNotEmpty
                      ? player1Controller.text
                      : "Player 1";
                  player2.name = player2Controller.text.isNotEmpty
                      ? player2Controller.text
                      : "Player 2";
                  currentPlayer = Random().nextBool()
                      ? player1
                      : player2; // Randomly choose the starting player
                });
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void togglePlayer() {
    // Switch current player
    currentPlayer = (currentPlayer == player1) ? player2 : player1;
  }

  void checkAndHandleGameEnd() {
    if (areAllCategoriesScored()) {
      String resultMessage;
      if (player1.score > player2.score) {
        resultMessage = "${player1.name} wins!";
      } else if (player2.score > player1.score) {
        resultMessage = "${player2.name} wins!";
      } else {
        resultMessage = "It's a tie!";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Game Over"),
            content: Text(resultMessage),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                  // Optionally reset the game here or navigate to a new screen
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget scoreWidget(int index, List<String> categoryList, int offset) {
    bool isSelected = index + offset == chooseCategory;
    Color bgColor = isSelected ? Color(0xFFAE98B6) : Colors.transparent;

    // Initialize score strings as empty
    String scorePlayer1 = '', scorePlayer2 = '';

    // Check for player 1's score display logic
    if (player1.getScored(categoryList[index])) {
      // Display the player's recorded score
      scorePlayer1 = '${player1.getScore(categoryList[index])}';
    } else if (currentPlayer == player1 && round > 0) {
      // Calculate and display score only if it's player1's turn and they haven't scored yet
      scorePlayer1 = '${calculateScore(_diceIndex, categoryList[index])}';
    }

    // Check for player 2's score display logic
    if (player2.getScored(categoryList[index])) {
      // Display the player's recorded score
      scorePlayer2 = '${player2.getScore(categoryList[index])}';
    } else if (currentPlayer == player2 && round > 0) {
      // Calculate and display score only if it's player2's turn and they haven't scored yet
      scorePlayer2 = '${calculateScore(_diceIndex, categoryList[index])}';
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          chooseCategory = index + offset;
        });
      },
      child: Container(
        height: 60,
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
            clipContainer(scorePlayer1),
            SizedBox(width: 10),
            clipContainer(scorePlayer2),
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
          bottom: screenHeight * 0.25,
          left: 0,
          right: 0,
          child: Container(
            color: Color(0xFF846E89),
            child: Center(
              child: Container(
                  child: Column(
                children: [
                  Center(
                    child: ScoreDisplay(
                      player1Name: player1.name,
                      player1Score: player1.score,
                      player2Name: player2.name,
                      player2Score: player2.score,
                      currentPlayerName:
                          currentPlayer.name, // Pass the current player's name
                    ),
                  ),
                  Row(
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
                ],
              )),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -8,
          right: -8,
          top: 500,
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
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
                                        if (!currentPlayer.getScored(
                                            categories[chooseCategory])) {
                                          var total = calculateScore(_diceIndex,
                                              categories[chooseCategory]);
                                          currentPlayer.setScore(
                                              categories[chooseCategory],
                                              total);
                                          round = 0;
                                          currentPlayer.score = currentPlayer
                                              .scores.values
                                              .reduce((a, b) => a + b);
                                          // reset the round settings
                                          chooseCategory = 7;
                                          _diceIndex = List<int>.filled(
                                              _diceIndex.length, 0);
                                          _selectedDice = List.filled(5, false);
                                          togglePlayer(); // Toggle to the other player after a play
                                        }
                                        break;
                                      case 2:
                                        if (!currentPlayer.getScored(
                                            categories2[chooseCategory - 10])) {
                                          var total = calculateScore(_diceIndex,
                                              categories2[chooseCategory - 10]);
                                          currentPlayer.setScore(
                                              categories2[chooseCategory - 10],
                                              total);
                                          round = 0;
                                          currentPlayer.score = currentPlayer
                                              .scores.values
                                              .reduce((a, b) => a + b);
                                          // reset the round settings
                                          _diceIndex = List<int>.filled(
                                              _diceIndex.length, 0);
                                          chooseCategory = 7;
                                          _selectedDice = List.filled(5, false);
                                          togglePlayer(); // Toggle to the other player after a play
                                        }
                                        break;
                                    }
                                  }
                                });
                                checkAndHandleGameEnd();
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
