import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/my_car/create_car.dart';

class CardCar extends StatelessWidget {
  const CardCar({Key? key}) : super(key: key);

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
                'https://i.ibb.co/GMv63Nr/e391ff1ef747.png',
                width: 100,
                height: 100,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Mecs'), Text("inParking".toUpperCase())],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('30F- 678.99'),
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
