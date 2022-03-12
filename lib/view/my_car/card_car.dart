import 'package:flutter/material.dart';
import 'package:parkingappmobile/model/entity/car.dart';
import 'package:parkingappmobile/view/my_car/create_car.dart';

class CardCar extends StatelessWidget {
   CardCar({Key? key,this.car}) : super(key: key);
  Car? car; 
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
               car!.images.length == 0 ?  "https://i.ibb.co/GMv63Nr/e391ff1ef747.png" :  car!.images[0].url,
                width: 100,
                height: 100,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(car!.brand), Text(car!.status.toUpperCase())],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(car!.nPlates),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateCar(
                                  typeCars: [],
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
