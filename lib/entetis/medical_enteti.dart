class MedExam {
  String name;
  String surname;
  String patronymic;
  String dateOfMed;
  String medForm;

  MedExam(
      {required this.name,
      required this.surname,
      required this.patronymic,
      required this.dateOfMed,
      required this.medForm});

  Map toMap() => {
        'name': name,
        'surname': surname,
        'patronymic': patronymic,
        'dateOfMed': dateOfMed,
        'medForm': medForm
      };

  @override
  String toString() {
    return 'MedExam{name: $name, surname: $surname, patronymic: $patronymic, dateOfMed: $dateOfMed, medForm: $medForm}';
  }
}
