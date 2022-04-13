class QuestionModel {
  String? enonce;
  String? choix1;
  String? choix2;
  String? choix3;
  String? reponse;
  QuestionModel({
    this.choix1,
    this.choix2,
    this.choix3,
    this.enonce,
    this.reponse,
  });
  factory QuestionModel.fromMap(map) {
    return QuestionModel(
      choix1: map['choix1'],
      choix2: map['choix2'],
      choix3: map['choix3'],
      enonce: map['enonce'],
      reponse: map['reponse'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'choix1': choix1,
      'choix2': choix2,
      'choix3': choix3,
      'enonce': enonce,
      'reponse': reponse,
    };
  }
}
