class ForfaitH {
  String id;
  String montant;
  String prix;
  String duree;
  String date;
  String convertDateToString() {
    var parsedDate = DateTime.parse(date);
    DateTime tm =
        new DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
    //return tm.toIso8601String();
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    Duration oneWeek = new Duration(days: 7);
    String month;
    switch (tm.month) {
      case 1:
        month = "Janvier";
        break;
      case 2:
        month = "Février";
        break;
      case 3:
        month = "Mars";
        break;
      case 4:
        month = "Avril";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Juin";
        break;
      case 7:
        month = "Juillet";
        break;
      case 8:
        month = "Août";
        break;
      case 9:
        month = "Septembre";
        break;
      case 10:
        month = "Octobre";
        break;
      case 11:
        month = "Novembre";
        break;
      case 12:
        month = "Décembre";
        break;
    }

    Duration difference = today.difference(tm);
    String dateS;
    if (difference.compareTo(oneDay) < 1) {
      dateS = "Aujourd'hui";

      return '$dateS, ${tm.day} $month ${tm.year}';
    } else if (difference.compareTo(twoDay) < 1) {
      dateS = "Hier";
      dateS = "$dateS, ${tm.day} $month ${tm.year}";
      return dateS;
    } else {
      switch (tm.weekday) {
        case 1:
          dateS = "Lundi";
          break;
        case 2:
          dateS = "Mardi";
          break;
        case 3:
          dateS = "Mercredi";
          break;
        case 4:
          dateS = "Jeudi";
          break;
        case 5:
          dateS = "Vendredi";
          break;
        case 6:
          dateS = "Samedi";
          break;
        case 7:
          dateS = "Dimanche";
          break;
      }
      return '$dateS, ${parsedDate.day} $month ${tm.year}';
    }
  }

  ForfaitH({this.id, this.montant, this.duree, this.prix, this.date});
  factory ForfaitH.fromJson(Map<String, dynamic> parsedJson) {
    return ForfaitH(
        id: parsedJson['id'],
        montant: parsedJson['forfaitMontant'],
        prix: parsedJson['forfaitPrix'],
        duree: parsedJson['forfaitDuree'],
        date: parsedJson['date']);
  }
}

class ForfaitHList {
  List<ForfaitH> forfaits;
  ForfaitHList({this.forfaits});
  factory ForfaitHList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['resultSet'] as List;

    List<ForfaitH> l = list.map((i) => ForfaitH.fromJson(i)).toList();
    return ForfaitHList(forfaits: l);
  }
}
