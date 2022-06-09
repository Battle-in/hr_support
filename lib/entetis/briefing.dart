class Briefing{
  final String name;
  final String surname;
  final String patronymic;
  final String dateOfBriefing;
  final String themeBriefing;

  Map toMap() => {
    'name' : name,
    'surname': surname,
    'patronymic': patronymic,
    'dateOfBriefing' : dateOfBriefing,
    'themeBriefing' : themeBriefing,
  };

  Briefing({required this.name, required this.surname, required this.patronymic,
    required this.dateOfBriefing, required this.themeBriefing});
}