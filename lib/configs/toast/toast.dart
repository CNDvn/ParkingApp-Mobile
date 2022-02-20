import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';

void showToastSuccess(String mess) => Fluttertoast.showToast(
    msg: mess,
    backgroundColor: AppColor.greenToast,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 3);
void showToastFail(String mess) => Fluttertoast.showToast(
    msg: mess,
    backgroundColor: AppColor.redToast,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 3);
