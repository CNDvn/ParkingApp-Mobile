import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/response/card_res.dart';

class CardPayment extends StatelessWidget {
  CardPayment({Key? key, required this.card}) : super(key: key);
  CardBank card;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.blueGrey,
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
        child: Column(children: <Widget>[
          Row(
            children: const [
              Text("My Card",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("* * * *",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 2)),
              const Text("* * * *",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 2)),
              const Text("* * * *",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 2)),
              Text(
                  card.cardNumber[card.cardNumber.length - 4].toString() +
                      card.cardNumber[card.cardNumber.length - 3].toString() +
                      card.cardNumber[card.cardNumber.length - 2].toString() +
                      card.cardNumber[card.cardNumber.length - 1].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Card Holder",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card.cardHolder,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6)),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Expires",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6)),
              Text(card.dateValidFrom,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6))
            ],
          ),
        ]),
      ),
    );
  }
}
