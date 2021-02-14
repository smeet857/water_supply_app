import 'package:flutter/material.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/my_colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Profile',),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          children: [
            commonTile("Name", user.firstname + " " + user.lastname),
            SizedBox(
              height: 30,
            ),
            commonTile("Mobile no", user.phone),
            SizedBox(
              height: 30,
            ),
            commonTile("Address", user.address1),
            SizedBox(
              height: 30,
            ),
            commonTile("City", user.city),
            SizedBox(
              height: 30,
            ),
            commonTile("State", user.state),
            SizedBox(
              height: 30,
            ),
            commonTile("Referral Code", user.referralCode),
          ],
        ),
      ),
    );
  }

  Widget commonTile(String title, String desc) {
    if(desc == ""){
      desc = "Empty";
    }

    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
        Expanded(
            flex: 1,
            child: Text(
              ":",
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
        Expanded(
            flex: 3,
            child: Text(
              desc,
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
      ],
    );
  }
}
