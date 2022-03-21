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
                    nameParking: "Bãi Giữ Xe Anh Tâm",
                    address: "66/8 đường Gò Dưa, Phường Tam Bình, Quận Thủ Đức",
                    description: "Áp dụng cho thành viên mới",
                    code: "ATVD668",
                    percent: 10,
                  ),
                  CardPromotion(
                    size: size,
                    image: "https://i.ibb.co/z4wSzZB/ec493909f47a.jpg",
                    nameParking: "Bãi Giữ Xe Bà Huệ",
                    address: "Nguyễn Huệ Quận 1",
                    description: "Áp dụng cho thành viên có sinh nhật tháng 3",
                    code: "BB10XH",
                    percent: 20,
                  ),
                  CardPromotion(
                    size: size,
                    image: "https://i.ibb.co/DbdHcfW/7db0b963cfc9.jpg",
                    nameParking: "Bãi Giữ Xe Bảo Bảo",
                    address:
                        "53 Đường Võ Văn Ngân, Linh Tây, Thủ Đức, Thành phố Hồ Chí Minh",
                    description: "Áp dụng cho SV FPT",
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
