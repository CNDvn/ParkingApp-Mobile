import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/view/payments/card_payment.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 400,
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 70),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 1,
              childAspectRatio: 5 / 6,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                (index) {
                  return const SizedBox(
                    width: 160.0,
                    child: CardPayment(),
                  );
                },
              )),
        ),
        Column(
          children: [
            const Text(
              "Trần Phạm Gia Bảo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
            ),
            Text(
              NumberFormat.simpleCurrency(locale: 'vi')
                  .format(900000.000)
                  .toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
            )
          ],
        )
      ],
    ));
  }
}
