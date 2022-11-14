// @dart=2.9
import 'package:Corner/Screens/DetailNews.dart';
import 'package:Corner/Screens/FAQ.dart';
import 'package:Corner/Screens/HomePage.dart';
import 'package:Corner/Screens/ProvinceStatus.dart';
// import 'package:Corner/Screens/LoginController.dart';
import 'package:Corner/Screens/RegisterController.dart';
import 'package:Corner/Screens/Dashboard.dart';
import 'package:Corner/Screens/News.dart';
import 'package:Corner/Screens/Tabbar.dart';
// import 'package:Corner/Screens/SelfCheck.dart';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => const MyHomePage(),
        "/register": (BuildContext context) => RegisterController(),
        "/detailNews": (BuildContext context) => const DetailNews(),
        "/provinceStatus": (BuildContext context) => const ProvinceStatus(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  List<Widget> _buildScreens() {
    return [Dashboard(), Tabbar(), HomePage(), News(), FAQ()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dashboard),
        title: ("Dashboard"),
        activeColor: Colors.blue[100],
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.equalizer),
        title: ("Rangking"),
        activeColor: Colors.blue[100],
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Beranda",
        activeColor: Colors.blue[100],
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.pages),
        title: ("Berita"),
        activeColor: Colors.blue[100],
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.view_list),
        title: ("FAQ"),
        activeColor: Colors.blue[100],
        inactiveColor: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey[900],
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.transparent,
        // borderRadius: BorderRadius.circular(25)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
