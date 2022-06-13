import 'package:flutter/material.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/complaint_entety.dart';
import 'package:hr_support/entetis/labor.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:redux/redux.dart';

import 'package:hr_support/entetis/staff.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/actions.dart';

import 'package:dio/dio.dart';

void loaderMiddleware(Store<AppState> store, dynamic action,
    NextDispatcher nextDispatcher) {
  if (action is GetStaffAction) {
    _getStaffData(store);
  }

  if (action is AddStaffAction) {
    _addStaff(store, action.staff).then((value) => _getStaffData(store));
  }

  if (action is GetMedExamAction) {
    _getMedExam(store);
  }

  if (action is AddMedExamAction) {
    _addMedExam(store, action.newMedExam);
  }

  if (action is GetBriefingsAction) {
    _getBriefings(store);
  }

  if (action is AddBriefingAction) {
    _addBriefings(store, action);
  }

  if (action is GetComplaintAction) {
    _getComplaint(store);
  }

  if (action is AddComplaintAction) {
    _addComplaint(store, action);
  }

  if (action is ChangeComplaintStatusAction) {
    _updateComplaint(store, action);
  }

  if (action is GetLaborAction) {
    _getLabor(store);
  }

  if(action is AddLaborAction){
    _addLabor(store, action);
  }

  nextDispatcher(action);
}

Future<void> _addStaff(Store<AppState> store, Staff newStaff) async {
  Dio().put('http://localhost:8025/api/employers/setEmployers/',
      data: newStaff.toMap());
}

Future<void> _addBriefings(Store<AppState> store,
    AddBriefingAction action) async {
  Dio().put('http://localhost:8025/api/table/setEmployersTableBriefing/',
      data: action.newBriefing.toMap());
  _getBriefings(store);
}

Future<void> _getBriefings(Store<AppState> store) async {
  Response response = await Dio().get(
      'http://localhost:8025/api/table/getEmployersTableBriefing');
  if (response.statusCode! >= 200 && response.statusCode! <= 220) {
    List<Briefing> briefs = <Briefing>[];

    for (int i = 0; i < response.data.length; i++) {
      briefs.add(
          Briefing(
              name: response.data[i]['name'],
              surname: response.data[i]['surname'],
              patronymic: response.data[i]['patronymic'],
              dateOfBriefing: response.data[i]['dateOfBriefing'],
              themeBriefing: response.data[i]['themeBriefing']
          )
      );
    }

    store.dispatch(SetBriefingsAction(newBriefing: briefs));
  }
}

Future<void> _getStaffData(Store<AppState> store) async {
  Response response = await Dio().get(
      'http://localhost:8025/api/employers/getEmployers/');
  if (response.statusCode! >= 200 && response.statusCode! <= 220) {
    List<Staff> staff = <Staff>[];

    for (int i = 0; i < response.data.length; i++) {
      staff.add(
          Staff(
              id: response.data[i]['_id'],
              name: response.data[i]['name'],
              surname: response.data[i]['surname'],
              patronymic: response.data[i]['patronymic'],
              jobTitle: response.data[i]['jobTitle'],
              dateOfBirth: response.data[i]['dateOfBirth'],
              clothSize: response.data[i]['clothSize'],
              footSize: response.data[i]['footSize'],
              phone: response.data[i]['phone']
          )
      );
    }

    store.dispatch(SetStaffAction(staff));
  }
}

Future<void> _getMedExam(Store<AppState> store) async {
  Response response = await Dio().get(
      'http://localhost:8025/api/table/getEmployersTable');
  if (response.statusCode! >= 200 && response.statusCode! <= 220) {
    List<MedExam> medExams = <MedExam>[];

    for (int i = 0; i < response.data.length; i++) {
      medExams.add(
          MedExam(
              name: response.data[i]['name'],
              surname: response.data[i]['surname'],
              patronymic: response.data[i]['patronymic'],
              dateOfMed: response.data[i]['dateOfMed'],
              medForm: response.data[i]['medForm']
          ));
    }

    store.dispatch(SetMedExamAction(medExams));
  }
}

Future<void> _addMedExam(Store<AppState> store, MedExam medExam) async {
  Dio().put('http://localhost:8025/api/table/setEmployersTable',
      data: medExam.toMap()).then((value) => _getMedExam(store));
}

Future<void> _getComplaint(Store<AppState> store) async {
  Response response = await Dio().get(
      'http://localhost:8025/api/validation/getEmployers/');

  List<Complaint> complaints = <Complaint>[];
  for (int i = 0; i < response.data.length; i++) {
    complaints.add(Complaint(
        validationDate: response.data[i]['validationDate'],
        violationCount: response.data[i]['violationCount'],
        violationEliminated: response.data[i]['violationEliminated'],
        userId: response.data[i]['_id']
    ));
  }

  store.dispatch(SetComplaintAction(newComplaint: complaints));
}

Future<void> _addComplaint(Store<AppState> store,
    AddComplaintAction action) async {
  Dio().put('http://localhost:8025/api/validation/setEmployers/',
      data: action.newComplaint.toMap()).then((value) =>
      store.dispatch(GetComplaintAction()));
}

Future<void> _updateComplaint(Store<AppState> store,
    ChangeComplaintStatusAction action) async {
  Dio().post('http://localhost:8025/api/validation/updateEmployers/',
      data: action.updateComplaint.toUpdate()).then((value) =>
      store.dispatch(GetComplaintAction()));
}

void _getLabor(Store<AppState> store) async {
  Response response = await Dio().get('http://localhost:8025/api/form/getForm');

  List<Labor> newLabors = <Labor>[];

  for (int i = 0; i < response.data.length; i++) {
    newLabors.add(Labor(surname: response.data[i]['surname'],
        name: response.data[i]['name'],
        patronymic: response.data[i]['patronymic'],
        dateOfComplaints: response.data[i]['dateOfComplaints'],
        branch: response.data[i]['branch'],
        violation: response.data[i]['violation']));
  }

  store.dispatch(SetLaborAction(newLabors: newLabors));
}

Future<void> _addLabor(Store<AppState> store, AddLaborAction action) async {
  Dio().put('http://localhost:8025/api/form/setForm', data: action.newLabor.toMap).then((value) => store.dispatch(GetLaborAction()));
}