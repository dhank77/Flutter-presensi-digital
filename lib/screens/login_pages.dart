import 'dart:convert';
import 'package:attendances/screens/tabbar_pages.dart';
import 'package:attendances/screens/user_pages.dart';
import 'package:attendances/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPages extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  String email, name, password, token;
  final _key = GlobalKey<FormState>();
  bool autoValidate = false;
  bool isLoading = false;

  @override
  void initState() {
    getPref();
    super.initState();
  }

  check(){
    final form = _key.currentState;
    if(form.validate()){
      form.save();
      print("email : $email, password: $password");
      login();
    }else{
      autoValidate = true;
    }
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://192.168.10.10/api/login";
    final response = await http
        .post(url, body: {'email': email, 'password': password});
    var res = jsonDecode(response.body);
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      savePref(res['data']['original']['token'], email, res['user']['nama'], res['user']['qrcode']);
      if(res['user']['status'] == '1'){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => TabbarPages()
        ));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => UserPages()
        ));
      }
    } else {
      print("Email atau password tidak benar!");
    }
  }

  savePref(String token, String email, String name, String qrcode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('token', token);
      pref.setString('email', email);
      pref.setString('name', name);
      pref.setString('qrcode', qrcode);
    });
  }

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');

    if (token != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TabbarPages()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.amberAccent[100],
      body: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.8),
            child: Center(
              child: Text(
                "Dev by Hamdani Ilham",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15, left: 10, right: 10),
                child: Form(
                  key: _key,
                  autovalidate: autoValidate,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40,),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.cloud_done,
                              color: Colors.white,
                              size: 40,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.amber),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Presensi Digital",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextFormField(
                              onSaved: (data) => email = data ,
                              autovalidate: autoValidate,
                              validator: (input){
                                if(input.isEmpty){
                                  return "Email tidak boleh kosong";
                                }
                                if(!input.contains('@')){
                                  return "Email tidak valid";
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: "Email"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: TextFormField(
                              onSaved: (data) => password = data ,
                              autovalidate: autoValidate,
                              validator: (input){
                                if(input.isEmpty){
                                  return "Password tidak boleh kosong";
                                }
                                if(input.length < 8){
                                  return "Minimal 8 karakter";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(labelText: "Password"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 30, top: 10),
                                child: ButtonWidget(
                                  onPressed: () {
                                    check();
                                  },
                                  title: "Login",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: isLoading ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Mohon tunggu...", style: TextStyle(color: Colors.amber),)
              ],
            ) : SizedBox(height: 0,),
          )
        ],
      ),
    );
  }
}
