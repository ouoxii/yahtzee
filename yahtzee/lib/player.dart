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

      // Check for bonus eligibility after scoring
      if (category == 'Ones' ||
          category == 'Twos' ||
          category == 'Threes' ||
          category == 'Fours' ||
          category == 'Fives' ||
          category == 'Sixes') {
        checkAndApplyBonus();
      }
    }
  }

  int getScore(String category) {
    return scores[category] ?? 0;
  }

  bool getScored(String category) {
    return scored[category] ?? false;
  }

  void checkAndApplyBonus() {
    int upperSectionSum = scores.entries
        .where((entry) => ['Ones', 'Twos', 'Threes', 'Fours', 'Fives', 'Sixes']
            .contains(entry.key))
        .fold(0, (previousValue, element) => previousValue + element.value);

    // Ensure that 'scored['Bonus']' is not null and has not been scored yet
    // Check if the sum is at least 63 and if the bonus has not been scored
    if ((scored['Bonus'] ?? false) == false && upperSectionSum >= 10) {
      scores['Bonus'] = 35;
      scored['Bonus'] = true; // Mark the bonus as scored
    }
  }
}
