import 'package:attendances/screens/home_pages.dart';
import 'package:attendances/screens/logout_pages.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class UserPages extends StatefulWidget {
  @override
  _UserPagesState createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  int _index = 0;
  PageController _pageController;
  List title = ['Dashboard', 'Profile'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() { 
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title[_index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePages(),
            LogoutPages(),
          ],
        )
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _index,
        onItemSelected: (index) {
          setState(() {
            _index = index;
          });
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(title[_index]),
            icon: Icon(Icons.home),
            activeColor: Colors.amber,
            inactiveColor: Colors.black54
          ),
          BottomNavyBarItem(
            title: Text(title[_index]),
            icon: Icon(Icons.person),
            activeColor: Colors.amber,
            inactiveColor: Colors.black54
          ),
        ],
      ),
    );
  }
}