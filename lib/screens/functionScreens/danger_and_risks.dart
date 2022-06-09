import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';

class DangerAndRiskScreen extends StatelessWidget {
  const DangerAndRiskScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Опастности и риски')),
    );
  }
}
