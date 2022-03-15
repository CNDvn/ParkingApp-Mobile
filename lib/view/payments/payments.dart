import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/view/payments/card_payment.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  // List<CardBank>? listCard = [];
  @override
  void initState() {
    super.initState();
    // CardPaymentRepImp().getListCardMe(UrlApi.cardsPath).then((value) => {
    //       setState(() {
    //         listCard = value.result;
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height*0.1,
        ),
        const SizedBox(
          child: CardPayment(),
        ),
        // SizedBox(
        //   height: size.height*0.1,
        //   child: GridView.count(
        //       // primary: false,
        //       padding: const EdgeInsets.fromLTRB(30, 70, 30, 70),
        //       crossAxisSpacing: 0,
        //       mainAxisSpacing: 10,
        //       crossAxisCount: 1,
        //       // childAspectRatio: 5 / 6,
        //       scrollDirection: Axis.horizontal,
        //       children:
        //       // List.generate(
        //       //   listCard!.length,
        //       //   (index) {
        //       //     return const
        //           [
        //             SizedBox(
        //             width:  size.height*0.1,
        //             child: CardPayment(
        //               // card: listCard![index]
        //               ),
        //           ),
        //           SizedBox(
        //             width:  size.height*0.1,
        //             child: CardPayment(
        //               // card: listCard![index]
        //               ),
        //           )
        //           ],)),
        //   },
        // )),
        // ),
        SizedBox(
          height: size.height*0.1,
          child: Column(          
            children: [
              const Text(
                "Diep Loc",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
              ),
              Text(
                NumberFormat.simpleCurrency(locale: 'vi')
                    .format(900000.000)
                    .toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
              )
            ],
          ),
        )
      ],
    ));
  }
}
