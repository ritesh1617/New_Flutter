
import 'package:flutter/material.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final dynamic _argument;
  const PdfViewerScreen(this._argument,{Key? key}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String url="";

  @override
  void initState() {
    super.initState();
    url=widget._argument as String;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "PDF",
          style: regularBlack18,
        ),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        url,
        enableDoubleTapZooming: false,
        canShowPaginationDialog: false,
        canShowScrollHead: false,
        canShowPasswordDialog: false,
      ),
    );
  }
}
