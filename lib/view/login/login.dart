import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view/login/background_login.dart';
import 'package:parkingappmobile/view/rootPage/root_page.dart';
import 'package:parkingappmobile/widgets/button/button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGroundLogin(
      widget_child: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: "Phone number",
                  ),
                  autofocus: false,
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  autofocus: false,
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[Text("Forgot Password?")],
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 0.9,
                child: ButtonDefault(
                  content: "Login",
                  voidCallBack: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Or '),
                    GestureDetector(
                        child: Text("Signup",style: AppTextStyles.h4,),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RootPage();
                          }));
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
