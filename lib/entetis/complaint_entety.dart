class Complaint{
  String validationDate;
  int violationCount;
  bool violationEliminated;
  String userId;

  Map toUpdate() => {
    'userId': userId,
    'violationEliminatedStatus': !violationEliminated
  };

  Map toMap() => {
    'validationDate': validationDate,
    'violationCount': violationCount,
    'violationEliminated': violationEliminated,
  };

  Complaint({required this.validationDate,
    required this.violationCount, required this.violationEliminated, required this.userId});

//TODO:rewrite this shit
}