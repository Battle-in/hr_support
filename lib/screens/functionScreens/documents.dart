import 'package:flutter/material.dart';
import 'package:hr_support/elements/pdf_tile.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';

class DocumentScreen extends StatelessWidget {
  final Store<AppState> store;

  const DocumentScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Нормативно правовые акты')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    List<PdfTileScreen> elements = const <PdfTileScreen>[
      PdfTileScreen(title: 'Перечень законодательных и нормативных актов', pathToPdf: 'assets/Perechen_zakonodatelnykh_i_normativnykh_aktov_2022.pdf'),
      PdfTileScreen(title: 'Политика ООО «Газпром трансгаз Сургут» в области качества, производственной безопасности и охраны окружающей среды', pathToPdf: 'assets/Politika_OOO_Gazprom_transgaz_Surgut_v_oblasti_kachestva_proizvodstvennoi_774_bezopasnosti_i_okhrany_okruzhayuschei_774_sredy.pdf'),
      PdfTileScreen(title: 'Общая информация о проведении СОУТ 2019', pathToPdf: 'assets/Obschaya_informatsia_o_provedenii_SOUT_2019.pdf'),
      PdfTileScreen(title: 'Правила внутреннего трудового распорядка для работников', pathToPdf: 'assets/Pravila_vnutrennego_trudovogo_rasporyadka_dlya_rabotnikov.pdf'),
      PdfTileScreen(title: 'Дополнительная профессиональная программа повышения квалификации', pathToPdf: 'assets/Dopolnitelnaya_professionalnaya_programma_povyshenia_kvalifikatsii.pdf'),
      PdfTileScreen(title: 'Этапы проведения СОУТ', pathToPdf: 'assets/Etapy_provedenia_SOUT.pdf'),

      //Etapy_provedenia_SOUT.pdf
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

//File('assets/Perechen_zakonodatelnykh_i_normativnykh_aktov_2022.pdf')