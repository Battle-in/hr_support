import 'package:flutter/material.dart';
import 'package:hr_support/entetis/briefing.dart';

import 'package:hr_support/entetis/medical_enteti.dart';
import 'package:hr_support/redux/actions.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/actions.dart';

class BriefingTableScreen extends StatelessWidget {
  const BriefingTableScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(GetBriefingsAction());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инструктажи'),
      ),
      body: StoreConnector<AppState, List<Briefing>>(
        builder: (context, value){
          if (value == []){
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildBody(context);
          }
        },
        converter: (store) => store.state.briefings,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addBriefing(context),
      ),
    );
  }

  void _addBriefing(BuildContext context){
    showDialog(context: context, builder: (context){
      List<String> names = [
        'Имя', 'Фамилия', 'Отчество', 'Дата проведения', 'Вид'
      ];
      var controllers = [];

      for(int i = 0; i < names.length; i++){
        controllers.add(TextEditingController());
      }

      return Dialog(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return SizedBox(
                        width: 300,
                        height: 50,
                        child: TextField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                              hintText: names[index],
                              border: const OutlineInputBorder()),
                        ));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: names.length
              ),
            ),
            TextButton(onPressed: (){
              store.dispatch(
                  AddBriefingAction(newBriefing: Briefing(
                      name: controllers[0].text,
                      surname: controllers[1].text,
                      patronymic: controllers[2].text,
                      dateOfBriefing: controllers[3].text,
                      themeBriefing: controllers[4].text)));
              Navigator.pop(context);
            }
                , child: const Text('Добавить'))
          ],
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context){
    List<DataRow> rows = <DataRow>[];
    for (Briefing brief in store.state.briefings){
      rows.add(DataRow(cells: [
        DataCell(Text('${brief.surname} ${brief.name} ${brief.patronymic}')),
        DataCell(Text(brief.dateOfBriefing)),
        DataCell(Text(brief.themeBriefing))
      ]));
    }
    return ListView(
      children: [
        DataTable(
            columns: const [
              DataColumn(label: Text('ФИО')),
              DataColumn(label: Text('Дата проведения')),
              DataColumn(label: Text('Вид'))
            ],
            rows: rows)
      ],
    );
  }
}
