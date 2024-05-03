class Player {
  String name;
  int score = 0;
  List<String> categories = [
    'Ones',
    'Twos',
    'Threes',
    'Fours',
    'Fives',
    'Sixes',
    'Bonus',
    'Three_of_a_kind',
    'Four_of_a_kind',
    'Small_Straight',
    'Large_Straight',
    'Yahtzee',
    'Chance',
    'Full_House'
  ];
  Map<String, int> scores = {
    for (var category in [
      'Ones',
      'Twos',
      'Threes',
      'Fours',
      'Fives',
      'Sixes',
      'Bonus',
      'Three_of_a_kind',
      'Four_of_a_kind',
      'Small_Straight',
      'Large_Straight',
      'Yahtzee',
      'Chance',
      'Full_House'
    ])
      category: 0,
  };

  Map<String, bool> scored = {
    for (var category in [
      'Ones',
      'Twos',
      'Threes',
      'Fours',
      'Fives',
      'Sixes',
      'Bonus',
      'Three_of_a_kind',
      'Four_of_a_kind',
      'Small_Straight',
      'Large_Straight',
      'Yahtzee',
      'Chance',
      'Full_House'
    ])
      category: false,
  };

  Player({required this.name});

  void setScore(String category, int value) {
    if (scores.containsKey(category)) {
      scores[category] = value;
      scored[category] = true; // Mark as scored
    }
  }

  int getScore(String category) {
    return scores[category] ?? 0;
  }

  bool getScored(String category) {
    return scored[category] ??
        false; // Check if the score has been explicitly set
  }
}
