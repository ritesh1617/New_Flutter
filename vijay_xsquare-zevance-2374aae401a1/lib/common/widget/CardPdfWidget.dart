import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class CardPdfWidget extends StatelessWidget {
  Grievance? model;

  CardPdfWidget({Key? key, required Grievance model}) : super(key: key) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var height = 230.0;
  //return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          model!.description!,
          style: regularBlack12,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(height: height,child:  AbsorbPointer(
          child: SfPdfViewer.network(
            model!.attachments![0].url!,
            enableDoubleTapZooming: false,
            canShowPaginationDialog: false,
            canShowScrollHead: false,
            canShowPasswordDialog: false,
          ),
        )),
      ],
    );
    // return FutureBuilder<PDFDocument>(
    //     future:PDFDocument.fromURL(model!.attachments![0].url!),
    //     builder: (context, AsyncSnapshot<PDFDocument> snapshot) {
    //       if (snapshot.hasData) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Text(
    //               model!.description!,
    //               style: regularBlack12,
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             SizedBox(height: height,child: PDFViewer(document: snapshot.data!,enableSwipeNavigation: false,showNavigation: false,showIndicator: false,showPicker: false,)),
    //           ],
    //         );
    //       } else {
    //         return const CircularProgressIndicator();
    //       }
    //     }
    // );

  }
}
