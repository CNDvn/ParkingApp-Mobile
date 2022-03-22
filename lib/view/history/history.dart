import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/response/history_res.dart';
import 'package:parkingappmobile/view/history/card_history.dart';

// ignore: must_be_immutable
class History extends StatefulWidget {
  List<Result>? history;
  History({Key? key, this.history}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Result>? listComplete = [];
  Result? historyActive;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.history!.length; i++) {
      if (widget.history![i].status != "paid") {
        setState(() {
          historyActive = widget.history![i];
        });
      } else {
        setState(() {
          listComplete!.add(widget.history![i]);
        });
      }
    }
  }

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
                0, size.height * 0.02, 0, size.height * 0.05),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
                child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
          ]),
          historyActive != null ? Column(
            children: [
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
                    return CardHistory(
                      history: historyActive,
                      isComplete: false,
                    );
                  },
                ),
              ),
            ],
          ) : const Text(""), // Booking Complete
          listComplete != null
              ? const Text(
                  "Booking Complete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
                )
              : const Text(
                  "No Transaction History",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, height: 1.6),
                ),
          SizedBox(
            height:
                historyActive != null ? 0.5 * size.height : 0.75 * size.height,
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: listComplete?.length,
              itemBuilder: (context, index) {
                return CardHistory(
                  history: listComplete![index],
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
