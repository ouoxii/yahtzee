class player {
  String name;
  int score;
  int? Ones;
  int? Twos;
  int? Threes;
  int? Fours;
  int? Fives;
  int? Sixes;
  int? Three_of_a_kind;
  int? Four_of_a_kind;
  int? Small_Straight;
  int? Large_Straight;
  int? Yahtzee;
  int? Chance;
  int? Full_House;
  player(
      {required this.name,
      this.score = 0,
      this.Ones,
      this.Twos,
      this.Threes,
      this.Fours,
      this.Fives,
      this.Sixes,
      this.Three_of_a_kind,
      this.Four_of_a_kind,
      this.Small_Straight,
      this.Large_Straight,
      this.Yahtzee,
      this.Chance,
      this.Full_House});
  void setScore(String category, int value) {
    switch (category) {
      case 'Ones':
        Ones = value;
        break;
      case 'Twos':
        Twos = value;
        break;
      case 'Threes':
        Threes = value;
        break;
      case 'Fours':
        Fours = value;
        break;
      case 'Fives':
        Fives = value;
        break;
      case 'Sixes':
        Sixes = value;
        break;
      case 'Three_of_a_kind':
        Three_of_a_kind = value;
        break;
      case 'Four_of_a_kind':
        Four_of_a_kind = value;
        break;
      case 'Small_Straight':
        Small_Straight = value;
        break;
      case 'Large_Straight':
        Large_Straight = value;
        break;
      case 'Yahtzee':
        Yahtzee = value;
        break;
      case 'Chance':
        Chance = value;
        break;
      case 'Full_House':
        Full_House = value;
        break;
    }
  }
}
