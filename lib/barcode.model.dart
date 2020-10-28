import 'package:cloud_firestore/cloud_firestore.dart';

class Barcode {
  String barcode;
  Timestamp date;

  Barcode({this.barcode, this.date});

  Barcode.fromDs(DocumentSnapshot ds) {
    this.barcode = ds['barcode'];
    this.date = ds['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'date': date
    };
  }
}
