import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget widgetChild;
  const BackGround({ Key? key,required this.widgetChild }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      color: Colors.white,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: size.height*0.1,
          //   child: Image.asset(AssetPath.logoPath)),
          // Positioned(child:
          //  Image.asset(AssetPath.posterCity)
          // ),
          widgetChild
        ],
      ),
    );
  }
}