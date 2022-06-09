import 'package:flutter/material.dart';
import 'package:hr_support/entetis/staff.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/complaint_entety.dart';

class AppState{
  Widget mainScreen = Container();
  List<Staff> staff = [];
  List<MedExam> medExams = [];
  List<Briefing> briefings = [];
  List<Complaint> complaints = [];

  AppState({required this.mainScreen, required this.staff,
    required this.medExams, required this.briefings, required this.complaints});
}