import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/history/card_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0, size.height * 0.05, 0, size.height * 0.05),
          ),
          // Booking Active
          const Text(
            "Booking Active",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
          ),
          SizedBox(
            height: 0.2 * size.height,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 1,
              itemBuilder: (context, index) {
                return const CardHistory(
                  isComplete: false,
                );
              },
            ),
          ),
          // Booking Complete
          const Text(
            "Booked Complete",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
          ),
          SizedBox(
            height: 0.5 * size.height,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const CardHistory(
                  isComplete: true,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
