import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:hr_support/entetis/staff.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/complaint_entety.dart';

import 'package:hr_support/redux/app_state.dart';

class SetMainScreenAction{
  Widget newMainScreen;

  SetMainScreenAction({required this.newMainScreen});
}

class LoginAction{
  String login;
  String password;
  BuildContext context;
  Store<AppState> store;

  LoginAction({
    required this.login,
    required this.password,
    required this.context,
    required this.store,
  });
}

class GetStaffAction{}

class SetStaffAction{
  List<Staff> staff;

  SetStaffAction(this.staff);
}

class AddStaffAction{
  Staff staff;
  BuildContext context;

  AddStaffAction(this.staff, this.context);
}

class GetMedExamAction{}

class SetMedExamAction{
  List<MedExam> newMedExam;

  SetMedExamAction(this.newMedExam);
}

class AddMedExamAction{
  final MedExam newMedExam;

  AddMedExamAction({required this.newMedExam});
}

class GetBriefingsAction{}

class SetBriefingsAction{
  final List<Briefing> newBriefing;

  SetBriefingsAction({required this.newBriefing});
}

class AddBriefingAction{
  Briefing newBriefing;

  AddBriefingAction({required this.newBriefing});
}

class GetComplaintAction{}

class SetComplaintAction{
  List<Complaint> newComplaint;

  SetComplaintAction({required this.newComplaint});
}

class AddComplaintAction{
  Complaint newComplaint;

  AddComplaintAction({required this.newComplaint});
}

class ChangeComplaintStatusAction{
  Complaint updateComplaint;

  ChangeComplaintStatusAction({required this.updateComplaint});
}