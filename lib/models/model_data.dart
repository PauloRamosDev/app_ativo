class Data {
  int id;
  String fieldOne;
  String fieldTwo;
  String fieldTree;
  String fieldFour;
  String fieldFive;
  String fieldSix;
  String fieldSeven;
  String fieldEigth;
  int sent;

  Data({
    this.id,
    this.fieldOne,
    this.fieldTwo,
    this.fieldTree,
    this.fieldFour,
    this.fieldFive,
    this.fieldSix,
    this.fieldSeven,
    this.fieldEigth,
    this.sent,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldOne = json['fieldOne'];
    fieldTwo = json['fieldTwo'];
    fieldTree = json['fieldTree'];
    fieldFour = json['fieldFour'];
    fieldFive = json['fieldFive'];
    fieldSix = json['fieldSix'];
    fieldSeven = json['fieldSeven'];
    fieldEigth = json['fieldEigth'];
    sent = json['sent'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fieldOne': fieldOne,
      'fieldTwo': fieldTwo,
      'fieldTree': fieldTree,
      'fieldFour': fieldFour,
      'fieldFive': fieldFive,
      'fieldSix': fieldSix,
      'fieldSeven': fieldSeven,
      'fieldEigth': fieldEigth,
      'sent': sent,
    };
  }
}
