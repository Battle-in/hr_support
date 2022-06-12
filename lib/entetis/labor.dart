class Labor {
  String surname;
  String name;
  String patronymic;
  String dateOfComplaints;
  String branch;
  String violation;

  get toMap => {
    "surname": surname,
    "name": name,
    "patronymic": patronymic,
    "dateOfComplaints": dateOfComplaints,
    "branch": branch,
    "violation": violation,
  };

  Labor(
      {required this.surname,
      required this.name,
      required this.patronymic,
      required this.dateOfComplaints,
      required this.branch,
      required this.violation});
}
