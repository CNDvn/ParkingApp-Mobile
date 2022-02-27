import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';

class InputDate extends StatefulWidget {
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
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
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
              ),
            ),
            IconButton(
              onPressed: () async {
                  _selectDate(context);
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
