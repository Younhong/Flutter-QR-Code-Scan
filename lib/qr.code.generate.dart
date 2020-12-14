import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  bool didMakeQRCode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator")
      ),
      body: ListView(
        children: [
          Text("Enter Text"),
          didMakeQRCode ? Container(
            child: QrImage(
                data: "https://www.github.com",
                size: 200
            ),
          ) : Container(),
          GestureDetector(
            child: Text("Save QRCode"),
            onTap: () {
              didMakeQRCode = !didMakeQRCode;
              print(didMakeQRCode);
            },
          )
        ],
      )
    );
  }
}