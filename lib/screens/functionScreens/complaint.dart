import 'package:flutter/material.dart';
import 'package:hr_support/redux/actions.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/entetis/complaint_entety.dart';

import 'package:hr_support/redux/app_state.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(GetComplaintAction());
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Проверки'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Проверки'),
                ),
                Tab(
                  child: Text('Отчёт'),
                )
              ],
            ),
          ),
          body: StoreConnector<AppState, List<Complaint>>(
            builder: (context, value) {
              return TabBarView(
                               children: [
                                 _buildSecond(context),
                                 _buildBody(context),
                               ],
                             );
            },
            converter: (store) => store.state.complaints,
          ),
            //
        ));
  }

  Widget _buildSecond(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<Complaint> complaints = store.state.complaints;

    return Center(
        child: SizedBox(
        width: screenSize.width >= 600 ? 600 : null,
        child:ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(complaints[index].validationDate, style: Theme.of(context).textTheme.headline4,),
                  Text(
                      'Колличество нарушений: ${complaints[index].violationCount}'),
                ],
              ),
              Checkbox(
                  value: complaints[index].violationEliminated,
                  onChanged: (a) {store.dispatch(ChangeComplaintStatusAction(updateComplaint: complaints[index]));})
            ],
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: complaints.length)));
  }

  Widget _buildBody(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    var fields = [
      'Дата жалобы',
      'Колличество ошибок'
    ];

    var controllers = [];
    List<Widget> elms = <Widget>[];

    for (int i = 0; i < fields.length; i++) {
      controllers.add(TextEditingController());
      elms.add(TextField(
        controller: controllers[i],
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: fields[i]),
      ));
    }

    elms.add(TextButton(
        onPressed: () => store.dispatch(AddComplaintAction(
            newComplaint: Complaint(
                validationDate: controllers[0].text,
                violationCount: int.parse(controllers[1].text),
                violationEliminated: false,
                userId: 'null'
            ))),
        child: const Text('Добавить')));

    return Center(
      child: SizedBox(
          width: screenSize.width >= 600 ? 600 : null,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return elms[index];
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: fields.length + 1)),
    );
  }
}
