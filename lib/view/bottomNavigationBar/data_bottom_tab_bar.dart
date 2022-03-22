import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/model/entity/type_car.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/view/my_car/create_car.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';
import 'package:provider/provider.dart';

class IconButtonStyle extends StatelessWidget {
  const IconButtonStyle(
      {Key? key,
      required this.voidCallback,
      required this.icon,
      required this.currentTab,
      required this.tab})
      : super(key: key);
  final VoidCallback voidCallback;
  final IconData icon;
  final int currentTab;
  final int tab;
  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      minWidth: windowWidth / 5,
      onPressed: voidCallback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentTab == tab
                ? AppColor.lightButton
                : AppColor.greyBackground,
            size: 30,
          ),
        ],
      ),
    );
  }
}

final List<IconData> iconMid = [
  Icons.near_me_sharp,
  Icons.account_balance_wallet,
  Icons.query_builder,
  Icons.add
];

// ignore: must_be_immutable
class ActionButtonMid extends StatelessWidget {
  ActionButtonMid(
      {Key? key, required this.currentTab, required this.name})
      : super(key: key);
  int currentTab;
  String name;

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    final SecureStorage secureStorage = SecureStorage();
    return FloatingActionButton(
        // ignore: unnecessary_string_interpolations
        heroTag: '$name',
        backgroundColor: AppColor.lightButton,
        child: Icon(
          iconMid[currentTab],
          size: 36,
        ),
        onPressed: () async {          
          switch (currentTab) {
            case 0:
              mapProvider.updatePosition();
              break;
            case 3:
              final token = await secureStorage.readSecureData("token");
              CarRepImpl()
                  .getTypeCars(UrlApi.typeCarsPath, token)
                  .then((value) async {
                final List<TypeCar>? typeCars = value.result;
                myCarProvider.dropdownValue = typeCars![0].id;
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CreateCar(
                    typeCars: typeCars,
                  );
                }
                ));
              }).onError((error, stackTrace) {});
              break;
            default:
              break;
          }
          if (currentTab == 1) {}
        });
  }
}
