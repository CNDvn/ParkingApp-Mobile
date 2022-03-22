import 'package:parkingappmobile/view_model/providers/booking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/car_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/parking_detail_provider.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/enter_change_password_provider.dart';
import 'package:parkingappmobile/view_model/providers/enter_password_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/reset_password_provider.dart';
import 'package:parkingappmobile/view_model/providers/sign_in_provider.dart';
import 'package:parkingappmobile/view_model/providers/sign_up_provider.dart';
import 'package:parkingappmobile/view_model/providers/tracking_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/view_model/providers/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainProviders {
  static List<SingleChildWidget> providers = [
    //signIn
    ChangeNotifierProvider<SignInProvider>(
      create: (context) => SignInProvider(),
    ),
    ChangeNotifierProvider<UserProfileProvider>(
      create: (context) => UserProfileProvider(),
    ),
    ChangeNotifierProvider<EnterPasswordProvider>(
      create: (context) => EnterPasswordProvider(),
    ),
    ChangeNotifierProvider<EnterChangePasswordProvider>(
      create: (context) => EnterChangePasswordProvider(),
    ),
    ChangeNotifierProvider<ResetPasswordProvider>(
      create: (context) => ResetPasswordProvider(),
    ),
    ChangeNotifierProvider<MapProvider>(
      create: (context) => MapProvider(),
    ),
    ChangeNotifierProvider<SignUpProvider>(
      create: (context) => SignUpProvider(),
    ),
    ChangeNotifierProvider<MyCarProvider>(
      create: (context) => MyCarProvider(),
    ),
    ChangeNotifierProvider<ParkingDetailsProvider>(
      create: (context) => ParkingDetailsProvider(),
    ),
    ChangeNotifierProvider<TrackingCarProvider>(
      create: (context) => TrackingCarProvider(),
    ),
    ChangeNotifierProvider<BookingDetailProvider>(
      create: (context) => BookingDetailProvider(),
    ),
    ChangeNotifierProvider<CarDetailProvider>(
      create: (context) => CarDetailProvider(),
    ),
    ChangeNotifierProvider<WalletProvider>(
      create: (context) => WalletProvider(),
    ),
  ];
}
