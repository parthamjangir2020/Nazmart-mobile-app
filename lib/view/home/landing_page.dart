import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/home/home.dart';
import '../utils/others_helper.dart';
import 'bottom_nav.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LandingPage> {
  DateTime? currentBackPressTime;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  //Bottom nav pages
  final List<Widget> _children = [
    const Homepage(),
    const Homepage(),
    const Homepage(),
    const Homepage(),
    const Homepage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
          onWillPop: () {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) >
                    const Duration(seconds: 2)) {
              currentBackPressTime = now;
              OthersHelper().showToast("Press again to exit", Colors.black);
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: _children[_currentIndex]),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
