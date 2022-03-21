import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/configs/themes/app_text_style.dart';
import 'package:parkingappmobile/view/promotion/card_promotion.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:provider/provider.dart';

class Promotion extends StatelessWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    mapProvider.reset();
                    Navigator.pushReplacementNamed(context, "/BottomTabBar");
                  },
                )),
              ]),
            ),
            SizedBox(
              child: Title(
                  color: AppColor.greyBackground,
                  child: Text(
                    "Promotion List",
                    style: AppTextStyles.h2Black,
                  )),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              height: size.height * 0.8,
              child: ListView(
                children: [
                  CardPromotion(size: size),
                  CardPromotion(size: size),
                  CardPromotion(size: size),
                  CardPromotion(size: size),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
