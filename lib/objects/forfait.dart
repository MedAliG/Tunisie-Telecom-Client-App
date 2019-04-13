class Forfait {
  String id;
  String montant;
  String prix;
  String duree;

  Forfait({this.id, this.montant, this.duree, this.prix});
  factory Forfait.fromJson(Map<String, dynamic> parsedJson) {
    return Forfait(
        id: parsedJson['id'],
        montant: parsedJson['montant'],
        prix: parsedJson['prix'],
        duree: parsedJson['duree']);
  }
}

class ForfaitList {
  List<Forfait> forfaits;
  ForfaitList({this.forfaits});
  factory ForfaitList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['resultSet'] as List;

    List<Forfait> l = list.map((i) => Forfait.fromJson(i)).toList();
    return ForfaitList(forfaits: l);
  }
}


