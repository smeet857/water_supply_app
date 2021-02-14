import 'package:flutter/material.dart';
import 'package:water_supply_app/util/my_colors.dart';

class EnquiryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Message"),
      content: Text(
          "Thank you , to choose JEEL AQUA for you Happy & Healthy life, Our executive will contact you soon.",
      textAlign: TextAlign.justify,style: TextStyle(fontWeight : FontWeight.w500),),

      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Mycolor.accent),
            ))
      ],
    );
  }
}
