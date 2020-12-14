import 'package:flutter/material.dart';
import 'package:flutter_qr_code/qr.code.generate.dart';
import 'package:flutter_qr_code/qr.code.list.dart';
import 'package:flutter_qr_code/qr.code.tag.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('QR Code Scanner'),
            ),
            body: ListView(
              children: [
                GestureDetector(
                  child: Text("Scan QR Code"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeTag(),
                        ));
                  },
                ),
                GestureDetector(
                  child: Text("Generate QR Code"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeGenerator(),
                        ));
                  },
                ),
                GestureDetector(
                  child: Text("View All QR Code"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeListPage(),
                        ));
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}