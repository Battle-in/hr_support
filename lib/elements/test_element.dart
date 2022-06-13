import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hr_support/redux/actions.dart';
import 'package:hr_support/test_data.dart';
import 'package:redux/redux.dart';

import 'package:hr_support/redux/app_state.dart';

import 'package:hr_support/elements/test_element.dart';

class TestElement extends StatelessWidget {
  const TestElement({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    List<Widget> answers = [];

    answers.add(Text(questionsData[store.state.currentQuestion], style: Theme.of(context).textTheme.headline6,));
    answers.add(const Divider());

    for(int i = 0; i < answersData[store.state.currentQuestion].length; i++){
      answers.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(answersData[store.state.currentQuestion][i]),
              Checkbox(value: store.state.selectedAnswer == i, onChanged: (a){store.dispatch(SetSelectedAnswerAction(newAnswer: i));})
            ],));
      answers.add(const Divider());
    }

    answers.add(
        TextButton(onPressed: () => store.dispatch(NextQuestionAction()), child: const Text('Далее'))
    );

    return Container(
      child: Column(
        children: answers,
      ),
    );
  }
}

