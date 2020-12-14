import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  bool didMakeQRCode = false;
  String qrInput = "younhong@kakao.com";
  String uid = "ssss";

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
          Text("Enter Text to Create QR Code"),
          FlatButton(
            child: Text("View QRCode"),
            onPressed: () {
              setState(() {
                didMakeQRCode = !didMakeQRCode;
              });
            },
          ),
          didMakeQRCode ? Container(
            child: QrImage(
                data: qrInput,
                size: 200
            ),
          ) : Container(),
          FlatButton(
            child: Text("Save QRCode"),
            onPressed: () {
              Firestore.instance
                  .collection('QRCode')
                  .document(qrInput)
                  .setData({'qrCode': qrInput});
              DateTime date = Timestamp.now().toDate();
              Firestore.instance
                  .collection('QRCode')
                  .document(qrInput)
                  .collection("Record")
                  .document(date.toString())
                  .setData({
                'uid': uid,
                'date': date
              });
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}