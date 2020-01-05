import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ButtonWidget({Key key, @required this.onPressed, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.amber, Colors.amberAccent])),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
