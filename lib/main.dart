import 'package:flutter/material.dart';
import 'package:water_supply_app/page/home_page.dart';
import 'package:water_supply_app/page/login_page.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/my_styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Mycolor.primarySwatch,
        accentColor: Mycolor.accent,
        appBarTheme: MyStyle.appBarTheme,
        scaffoldBackgroundColor: Mycolor.scaffoldBg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: generateRoute,
      home: HomePage(),
    );
  }
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
