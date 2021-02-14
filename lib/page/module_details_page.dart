import 'package:flutter/material.dart';
import 'package:water_supply_app/model/services.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                service.serviceImg,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (c,w,i){
                  if (i == null)
                           return w;
                         return Container(
                           height: 200,
                           child: Center(
                             child: CircularProgressIndicator(
                               backgroundColor: Colors.grey,
                               value: i.expectedTotalBytes != null
                                   ? i.cumulativeBytesLoaded / i.expectedTotalBytes
                                   : null,
                             ),
                           ),
                         );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "About : ${service.notes}",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
