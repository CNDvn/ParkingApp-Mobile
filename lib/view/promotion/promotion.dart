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
                  CardPromotion(
                    size: size,
                    image: "https://i.ibb.co/myg7DxK/a41d8a03be4b.jpg",
                    nameParking: "B??i Gi??? Xe Anh T??m",
                    address: "66/8 ???????ng G?? D??a, Ph?????ng Tam B??nh, Qu???n Th??? ?????c",
                    description: "??p d???ng cho th??nh vi??n m???i",
                    code: "ATVD668",
                    percent: 10,
                  ),
                  CardPromotion(
                    size: size,
                    image: "https://i.ibb.co/z4wSzZB/ec493909f47a.jpg",
                    nameParking: "B??i Gi??? Xe B?? Hu???",
                    address: "Nguy???n Hu??? Qu???n 1",
                    description: "??p d???ng cho th??nh vi??n c?? sinh nh???t th??ng 3",
                    code: "BB10XH",
                    percent: 20,
                  ),
                  CardPromotion(
                    size: size,
                    image: "https://i.ibb.co/DbdHcfW/7db0b963cfc9.jpg",
                    nameParking: "B??i Gi??? Xe B???o B???o",
                    address:
                        "53 ???????ng V?? V??n Ng??n, Linh T??y, Th??? ?????c, Th??nh ph??? H??? Ch?? Minh",
                    description: "??p d???ng cho SV FPT",
                    code: "BAOPROVIP",
                    percent: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
