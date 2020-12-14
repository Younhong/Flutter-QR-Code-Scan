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
  String _output = "Empty Scan Code";
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
              Text(
                _output, style: TextStyle(
                  color: Colors.black
              ),),
              didSelectBarcode
                  ? FlatButton(
                child: Text("Save QRCode"),
                onPressed: () {
                  Firestore.instance
                      .collection('QRCode')
                      .document(_output)
                      .setData({'qrCode': _output});
                  DateTime date = Timestamp.now().toDate();
                  Firestore.instance
                      .collection('QRCode')
                      .document(_output)
                      .collection("Record")
                      .document(date.toString())
                      .setData({
                    'uid': uid,
                    'date': date
                  });
                  Navigator.pop(context);
                },
              )
                  : Container(),
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