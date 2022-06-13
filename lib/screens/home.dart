import 'package:flutter/material.dart';

import 'package:redux/redux.dart';

import 'package:hr_support/screens/functionScreens/complaint.dart';
import 'package:hr_support/screens/functionScreens/conformity_tables.dart';
import 'package:hr_support/screens/functionScreens/danger_and_risks.dart';
import 'package:hr_support/screens/functionScreens/documents.dart';
import 'package:hr_support/screens/functionScreens/labor_inconsistencies.dart';
import 'package:hr_support/screens/functionScreens/reporting_form.dart';
import 'package:hr_support/screens/functionScreens/staff.dart';
import 'package:hr_support/screens/functionScreens/staff_testing.dart';
import 'package:hr_support/screens/functionScreens/working_conditions.dart';

import 'package:hr_support/elements/screen_tile.dart';

import 'package:hr_support/redux/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Домашняя страница'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<ScreenTile> screenTiles = <ScreenTile>[
      ScreenTile(
          title: 'Нормативно-правовые документы по охране труда', where: DocumentScreen(store: store,)),
      ScreenTile(title: 'Сотрудники', where: StaffScreen(store: store,),),
      ScreenTile(title: 'Таблицы соответствий', where: ConformityTablesScreen(store: store,),),
      ScreenTile(title: 'Отправить жалобу', where: ComplaintScreen(store: store,),),
      ScreenTile(title: 'Условия труда', where: WorkingConditionsScreen(store: store,),),
      ScreenTile(title: 'Опастности и риски', where: DangerAndRiskScreen(store: store,),),
      ScreenTile(title: 'Отчетные формы', where: ReportingFormScreen(store: store,),),
      ScreenTile(title: 'Несоответствия норм труда', where: LaborInconsistenciesScreen(store: store,),),
      ScreenTile(title: 'Тесирование персонала', where: StaffTestingScreen(store: store,),)
    ];
    return Center(
      child: SizedBox(
          width: screenSize.width >= 600 ? 600 : null,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return screenTiles[index];
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: screenTiles.length)),
    );
  }
}


