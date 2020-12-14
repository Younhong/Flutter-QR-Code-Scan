import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_code/model/qr.code.tag.record.model.dart';
import 'package:intl/intl.dart';

  class QRCodeRecordList extends StatefulWidget {
    final String title;
    QRCodeRecordList({this.title});

    _QRCodeRecordListState createState() => _QRCodeRecordListState();
}

class _QRCodeRecordListState extends State<QRCodeRecordList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QRCode 태그 기록 상세보기"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("QRCode")
            .document(widget.title)
            .collection("Record")
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                QRCodeRecordModel record = QRCodeRecordModel.fromDs(snapshot.data.documents[index]);
                DateTime time = record.date.toDate();
                String timeMessage = DateFormat('yyyy-MM-dd kk:mm:ss').format(time);
                return GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "UID: " + record.uid,
                          style: TextStyle(color: Colors.green),),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          timeMessage,
                          style: TextStyle(color: Colors.red),),
                      ),
                      Divider(height: 1)
                    ],
                  ),
                );
              });
          },
      )
    );
  }
}

