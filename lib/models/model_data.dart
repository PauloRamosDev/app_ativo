class Data {

  String fieldOne;
  String fieldTwo;
  String fieldTree;
  String fieldFour;
  String fieldFive;
  String fieldSeven;

  Data(
      {this.fieldOne,
      this.fieldTwo,
      this.fieldTree,
      this.fieldFour,
      this.fieldFive,
      this.fieldSeven});

  Data.fromJson(Map<String, dynamic> json) {
    fieldOne = json['fieldOne'];
    fieldTwo = json['fieldTwo'];
    fieldTree = json['fieldTree'];
    fieldFour = json['fieldFour'];
    fieldFive = json['fieldFive'];
    fieldSeven = json['fieldSeven'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldOne': fieldOne,
      'fieldTwo': fieldTwo,
      'fieldTree': fieldTree,
      'fieldFour': fieldFour,
      'fieldFive': fieldFive,
      'fieldSeven': fieldSeven,
    };
  }
}
