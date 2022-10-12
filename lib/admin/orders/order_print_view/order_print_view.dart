import 'dart:developer';
import 'dart:typed_data';

import 'package:citymall/colors/colors.dart';
import 'package:citymall/colors/hexandcolor.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/cart_product.dart';
import 'package:citymall/model/purchase.dart';
import 'package:flutter/material.dart' hide TableRow;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import '../../../constant/constant.dart';

class UserOrderPrintView extends StatefulWidget {
  final Purchase purchaseModel;
  final int total;
  final int shipping;
  final String township;
  const UserOrderPrintView({
    Key? key,
    required this.purchaseModel,
    required this.total,
    required this.shipping,
    required this.township,
  }) : super(key: key);

  @override
  State<UserOrderPrintView> createState() => _UserOrderPrintViewState();
}

class _UserOrderPrintViewState extends State<UserOrderPrintView> {
  //Uint8List? imageUnitBytes;

  @override
  void initState() {
    // makePdfPage();
    super.initState();
  }

  Future<Uint8List> makePdfPage(PdfPageFormat format) async {
    final DBDataController controller = Get.find();
    pw.Document doc = pw.Document();
    var oleBold = pw.Font.ttf(controller.oleoBold);
    //var robotoBold = pw.Font.ttf(_controller.robotoBold);
    var cherryUnicode = pw.Font.ttf(controller.cherryUnicode);
    final byte = await rootBundle.load('assets/images/logo.png');
    final image = pw.MemoryImage(byte.buffer.asUint8List());
    doc.addPage(
      pw.Page(
        orientation: pw.PageOrientation.portrait,
        pageFormat: format,
        build: (pw.Context context) {
          return pw.ListView(children: [
            pw.SizedBox(height: 5),
            pw.Image(image, width: 80, height: 80),
            // pw.Text("Hammies Mandalian",
            //     style: const pw.TextStyle(
            //       fontSize: 8,
            //     )),
            pw.SizedBox(height: 5),

            pw.Text("CITYMALL",
                style: const pw.TextStyle(
                  fontSize: 8,
                )),

            pw.SizedBox(height: 5),

            pw.Text("09 123456789",
                style: const pw.TextStyle(
                  fontSize: 8,
                )),
            // pw.SizedBox(height: 5),
            // pw.Text("Phone: 099 7511 4498",
            //     style: const pw.TextStyle(
            //       fontSize: 8,
            //     )),
            // pw.SizedBox(height: 5),
            // pw.Text("Email: hammiesmandalian@gmail.com",
            //     style: const pw.TextStyle(
            //       fontSize: 8,
            //     )),
            pw.SizedBox(height: 8),
            pw.Divider(
              borderStyle: pw.BorderStyle.solid,
            ),
            pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.SizedBox(width: 2),
                        pw.Text("Item",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: cherryUnicode,
                              fontSize: 8,
                            )),
                        pw.Text("Color,Size",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: cherryUnicode,
                              fontSize: 8,
                            )),
                        pw.Text("Qty",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: cherryUnicode,
                              fontSize: 8,
                            )),
                        pw.Text("Price",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: cherryUnicode,
                              fontSize: 8,
                            )),
                        pw.Text("Total",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: cherryUnicode,
                              fontSize: 8,
                            )),
                      ]),
                  for (var item in widget.purchaseModel.items) ...[
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.full,
                      children: [
                        pw.SizedBox(width: 10),
                        //Name
                        pw.Expanded(
                            child: pw.Text(
                          item.name,
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            font: cherryUnicode,
                            fontSize: 8,
                          ),
                        )),
                        //Color,Size
                        pw.Expanded(
                            child: pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 15),
                                child: pw.Text(
                                  "${getColor(item.color ?? "")}-${item.size ?? ""}",
                                  textAlign: pw.TextAlign.left,
                                  style: pw.TextStyle(
                                    font: cherryUnicode,
                                    fontSize: 8,
                                  ),
                                ))),
                        //Count
                        pw.Expanded(
                          child: pw.Text(
                            "${item.count}",
                            overflow: pw.TextOverflow.clip,
                            maxLines: 1,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              font: cherryUnicode,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        //Price
                        pw.Expanded(
                            child: pw.Text(
                          "${item.lastPrice} Ks",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: cherryUnicode,
                            fontSize: 8,
                          ),
                        )),
                        pw.Expanded(
                            child: pw.Text(
                          "${item.lastPrice * item.count} Ks",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: cherryUnicode,
                            fontSize: 8,
                          ),
                        )),
                      ],
                    ),
                  ],
                ]),
            pw.Divider(
              borderStyle: pw.BorderStyle.solid,
            ),
            pw.Table(children: [
              pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Expanded(
                    child: pw.Text("Total",
                        overflow: pw.TextOverflow.clip,
                        maxLines: 1,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8,
                        )),
                  ),
                  pw.Expanded(
                    child: pw.Text(""),
                  ),
                  pw.Expanded(
                    child: pw.Text(""),
                  ),
                  //Total
                  pw.Expanded(
                    child: pw.Text("${widget.total} Ks",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 8,
                        )),
                  ),
                ],
              ),
            ]),
            pw.Divider(
              borderStyle: pw.BorderStyle.solid,
            ),
            pw.SizedBox(
              //height: 50,
              child: pw.Row(children: [
                pw.Expanded(child: pw.Text("")),
                //Delivery Fees Ks
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 20),
                  child: pw.Text(
                    "Delivery Fees:  ${widget.shipping} Ks",
                    textAlign: pw.TextAlign.right,
                    style: const pw.TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ),
              ]),
            ),

            pw.SizedBox(height: 10),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  //Name
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.SizedBox(width: 10),
                        // pw.Text("Name: "),
                        pw.Text(
                          widget.purchaseModel.personalAddress.fullName,
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        pw.SizedBox(width: 50),
                        pw.Text(
                          "${widget.purchaseModel.personalAddress.phoneNumber}",
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ]),

                  pw.SizedBox(width: 10, height: 10),

                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.SizedBox(width: 10),
                        // pw.Text("Name: "),
                        pw.Text(
                          widget.purchaseModel.personalAddress.addressType == 0
                              ? "Home Address"
                              : "Office Address",
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        pw.SizedBox(width: 50),
                        pw.Text(
                          widget.purchaseModel.personalAddress.address,
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ]),
                ]),
            pw.SizedBox(height: 10),
            //Thank
            pw.Text("Thank you!",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  font: oleBold,
                  fontSize: 8,
                )),
            pw.SizedBox(height: 10),
            pw.Text(
              DateFormat("EEEE, dd MMM y kk:mm").format(DateTime.now()),
              textAlign: pw.TextAlign.center,
              style: const pw.TextStyle(
                fontSize: 8,
              ),
            ),
          ]);
        },
      ),
    );

    return doc.save();
    // getImageUnitBytes(doc).then((value){
    //   setState(() {
    //     imageUnitBytes = value;
    //   });
    // });
  }

  String getColor(String hexColor) {
    switch (hexColor) {
      case red:
        return "Red";
      case lime:
        return "Lime";
      case blue:
        return "Blue";
      case purple:
        return "Purple";
      case magenta:
        return "Magenta";
      case yellow:
        return "Yellow";
      case olive:
        return "Olive";
      case black:
        return "Black";
      case grey:
        return "Grey";
      case white:
        return "White";
      case cyan:
        return "Cyan";
      case sliver:
        return "Sliver";
      case maroon:
        return "Maroon";
      case teal:
        return "Teal";
      case navy:
        return "Navy";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorResources.blue1),
        title: const Text(
          "Print Order",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              wordSpacing: 2,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: PdfPreview(
        allowSharing: false,
        canDebug: false,
        canChangeOrientation: false,
        pageFormats: const <String, PdfPageFormat>{
          "a5": PdfPageFormat.a5,
          "55mm": PdfPageFormat(55 * mm, 100 * mm),
          "80mm": PdfPageFormat(80 * mm, 150 * mm),
        },
        build: (format) {
          return makePdfPage(format);
        },
      ),
    );
  }
}
