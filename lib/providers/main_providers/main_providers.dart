import 'package:parkingappmobile/providers/sign_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainProviders {
  static List<SingleChildWidget> providers = [
    //signIn
    ChangeNotifierProvider<SignInProvider>(
      create: (context) => SignInProvider(),
    ),
  ];
}
