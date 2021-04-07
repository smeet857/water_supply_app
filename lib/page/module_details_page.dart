import 'package:flutter/material.dart';
import 'package:water_supply_app/model/services.dart';
import 'package:water_supply_app/widget/image_network_widget.dart';

class ModuleDetailsPage extends StatelessWidget {
  final String title;
  final Services service;

  const ModuleDetailsPage({Key key, this.title, this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(service.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ImageNetWorkWidget(
                url: service.serviceImg,
                height: 200,
                width: double.infinity,
                boxFit: BoxFit.cover,
              )
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "About : ${service.notes}",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
