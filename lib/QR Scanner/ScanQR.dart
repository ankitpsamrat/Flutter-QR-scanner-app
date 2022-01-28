// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, import_of_legacy_library_into_null_safe, file_names

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQR extends StatefulWidget {
  ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

String qrData = "No data found !";
var data;
bool hasdata = false;

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "ScanQR",
      child: Scaffold(
        appBar: AppBar(
          title: Text("QR Scanner"),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    (qrData),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
                  IconButton(
                      onPressed: hasdata
                          ? () async {
                              if (await canLaunch(qrData)) {
                                await launch(qrData);
                              } else {
                                throw "Could not Launch";
                              }
                            }
                          : null,
                      icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: ((MediaQuery.of(context).size.width) / 2) - 45,
                height: 50,
                child: OutlineButton(
                  focusColor: Colors.red,
                  highlightColor: Colors.blue,
                  hoverColor: Colors.lightBlue[100],
                  splashColor: Colors.blue,
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                  shape: StadiumBorder(),
                  child: Text(
                    "Scan QR",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () async {
                    var option = ScanOptions(autoEnableFlash: true);
                    data = await BarcodeScanner.scan(options: option);
                    setState(() {
                      qrData = data.rawContent.toString();
                      hasdata = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
