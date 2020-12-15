import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRCodeTag extends StatefulWidget {
  @override
  _QRCodeTagState createState() => _QRCodeTagState();
}

class _QRCodeTagState extends State<QRCodeTag> {
  bool didSelectBarcode = false;
  String _output = "";
  String uid = "ssss";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Code Scanner'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Text(
                  "Scanned Barcode", style: TextStyle(
                    color: Colors.red,
                    fontSize: 30
                ),),
              ),
              didSelectBarcode
                  ? Container(
                padding: EdgeInsets.only(top: 20, bottom: 70),
                child: Text(
                  _output, style: TextStyle(
                    color: Colors.black
                ),),
              ): Container(
                padding: EdgeInsets.only(top: 20, bottom: 70),
                child: Text(
                  "Empty Result", style: TextStyle(
                    color: Colors.black
                ),),
              ),
              FlatButton(
                child: Text("Save QRCode", style: TextStyle(
                  fontSize: 20
                ),),
                onPressed: () => didSelectBarcode ? {
                  Firestore.instance
                      .collection('QRCode')
                      .document(_output)
                      .setData({'qrCode': _output}),
                  Firestore.instance
                      .collection('QRCode')
                      .document(_output)
                      .collection("Record")
                      .document(Timestamp.now().toDate().toString())
                      .setData({
                    'uid': uid,
                    'date': Timestamp.now().toDate()
                  }),
                  Navigator.pop(context)
                } : null,
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
          tooltip: 'scan',
          child: const Icon(Icons.camera_alt)
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();

    setState(() {
      didSelectBarcode = true;
      _output = barcode;
    });
  }
}