class Data {

  String fieldOne;
  String fieldTwo;
  String fieldTree;
  String fieldFour;
  String fieldFive;
  String fieldSix;
  String fieldSeven;
  String fieldEigth;

  Data(
      {this.fieldOne,
      this.fieldTwo,
      this.fieldTree,
      this.fieldFour,
      this.fieldFive,
      this.fieldSix,
      this.fieldSeven,
      this.fieldEigth,
      });

  Data.fromJson(Map<String, dynamic> json) {
    fieldOne = json['fieldOne'];
    fieldTwo = json['fieldTwo'];
    fieldTree = json['fieldTree'];
    fieldFour = json['fieldFour'];
    fieldFive = json['fieldFive'];
    fieldSix = json['fieldSix'];
    fieldSeven = json['fieldSeven'];
    fieldEigth = json['fieldEigth'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldOne': fieldOne,
      'fieldTwo': fieldTwo,
      'fieldTree': fieldTree,
      'fieldFour': fieldFour,
      'fieldFive': fieldFive,
      'fieldSix': fieldSix,
      'fieldSeven': fieldSeven,
      'fieldEigth': fieldEigth,
    };
  }
}
