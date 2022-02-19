import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/exception/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context,{
    required String title,
    required Exception exception,
  }) => showAlertDialog(context, title: title, content: exception.toString(), defaultActionText: 'OK');