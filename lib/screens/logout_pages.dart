import 'package:attendances/screens/login_pages.dart';
import 'package:attendances/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPages extends StatefulWidget {
  @override
  _LogoutPagesState createState() => _LogoutPagesState();
}

class _LogoutPagesState extends State<LogoutPages> {
  String qrcode = '';


  logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
    pref.remove("nama");
    pref.remove("email");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPages()));
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      qrcode = pref.getString('qrcode');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              version: 6,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              backgroundColor: Colors.amberAccent,
              data: qrcode,
              size: 200,
            ),
            SizedBox(height: 10,),
            Text("Scan Here!", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            ButtonWidget(
              onPressed: (){
                logout();
              },
              title: "Logout",
            )
          ],
        ),
      ),
    );
  }
}
