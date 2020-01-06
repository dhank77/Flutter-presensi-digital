import 'dart:async';
import 'package:attendances/providers/provider_timer.dart';
import 'package:attendances/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScanPages extends StatefulWidget {
  @override
  _ScanPagesState createState() => _ScanPagesState();
}

class _ScanPagesState extends State<ScanPages> {
  String scan = "Result Scan";
  String token = '';
  String time = '00:00:00';
  String now = '';
  Timer timer;
  bool _isMasuk;
  ProviderTimer providerTimer = new ProviderTimer();

  scanQR() async {
    String scanResult = await Scanner.scan();
    setState(() {
      scan = scanResult;
    });
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
  }

  sendData() async {
    var url = "http://192.168.10.10/api/scan";
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer ' + token
    }, body: {
      'qrcode': scan,
      'in': _isMasuk ? time : "",
      'out': !_isMasuk ? time : "",
    });

    if (response.statusCode == 200) {
      print("sukses");
    } else {
      print("gagal");
    }
  }

  @override
  void initState() {

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  getTime() {
    DateTime now = DateTime.now();
    String formatTime = _formatTime(now);
    // providerTimer.timer = formatTime;
    setState(() {
      time = formatTime;
    });
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE d MMMM y').format(dateTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatDate = _formatDate(now);

    return ChangeNotifierProvider<ProviderTimer>(
      create: (context) => ProviderTimer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<ProviderTimer>(
            builder: (context, providerTimer, child) => Text(
              time,
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            
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
                  scanQR();
                  _isMasuk = true;
                },
              ),
              SizedBox(
                width: 10,
              ),
              ButtonWidget(
                title: "Pulang",
                onPressed: () {
                  scanQR();
                  _isMasuk = false;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
