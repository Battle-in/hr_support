import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/elements/complaint_elem.dart';

import 'package:hr_support/redux/app_state.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Жалоба')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;

    var fields = ['Имя', 'Фамилия', 'Отчество', 'Дата подачи', 'Отделение', 'Жалоба'];
    var controllers = [];
    for(int i = 0; i < fields.length; i++){
      controllers.add(TextEditingController());
    }

    return Center(
      child: SizedBox(
          width: screenSize.width >= 600 ? 600 : null,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: fields.length)),
    );;
  }
}
