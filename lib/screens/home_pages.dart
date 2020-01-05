import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Hadir", () => 10);
    dataMap.putIfAbsent("Tidak Hadir", () => 8);
    
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