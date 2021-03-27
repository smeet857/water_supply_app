import 'package:flutter/material.dart';
import 'package:water_supply_app/page/payment_page.dart';
import 'package:water_supply_app/page/profile_page.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/my_shared_preference.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          title: Text("Settings"),
          ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(title: Text("Profile", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.w500,fontSize: 18),), trailing: Icon(Icons.arrow_forward_ios, color: Mycolor.accent,size: 20,), onTap: _onProfileTap,),
          ListTile(title: Text("Logout", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.w500,fontSize: 18),), trailing: Icon(Icons.arrow_forward_ios, color: Mycolor.accent,size: 20,), onTap: _onLogoutTap,),
        ],
      ),
    );
  }

  void _onProfileTap() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage()
    ));
  }

  void _onPaymentTap() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => PaymentPage()
    ));
  }

  void _onLogoutTap()async {
    await Value.clear();
    Navigator.pushNamedAndRemoveUntil(context, "/home_page", (route) => false);
  }
}
