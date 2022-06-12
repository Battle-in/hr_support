import 'package:flutter/material.dart';
import 'package:hr_support/redux/actions.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';

import 'package:hr_support/entetis/labor.dart';

class LaborInconsistenciesScreen extends StatelessWidget {
  const LaborInconsistenciesScreen({Key? key, required this.store})
      : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(GetLaborAction());
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Несоответствия нормам труда'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Просмотр несоотвествий',
                  ),
                  Tab(
                    text: 'Составление несоответсвий',
                  )
                ],
              ),
            ),
            body: StoreConnector<AppState, List<Labor>>(
              builder: (context, value) {
                if (store.state.labors == []) {
                  return const TabBarView(children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]);
                } else {
                  return TabBarView(children: [
                    _buildBodyList(context),
                    _buildBodyScreen(context)
                  ]);
                }
              },
              converter: (store) => store.state.labors,
            )));
  }

  Widget _buildBodyScreen(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    const List<String> hints = [
      "Фамилия",
      "Имя",
      "Отчество",
      "Дата жалобы",
      "Субъект жалобы",
      "Жалоба"
    ];
    List<Widget> elements = [];
    List<TextEditingController> controllers = <TextEditingController>[];

    for (var i = 0; i < hints.length; i++) {
      controllers.add(TextEditingController());
      elements.add(TextField(
        controller: controllers[i],
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: hints[i]),
      ));
    }

    elements.add(TextButton(
        onPressed: () => store.dispatch(AddLaborAction(Labor(
          surname: controllers[0].text,
          name: controllers[1].text,
          patronymic: controllers[2].text,
          dateOfComplaints: controllers[3].text,
          branch: controllers[4].text,
          violation: controllers[5].text,
        ))),
        child: const Text('Добавить')));

    return Center(
      child: SizedBox(
        width: screenSize.width >= 600 ? 600 : null,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return elements[index];
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: elements.length),
      ),
    );
  }

  Widget _buildBodyList(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Labor> labors = store.state.labors;
    return Center(
      child: SizedBox(
        width: screenSize.width >= 600 ? 600 : null,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    'Жалоба ${labors[index].surname} ${labors[index].name} ${labors[index].patronymic} на ${labors[index].branch}'),
                subtitle: Text(
                    'дата: ${labors[index].dateOfComplaints}\nЖалоба: "${labors[index].violation}"'),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: labors.length),
      ),
    );
  }
}
