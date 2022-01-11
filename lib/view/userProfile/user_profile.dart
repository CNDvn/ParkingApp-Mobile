import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeHeightInput = size.height * 0.1;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('User Profile'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  0, size.height * 0.05, 0, size.height * 0.05),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100 / 2),
                          child: Image.asset(
                            AssetPath.profile_photo,
                            height: 100.0,
                            width: 100.0,
                          ))),
                  SizedBox(
                    height: sizeHeightInput,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Full name'),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeightInput,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Email address'),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeightInput,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Phone number'),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeightInput,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, size.height * 0.07, 0, 0),
                    child: ButtonDefault(
                      width: size.width,
                      content: 'Save',
                      voidCallBack: () => {print("anh hieu dep trai")},
                    ),
                  )
                ],
              )),
        ));
  }
}
