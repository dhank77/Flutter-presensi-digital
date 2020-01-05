import 'package:attendances/screens/login_pages.dart';
import 'package:attendances/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPages extends StatefulWidget {
  @override
  _LogoutPagesState createState() => _LogoutPagesState();
}

class _LogoutPagesState extends State<LogoutPages> {

  logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPages()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
