import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_code/barcode.list.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool didSelectBarcode = false;
  String _output = "Empty Scan Code";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
              centerTitle: true,
              title: Text('QR Code Scanner'),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.list_alt),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BarcodeListPage(),
                          ));
                    })
              ]
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
                      child: Text("Save"),
                      onPressed: () => {
                        showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return _createAlertDialog(context);
                        }),
                        Firestore.instance
                            .collection('Barcode')
                            .document()
                            .setData({'barcode': _output, 'date': Timestamp.now().toDate()})
                      })
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
        ),
      )
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();

    setState(() {
      didSelectBarcode = true;
      _output = barcode;
    });
  }

  Widget _createAlertDialog(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      content: SingleChildScrollView(
        child: Text(
          "Saved Barcode Scan Data",
          style: TextStyle(height: 1.4, fontSize: 15.0),
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.deepOrange,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 0.0),
      ],
    );
  }
}