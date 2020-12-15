import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_code/model/qr.code.model.dart';
import 'package:flutter_qr_code/qr.code.record.list.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeListPage extends StatefulWidget {
  _QRCodeListState createState() => _QRCodeListState();
}

class _QRCodeListState extends State<QRCodeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRCode 태그 기록 조회"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("QRCode").snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                QRCode qrCode = QRCode.fromDs(snapshot.data.documents[index]);
                return GestureDetector(
                  child: Column(
                    children: [
                      QrImage(
                          data: qrCode.qrCode,
                          size: 200
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "ID: " + (index+1).toString(), style: TextStyle(color: Colors.green),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.center,
                        child: Text(
                          "Code: " + qrCode.qrCode, style: TextStyle(color: Colors.red),),
                      ),
                      Divider(height: 1)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeRecordList(
                            title: qrCode.qrCode
                          ),
                        ));
                  },
                );
              });
        },
      )
    );
  }
}

