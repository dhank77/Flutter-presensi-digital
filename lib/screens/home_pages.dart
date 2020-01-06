import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  String hadir = '10';
  String alfa = '10';
  String token = '';

  @override
  void initState() {
    getPref();
    super.initState();
  }  

  statistik() async{
    print(token);
    var url = "http://192.168.10.10/api/scan";
    final res = await http.get(url,
    headers: {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer " + token,
    });

    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      setState(() {
        hadir = data['data']['hadir'].toString();
        alfa = data['data']['alfa'].toString();
      });
    }
  }

  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
    statistik();
  }


  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Hadir", () => double.parse(hadir));
    dataMap.putIfAbsent("Tidak Hadir", () => double.parse(alfa));
    
    DateTime now = DateTime.now();
    String date = DateFormat("EEEE d MMMM y").format(now);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text("Statistik Kehadiran", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),)
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Text(date),
          ),
          PieChart(
            dataMap: dataMap,
          )
        ],
      ),
    );
  }
}