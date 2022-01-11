import 'package:flutter/material.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

class BackGroundLogin extends StatelessWidget {
  final Widget widget_child;
  const BackGroundLogin({ Key? key,required this.widget_child }) : super(key: key);

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
          Positioned(
            top: size.height*0.1,
            child: Image.asset(AssetPath.logoPath)),
          Positioned(child:
           Image.asset(AssetPath.posterCity)
          ),
          widget_child
        ],
      ),
    );
  }
}