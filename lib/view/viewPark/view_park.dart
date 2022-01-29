import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/widgets/button/button_view_park.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ViewPark extends StatefulWidget {
  const ViewPark({ Key? key }) : super(key: key);

  @override
  _ViewParkState createState() => _ViewParkState();
}

class _ViewParkState extends State<ViewPark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blueText,
        iconTheme: const IconThemeData(color: Color(0xff3277DB)),
        elevation: 0,
      ),
      body: Column(
        children: [Container(
            constraints: const BoxConstraints.expand(height: 280),
            color: AppColor.blueText,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Image.asset("assets/images/xe.png"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: RichText(
                    text: const TextSpan(
                    text: "Parking App - ",
                    style: TextStyle(color: Color(0xff606470), fontSize: 25, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: "20/hr",
                        style: TextStyle(color: Color(0xff606470), fontSize: 16))
                      ]),
                    ),
                ),
              ],
            ),
          ),
          const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  "End time",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff333333)),
                ),
                ),
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            const SizedBox(width: 10,),
                            SizedBox(
                              // margin: const EdgeInsets.only(right: 20),
                              child: ButtonViewPark(content: "Today", voidCallBack: (){})
                            ),
                            const SizedBox(width: 45,),
                            SizedBox(
                              // margin: const EdgeInsets.only(left: 15),
                              child: ButtonViewPark(content: "Tomorrow", voidCallBack: (){})
                            ),
                            const SizedBox(width: 45,),
                            SizedBox(
                              // margin: const EdgeInsets.only(left: 70),
                              child: ButtonViewPark(content: "Later", voidCallBack: (){})
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 130),
                      ConfirmationSlider(
                        onConfirmation: () {},
                      )
          ],),
    );
  }
}