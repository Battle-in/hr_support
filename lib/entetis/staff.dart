class Staff {
  String id;
  String name;
  String surname;
  String jobTitle;
  String patronymic;
  String dateOfBirth;
  String clothSize;
  int footSize;
  String phone;

  Staff(
      {required this.id,
      required this.name,
      required this.surname,
      required this.patronymic,
      required this.jobTitle,
      required this.dateOfBirth,
      required this.clothSize,
      required this.footSize,
      required this.phone});

  Map toMap() => {
    'name': name,
    'surname': surname,
    'patronymic': patronymic,
    'jobTitle': jobTitle,
    'dateOfBirth': dateOfBirth,
    'clothSize': clothSize,
    'footSize': footSize,
    'phone': phone,
  };

  @override
  String toString() =>
      'Staff{id: $id, name: $name, surname: $surname, '
          'patronymic: $patronymic, jobTitle: $jobTitle, dateOfBirth: $dateOfBirth, '
          'clothSize: $clothSize, footSize: $footSize, phone: $phone}';
}
