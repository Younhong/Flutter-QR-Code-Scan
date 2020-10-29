import 'package:cloud_firestore/cloud_firestore.dart';

class QRCode {
  String qrCode;
  Timestamp date;

  QRCode({this.qrCode, this.date});

  QRCode.fromDs(DocumentSnapshot ds) {
    this.qrCode = ds['qrCode'];
    this.date = ds['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrCode,
      'date': date
    };
  }
}
