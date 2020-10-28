import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_code/barcode.model.dart';

class BarcodeListPage extends StatefulWidget {
  _BarcodeListState createState() => _BarcodeListState();
}

class _BarcodeListState extends State<BarcodeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("바코드 태그 기록 조회"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Barcode").snapshots(),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                Barcode barcode = Barcode.fromDs(snapshot.data.documents[index]);
                return Column(
                  children: [
                    Text("ID: " + (index+1).toString()),
                    Text("Code: " + barcode.barcode),
                    Text("Date: " + barcode.date.toDate().toString())
                  ],
                );
              });
        },
      )
    );
  }
}

