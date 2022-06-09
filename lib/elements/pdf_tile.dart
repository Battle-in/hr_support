import 'dart:io';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class PdfTileScreen extends StatelessWidget {
  const PdfTileScreen({Key? key, required this.title, required this.pathToPdf}) : super(key: key);

  final String title;
  final String pathToPdf;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){readPdfFile(pathToPdf);},
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  Future<void> readPdfFile(String fileName) async {
    await launchUrl(Uri.parse(
        'file:///${Directory.current.path.toString()}/$fileName'));
  }
}