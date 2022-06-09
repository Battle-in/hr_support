import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/elements/staff_tile.dart';
import 'package:hr_support/entetis/staff.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/actions.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(GetStaffAction());
    return Scaffold(
      appBar: AppBar(title: const Text('Персонал')),
      body: StoreConnector<AppState, List<Staff>>(
        builder: (context, value) {
          if (value == []) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildBody(context, value);
          }
        },
        converter: (store) => store.state.staff,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewStaff(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNewStaff(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          Size screenSize = MediaQuery.of(context).size;

          var hints = [
            'Имя',
            'Фамилия',
            'Отчество',
            'Должность',
            'Моб. номер',
            'Дата рождения',
            'размер одежды',
            'размер обуви'
          ];

          var controllers = [];

          for (int i = 0; i < hints.length; i++) {
            controllers.add(TextEditingController());
          }

          return Dialog(
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: screenSize.width * 0.8,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.8,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: TextField(
                                      controller: controllers[index],
                                      decoration: InputDecoration(
                                          hintText: hints[index],
                                          border: const OutlineInputBorder()),
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: hints.length),
                        ),
                        TextButton(
                            child: const Text('Добавить'),
                            onPressed: (){
                                store.dispatch(AddStaffAction(
                                    Staff(
                                      id: '0',
                                      name: controllers[0].text,
                                      surname: controllers[1].text,
                                      patronymic: controllers[2].text,
                                      jobTitle: controllers[3].text,
                                      phone: controllers[4].text,
                                      dateOfBirth: controllers[5].text,
                                      clothSize: controllers[6].text,
                                      footSize: int.parse(controllers[7].text),
                                    ),
                                    context));
                                Navigator.pop(context);
                            })
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget _buildBody(BuildContext context, List<Staff> staff) {
    var elements = [];
    for (var value in staff) {
      elements.add(
        StaffTile(
          staff: value,
        ),
      );
    }
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width >= 600 ? 600 : null,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return elements[index];
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: elements.length),
      ),
    );
  }
}
