import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ViewPark extends StatelessWidget {
  const ViewPark({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blueText,
        iconTheme: IconThemeData(color: AppColor.blackText),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Container(
              constraints: BoxConstraints.expand(height: size.height * 0.4),
              color: AppColor.blueText,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Image.asset("assets/images/xe.png"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child: RichText(
                      text: TextSpan(
                      text: "Parking App - ",
                      style: AppTextStyles.h1Black,
                      children: <TextSpan>[
                        TextSpan(
                          text: "20/hr",
                          style: AppTextStyles.h2Black)
                        ]),
                      ),
                  ),
                ],
              ),
            ),
            Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(
                    "End time",
                    style: AppTextStyles.h2Black,
                  ),
                  ),
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              SizedBox(width: size.width * 0.01,),
                              SizedBox(
                                child: ButtonDefault(content: "Today", voidCallBack: (){}, width: size.width * 0.24, height: size.height * 0.075)
                              ),
                              SizedBox(width: size.width * 0.14,),
                              SizedBox(
                                child: ButtonDefault(content: "Tomorrow", voidCallBack: (){}, width: size.width * 0.24, height: size.height * 0.075)
                              ),
                              SizedBox(width: size.width * 0.12,),
                              SizedBox(
                                child: ButtonDefault(content: "Later", voidCallBack: (){}, width: size.width * 0.24, height: size.height * 0.075)
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.2),
                        ConfirmationSlider(
                          onConfirmation: () {},
                        )
            ],),
      ),
    );
  }
}