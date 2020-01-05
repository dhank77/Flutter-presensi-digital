import 'package:attendances/screens/home_pages.dart';
import 'package:attendances/screens/logout_pages.dart';
import 'package:attendances/screens/scan_pages.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class TabbarPages extends StatefulWidget {
  @override
  _TabbarPagesState createState() => _TabbarPagesState();
}

class _TabbarPagesState extends State<TabbarPages> {
  int _index = 0;
  PageController _pageController;
  List title = ['Dashboard', 'QR Scan', 'Profile'];

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
            ScanPages(),
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
            icon: Icon(Icons.chrome_reader_mode),
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