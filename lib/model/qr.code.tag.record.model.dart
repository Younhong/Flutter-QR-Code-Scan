import 'package:cloud_firestore/cloud_firestore.dart';

class QRCodeRecordModel {
  String uid;
  Timestamp date;

  QRCodeRecordModel({this.uid, this.date});

  QRCodeRecordModel.fromDs(DocumentSnapshot ds) {
    this.uid = ds['uid'];
    this.date = ds['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'date': date
    };
  }
}
