import 'package:parkingappmobile/model/entity/user.dart';

class Business {
    Business({
      required this.user,
    });

    User user;

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}