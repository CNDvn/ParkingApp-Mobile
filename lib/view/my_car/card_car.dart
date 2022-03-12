import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/entity/car.dart';
import 'package:parkingappmobile/model/entity/typeCar.dart';
import 'package:parkingappmobile/repository/impl/car_rep_impl.dart';
import 'package:parkingappmobile/view/my_car/create_car.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';
import 'package:parkingappmobile/view_model/url_api/url_api.dart';

class CardCar extends StatefulWidget {
  CardCar({Key? key, this.car, this.typeCars}) : super(key: key);
  Car? car;
  List<TypeCar>? typeCars;

  @override
  State<CardCar> createState() => _CardCarState();
}

class _CardCarState extends State<CardCar> {
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData("token").then((token) => {
          CarRepImpl()
              .getTypeCars(UrlApi.typeCarsPath, token)
              .then((value) async {
            setState(() {
              widget.typeCars = value.result;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.network(
                widget.car!.images.isEmpty
                    ? "https://i.ibb.co/GMv63Nr/e391ff1ef747.png"
                    : widget.car!.images[0].url,
                width: 100,
                height: 100,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.car!.brand),
                  Text(widget.car!.status.toUpperCase())
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.car!.nPlates),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCar(
                                  car: widget.car,
                                  typeCars: widget.typeCars,
                                  isUpdate: true,
                                )),
                      );
                    },
                    child: const Text('View Detail'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
