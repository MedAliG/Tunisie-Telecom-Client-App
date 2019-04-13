class UserData {
  String sold;
  String soldInternet;
  String finSold;
  String finSoldInternet;
  String bonus;
  String finBonus;

  UserData(
      {this.sold,
      this.soldInternet,
      this.finSold,
      this.finSoldInternet,
      this.bonus,
      this.finBonus});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return UserData(
        sold: parsedJson['sold'],
        soldInternet: parsedJson['sold_internet'],
        finSold: parsedJson['fin_sold'],
        finSoldInternet: parsedJson['fin_sold_internet'],
        bonus: parsedJson['bonus'],
        finBonus: parsedJson['bonus_days_left']);
  }
}
