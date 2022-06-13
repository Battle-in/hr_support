import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hr_support/redux/actions.dart';
import 'package:hr_support/test_data.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';

import 'package:hr_support/elements/test_element.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StaffTestingScreen extends StatelessWidget {
  const StaffTestingScreen({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Тестирование персонала')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: screenSize.width >= 600 ? 600 : null,
          child: StoreConnector<AppState, int>(
            builder: (context, value){
              return value >= 0 ? TestElement(store: store) : _buildResult(context);
            },
            converter: (store) => store.state.currentQuestion,
          ),
        ),
      )
    );
  }

  Widget _buildResult(BuildContext context){
    int res = 0;

    for(int i = 0; i < rightAnswers.length; i++){
      if(rightAnswers[i] == store.state.userAnswers[i]){
        res++;
      }
    }

    print('$res / ${rightAnswers.length}');

    if(res == rightAnswers.length){
      TextEditingController fioController = TextEditingController();

      return Container(
        child: ListView(
          children: [
            Text('Вы правильно ответили на $res из ${rightAnswers.length}', style: Theme.of(context).textTheme.headline4,),
            const Divider(),
            TextField(
              controller: fioController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ФИО'
              ),
            ),
            const Divider(),
            TextButton(onPressed: (){
              store.dispatch(CurrentQuestionToStartAction());
              _printCertificate(context, fioController.text, '$res/${rightAnswers.length}');
            }, child: const Text('Печать удостоверения'))
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Text('Увы, но вы не ответили на все вопросы верно.\nПожалуйста пройдите ещё раз', style: Theme.of(context).textTheme.headline5,),
          const Divider(),
          TextButton(onPressed: () => store.dispatch(CurrentQuestionToStartAction()), child: const Text('Попробовать ещё раз'))
        ],
      );
    }
  }

  void _printCertificate(BuildContext context, String fio, String result){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: PdfPreview(
          build: (format) => _generatePdfBrief(format, fio, result),
        ),
      );
    });
  }


  Future<Uint8List> _generatePdfBrief(PdfPageFormat format, String fio, String result) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text('$fio прошёл тест', style: pw.TextStyle(font: font)),
              pw.Text('C результатом $result', style: pw.TextStyle(font: font)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
