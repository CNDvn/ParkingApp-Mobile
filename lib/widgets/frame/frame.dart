import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';

class Frame extends StatefulWidget {
  final Widget widget;
  const Frame({ Key? key,required this.widget }) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {      
  Size size = MediaQuery.of(context).size;
    return  Scaffold(
      key: scaffoldKey,
      drawer: const DrawerDefault(),
      body: Stack(
        children: [
          widget,
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  )),
                  SizedBox(
                    child: ClipOval(
                      child: Material(
                        color: AppColor.blueBackground,
                        child: InkWell(
                          splashColor: AppColor.whiteBackground,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const UserProfile();
                            }));
                          },
                          child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset(AssetPath.profilePhoto)),
                        ),
                      ),
                    ),
                  )
                ]),
          ),]
      ),
    );
  }
}