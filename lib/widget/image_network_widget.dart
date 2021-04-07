import 'package:flutter/material.dart';

class ImageNetWorkWidget extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit boxFit;

  const ImageNetWorkWidget({Key key, this.url,this.height = 50 ,this.width = 50,this.boxFit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: boxFit,
      loadingBuilder: (c,w,i){
        if (i == null)
          return w;
        return SizedBox(
          height: height,
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
    );
  }
}
