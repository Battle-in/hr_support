import 'package:flutter/material.dart';
import 'package:hr_support/screens/functionScreens/conf_tables_screens/briefing_table.dart';

import 'package:redux/redux.dart';

import 'package:hr_support/redux/app_state.dart';

import 'package:hr_support/elements/screen_tile.dart';
import 'conf_tables_screens/med_table.dart';

class ConformityTablesScreen extends StatelessWidget {
  const ConformityTablesScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Графики мероприятий')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    var elements = [
      ScreenTile(title: 'Мед. обследования', where: MedTableScreen(store: store),),
      ScreenTile(title: 'Инструктажи', where: BriefingTableScreen(store: store,))
    ];
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width >= 600 ? 600 : null,
        child: ListView.separated(
            itemBuilder: (context, index){
              return elements[index];
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: elements.length
        ),
      ),
    );
  }
}
