import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final String player1Name;
  final int player1Score;
  final String player2Name;
  final int player2Score;

  const ScoreDisplay({
    Key? key,
    required this.player1Name,
    required this.player1Score,
    required this.player2Name,
    required this.player2Score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports, color: Colors.yellow[700]),
          SizedBox(width: 8),
          Text('$player1Name: $player1Score',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(' VS ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text('$player2Name: $player2Score',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Icon(Icons.sports_esports, color: Colors.yellow[700]),
        ],
      ),
    );
  }
}
