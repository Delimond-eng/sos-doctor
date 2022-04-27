import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_docteur/index.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

showCancellerPdf(BuildContext ctx, {Function onValidated, String title}) async {
  Modal.show(
    ctx,
    height: MediaQuery.of(ctx).size.height,
    width: MediaQuery.of(ctx).size.width,
    title: title ?? "",
    modalContent: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SfPdfViewer.asset("assets/docs/docs.pdf"),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            // ignore: deprecated_member_use
            FlatButton(
              color: Colors.orange,
              child: const Text(
                "Accepter",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: onValidated,
            ),
            const SizedBox(
              width: 10.0,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              color: Colors.grey,
              child: const Text(
                "Annuler",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        )
      ],
    ),
  );
}

class Modal {
  static void show(
    context, {
    Widget modalContent,
    double height,
    double width,
    double radius,
    String title,
  }) {
    showDialog(
        barrierColor: Colors.white10,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.fromLTRB(5, 70, 5, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 5),
            ), //this right here
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 8.0),
                  width: width,
                  height: height,
                  child: modalContent,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radius ?? 5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
