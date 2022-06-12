import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:hr_support/redux/app_state.dart';

class ReportingFormScreen extends StatelessWidget {
  const ReportingFormScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Отчетные формы')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;

    TextEditingController firstTextController = TextEditingController();
    TextEditingController secondTextController = TextEditingController();
    TextEditingController thirdTextController = TextEditingController();

    const Widget divider = Divider();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: screenSize.width >= 600 ? 600 : null,
        child: ListView(
          children: [
            TextField(
              controller: firstTextController,
              decoration: const InputDecoration(hintText: 'ФИО сотрудника', border: OutlineInputBorder()),
            ),
            divider,
            TextField(
              controller: secondTextController,
              decoration: const InputDecoration(hintText: 'ФИО выдающего отчётную форму', border: OutlineInputBorder()),
            ),
            divider,
            TextField(
              controller: thirdTextController,
              decoration: const InputDecoration(hintText: 'Тип СИЗ / Тема инструктажа', border: OutlineInputBorder()),
            ),
            divider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () => _printSIZ(context, firstTextController.text, secondTextController.text, thirdTextController.text), child: const Text('Выдача СИЗ')),
                TextButton(onPressed: () => _printBrief(context, firstTextController.text, secondTextController.text, thirdTextController.text), child: const Text('Прохождение инструктажа'))
              ],
            )
          ]
        ),
      ),
    );
  }

  void _printSIZ(BuildContext context, String staffFio, String senderFio, String sizType){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: PdfPreview(
          build: (format) => _generatePdfSIZ(format, 'Siz_for_$staffFio' ,staffFio, senderFio, sizType),
        ),
      );
    });
  }

  Future<Uint8List> _generatePdfSIZ(PdfPageFormat format, String title, String staffFio, String senderFio, String sizType) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text('Выдано $sizType', style: pw.TextStyle(font: font)),
              pw.Text('Кем - $senderFio подпись: _______', style: pw.TextStyle(font: font)),
              pw.Text('Кому - $staffFio подпись: _______', style: pw.TextStyle(font: font)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  void _printBrief(BuildContext context, String staffFio, String senderFio, String briefTheme){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: PdfPreview(
          build: (format) => _generatePdfBrief(format, 'Siz_for_$staffFio' ,staffFio, senderFio, briefTheme),
        ),
      );
    });
  }

  Future<Uint8List> _generatePdfBrief(PdfPageFormat format, String title, String staffFio, String senderFio, String briefTheme) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text('Проведён инструктаж на тему: $briefTheme', style: pw.TextStyle(font: font)),
              pw.Text('Кем - $senderFio подпись: _______', style: pw.TextStyle(font: font)),
              pw.Text('Кому - $staffFio подпись: _______', style: pw.TextStyle(font: font)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
