import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDate extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final provider;

  const InputDate({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  DateTime _date = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
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
        String dob = dateFormat.format(_date);
        widget.provider.dobController.text = dob;
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
                controller: widget.provider.dobController,
                decoration: InputDecoration(hintText: dateFormat.format(_date)),
              ),
            ),
            IconButton(
              onPressed: () async {
                await _selectDate(context);
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
