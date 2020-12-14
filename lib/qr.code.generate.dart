import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  bool didMakeQRCode = false;
  String uid = "ssss";
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator")
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                autofocus: true,
                autocorrect: false,
                controller: _textController,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black, fontSize: 16.0),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.red,
                  hintText: "바코드를 생성할 텍스트를 입력해주세요",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 16.0),),
              )
          ),

          SizedBox(height: 30),
          FlatButton(
            child: Text("View QRCode"),
            onPressed: () {
              setState(() {
                didMakeQRCode = true;
              });
            },
          ),
          _textController.text != "" ? Container(
            alignment: Alignment.center,
            child: QrImage(
                data: _textController.text,
                size: 200
            ),
          ) : Container(),
          SizedBox(height: 30),
          FlatButton(
            child: Text("Save QRCode"),
            onPressed: () => _textController.text != "" ? {
              Firestore.instance
                  .collection('QRCode')
                  .document(_textController.text)
                  .setData({'qrCode': _textController.text}),
              Firestore.instance
                  .collection('QRCode')
                  .document(_textController.text)
                  .collection("Record")
                  .document(Timestamp.now().toString())
                  .setData({
                'uid': uid,
                'date': Timestamp.now().toDate()
              }),
              Navigator.pop(context)
            } : null,
          )
        ],
      )
    );
  }
}