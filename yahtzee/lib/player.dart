class Player {
  String name;
  int score = 0;
  List<String> categories = [
    'Ones',
    'Twos',
    'Threes',
    'Fours',
    'Fives',
    'Sixes'
  ];
  Map<String, int> scores = {
    'Ones': 0,
    'Twos': 0,
    'Threes': 0,
    'Fours': 0,
    'Fives': 0,
    'Sixes': 0,
    'Three_of_a_kind': 0,
    'Four_of_a_kind': 0,
    'Small_Straight': 0,
    'Large_Straight': 0,
    'Yahtzee': 0,
    'Chance': 0,
    'Full_House': 0,
  };

  Player({required this.name});

  void setScore(String category, int value) {
    if (scores.containsKey(category)) {
      scores[category] = value;
    }
  }

  int getScore(String category) {
    return scores[category] ?? 0;
  }
}
