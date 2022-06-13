import 'package:flutter/material.dart';
import 'package:hr_support/screens/home.dart';

import 'package:hr_support/entetis/staff.dart';
import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:hr_support/entetis/briefing.dart';
import 'package:hr_support/entetis/complaint_entety.dart';
import 'package:hr_support/entetis/labor.dart';
import 'package:hr_support/test_data.dart';

import 'app_state.dart';
import 'actions.dart';

AppState reducer(AppState state, dynamic action) => AppState(
    mainScreen: _mainScreenReducer(state, action),
    staff: _staffReducer(state, action),
    medExams: _medExamReducer(state, action),
    briefings: _briefingsReducer(state, action),
    complaints: _complaintsReducer(state, action),
    labors: _laborsReducer(state, action),
    currentQuestion: _currentQuestionReducer(state, action),
    userAnswers: _userAnswersReducer(state, action),
    selectedAnswer: _selectedAnswerReducer(state, action),
);

Widget _mainScreenReducer(AppState state, dynamic action){
  if (action is SetMainScreenAction){
    return action.newMainScreen;
  }
  if (action is LoginAction){
    if (action.login == 'user' && action.password == 'pass'){
      return HomeScreen(store: action.store);
    } else {
      ScaffoldMessenger.of(action.context)
          .showSnackBar(const SnackBar(
          content: Text('Пароль или логин введены не корректно')));
      return state.mainScreen;
    }
  }
  return state.mainScreen;
}

List<Staff> _staffReducer(AppState state, dynamic action){
  if (action is SetStaffAction){
    return action.staff;
  }
  return state.staff;
}

List<MedExam> _medExamReducer(AppState state, dynamic action){
  if (action is SetMedExamAction) {
    return action.newMedExam;
  }
  return state.medExams;
}

List<Briefing> _briefingsReducer(AppState state, dynamic action){
  if(action is SetBriefingsAction){
    return action.newBriefing;
  }

  return state.briefings;
}

List<Complaint> _complaintsReducer(AppState state, dynamic action){
  if(action is SetComplaintAction){
    return action.newComplaint;
  }

  return state.complaints;
}

List<Labor> _laborsReducer(AppState state, dynamic action){
  if(action is SetLaborAction){
    return action.newLabors;
  }

  return state.labors;
}

int _currentQuestionReducer(AppState state, dynamic action){
  if (action is NextQuestionAction){
    if(state.currentQuestion + 1 == questionsData.length){
      return -1;
    } else {
      return state.currentQuestion + 1;
    }
  }

  if(action is CurrentQuestionToStartAction){
    return 0;
  }

  return state.currentQuestion;
}

List<int> _userAnswersReducer(AppState state, dynamic action){
  if(action is NextQuestionAction){
    var tmp = state.userAnswers;
    tmp.add(state.selectedAnswer);
    return tmp;
  }

  if(action is CurrentQuestionToStartAction){
    return [];
  }

  return state.userAnswers;
}

int _selectedAnswerReducer(AppState state, dynamic action){
  if(action is SetSelectedAnswerAction){
    return action.newAnswer;
  }

  if(action is NextQuestionAction){
    return -1;
  }

  return state.selectedAnswer;
}