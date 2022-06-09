import 'package:flutter/material.dart';
import 'package:hr_support/entetis/complaint_entety.dart';

import 'package:hr_support/redux/app_state.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Complaint extends StatelessWidget {
  const Complaint({Key? key, required this.store, required this.complaintPosition}) : super(key: key);
  final Store<AppState> store;
  final int complaintPosition;

  @override
  Widget build(BuildContext context) {
    var complaint = store.state.complaints[complaintPosition];
    return Container(
      child: Row(
        children: [
          Column(children: [
            Text('${complaint.surname} ${complaint.name} ${complaint.patronymic}', style: Theme.of(context).textTheme.headline4,),
            Text(complaint.branch, style: Theme.of(context).textTheme.bodySmall,),
            Text(complaint.dateOfComplaints, style: Theme.of(context).textTheme.bodySmall,)
          ],),

        ],
      ),
    );
  }
}
