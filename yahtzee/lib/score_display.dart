import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final String player1Name;
  final int player1Score;
  final String player2Name;
  final int player2Score;
  final String currentPlayerName; // Current player's name for indicating turn

  const ScoreDisplay({
    Key? key,
    required this.player1Name,
    required this.player1Score,
    required this.player2Name,
    required this.player2Score,
    required this.currentPlayerName, // Added as a constructor parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlayer1Current = currentPlayerName == player1Name;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff846e89), Color(0xffe0c7e3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports, color: Color(0xff846e89)),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isPlayer1Current ? Color(0xffe0c7e3) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('$player1Name: $player1Score',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Text(' VS ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: !isPlayer1Current ? Color(0xffe0c7e3) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('$player2Name: $player2Score',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Icon(Icons.sports_esports, color: Color(0xffe0c7e3)),
        ],
      ),
    );
  }
}
