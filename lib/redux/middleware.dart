import 'package:flutter/material.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:redux/redux.dart';

import 'package:hr_support/entetis/staff.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/actions.dart';

import 'package:dio/dio.dart';

void loaderMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher nextDispatcher) {
  if(action is GetStaffAction){
    _getStaffData(store);
  }
  
  if(action is AddStaffAction){
    _addStaff(store, action.staff).then((value) => _getStaffData(store));
  }

  if(action is GetMedExamAction){
    _getMedExam(store);
  }
  
  if(action is AddMedExamAction){
    _addMedExam(store, action.newMedExam).then(
            (value) => _getMedExam(store));
  }

  if(action is GetBriefingsAction){
    _getBriefings(store);
  }

  if(action is AddBriefingAction){
    _addBriefings(store, action).then((value) => _getBriefings(store));
  }

  nextDispatcher(action);
}

Future<void> _addStaff(Store<AppState> store, Staff newStaff) async {
  Dio().put('http://localhost:8025/api/employers/setEmployers/',
      data: newStaff.toMap()).catchError((err){
        print(err);
        return Future(() => null);
  });
}

Future<void> _addBriefings(Store<AppState> store, AddBriefingAction action) async{
  Dio().put('http://localhost:8025/api/table/setEmployersTableBriefing/', data: action.newBriefing.toMap());
}

Future<void> _getBriefings(Store<AppState> store) async{
  Response response = await Dio().get('http://localhost:8025/api/table/getEmployersTableBriefing');
  if (response.statusCode! >= 200 && response.statusCode! <= 220){
    List<Briefing> briefs = <Briefing>[];

    for(int i = 0; i < response.data.length; i++){
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

    print(briefs);

    store.dispatch(SetBriefingsAction(newBriefing: briefs));
  }
}

Future<void> _getStaffData(Store<AppState> store) async {
  Response response = await Dio().get('http://localhost:8025/api/employers/getEmployers/');
  if (response.statusCode! >= 200 && response.statusCode! <= 220){
    List<Staff> staff = <Staff>[];

    for(int i = 0; i < response.data.length; i++){
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
  Response response = await Dio().get('http://localhost:8025/api/table/getEmployersTable');
  if (response.statusCode! >= 200 && response.statusCode! <= 220){
    List<MedExam> medExams = <MedExam>[];

    for(int i = 0; i < response.data.length; i++){
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
  Dio().put('http://localhost:8025/api/table/setEmployersTable', data: medExam.toMap()).then((value) => Future(() => print(value)));
}