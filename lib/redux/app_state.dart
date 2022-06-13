import 'package:flutter/material.dart';
import 'package:hr_support/entetis/staff.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/complaint_entety.dart';
import 'package:hr_support/entetis/labor.dart';

class AppState {
  Widget mainScreen = Container();
  List<Staff> staff = [];
  List<MedExam> medExams = [];
  List<Briefing> briefings = [];
  List<Complaint> complaints = [];
  List<Labor> labors = [];
  int currentQuestion = 0;
  List<int> userAnswers = [];
  int selectedAnswer = -1;

  AppState(
      {required this.mainScreen,
      required this.staff,
      required this.medExams,
      required this.briefings,
      required this.complaints,
      required this.labors,
      required this.currentQuestion,
      required this.userAnswers,
      required this.selectedAnswer,
      });
}
