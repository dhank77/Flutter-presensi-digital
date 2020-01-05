import 'package:attendances/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:http/http.dart' as http;

DateTime now = DateTime.now();
String formatDate = DateFormat("EEEE d MMMM y").format(now);
String formatTime = DateFormat("HH:mm:ss").format(now);

class ScanPages extends StatefulWidget {
  @override
  _ScanPagesState createState() => _ScanPagesState();
}

class _ScanPagesState extends State<ScanPages> {
  String scan = "Result Scan";
  String keterangan = '';

  scanQR(bool masuk) async {
    String scanResult = await Scanner.scan();
    setState(() {
      scan = scanResult;
      masuk == true ? keterangan = "masuk" : keterangan = "pulang" ;
    });
  }

  sendData() async{
    var url = "http://192.168.10.10/api/scan";
    var response = await http.post(url, body:{
      // 'qr' : 
      'in' : keterangan == "masuk" ? formatTime : "",
      'out' : keterangan == "pulang" ? formatTime : "",
      'date' : formatDate,
    });

    if(response.statusCode == 200){
      print("sukses");
    }else{
      print("gagal");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          formatTime,
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          formatDate,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text("Pilih Jenis Absensi"),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonWidget(
              title: "Masuk",
              onPressed: () {
                scanQR(true);
              },
            ),
            SizedBox(
              width: 10,
            ),
            ButtonWidget(
              title: "Pulang",
              onPressed: () {
                scanQR(false);
              },
            ),
          ],
        )
      ],
    );
  }
}
