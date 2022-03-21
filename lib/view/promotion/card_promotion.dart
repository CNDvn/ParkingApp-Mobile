import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';

class CardPromotion extends StatelessWidget {
  const CardPromotion({
    Key? key,
    required this.size,
    required this.image,
    required this.nameParking,
    required this.address,
    required this.description,
    required this.code,
    required this.percent,
  }) : super(key: key);
  final Size size;
  final String image;
  final String nameParking;
  final String address;
  final String description;
  final String code;
  final int percent;

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
            Container(
              width: 1000,
              padding: EdgeInsets.all(2), // Border width
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(48), // Image radius
                  child: Image.network(image, fit: BoxFit.cover),
                ),
              ),
            ),
            Text(
              nameParking,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16.0, height: 2.0),
            ),
            Text(
              "Address: " + address,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0, height: 2.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: "CODE: ",
                      style: TextStyle(
                          color: AppColor.blackText,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      children: <TextSpan>[
                        TextSpan(
                            text: code,
                            style: TextStyle(color: AppColor.greenToast))
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      percent.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          height: 1.6,
                          color: Colors.red),
                    ),
                    Image.asset(AssetPath.promotionPercent,
                        width: 50, color: Colors.red),
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
