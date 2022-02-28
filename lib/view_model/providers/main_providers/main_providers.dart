import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/enter_password_provider.dart';
import 'package:parkingappmobile/view_model/providers/reset_password_provider.dart';
import 'package:parkingappmobile/view_model/providers/sign_in_provider.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
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
    ChangeNotifierProvider<ResetPasswordProvider>(
      create: (context) => ResetPasswordProvider(),
    ),
    ChangeNotifierProvider<MapProvider>(
      create: (context) => MapProvider(),
    ),
  ];
}
