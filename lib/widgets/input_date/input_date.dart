import 'package:flutter/material.dart';

class InputDate extends StatefulWidget {
  final TextEditingController provider;

  const InputDate({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        print(_date.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Day of Birthday',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: size.height * 0.07,
              width: size.width * 0.75,
              child: TextField(
                enabled: false,
                controller: widget.provider,
              ),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  _selectDate(context);
                });
              },
              icon: const Icon(
                Icons.calendar_today,
              ),
            )
          ],
        ),
      ],
    );
  }
}
