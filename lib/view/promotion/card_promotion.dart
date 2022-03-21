import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';

class CardPromotion extends StatelessWidget {
  const CardPromotion({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiem Duy dep zai",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          height: 2.0),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://thuexerangdong.com/wp-content/uploads/2020/06/gia-gui-xe-o-to-thang-tphcm-luon-la-mot-trong-nhung-moi-quan-tam-hang-dau-hien-nay-doi-voi-nhung-ai-dang-va-se-so-huu-o-to-rieng.jpg",
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address: ",
                  style: TextStyle(fontSize: 16, color: AppColor.greyText),
                ),
                Text(
                  "Tran Duy Hung",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Timing",
                  style: TextStyle(fontSize: 16, color: AppColor.greyText),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.access_alarm,
                      color: AppColor.lightButton,
                      size: 24.0,
                    ),
                    Text(
                      "50%",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.6,
                          color: AppColor.lightButton),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
