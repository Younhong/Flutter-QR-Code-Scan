import 'package:cloud_firestore/cloud_firestore.dart';

class QRCode {
  String qrCode;

  QRCode({this.qrCode});

  QRCode.fromDs(DocumentSnapshot ds) {
    this.qrCode = ds['qrCode'];
  }

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrCode
    };
  }
}
