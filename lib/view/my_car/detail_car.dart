import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkingappmobile/model/entity/type_car.dart';
import 'package:parkingappmobile/view_model/providers/car_detail_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/upload_image/upload_image.dart';
import 'package:provider/provider.dart';

class DetailCar extends StatefulWidget {
  final List<TypeCar>? typeCars;
  const DetailCar({
    Key? key,
    this.typeCars,
  }) : super(key: key);

  @override
  State<DetailCar> createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar> {
  @override
  Widget build(BuildContext context) {
    CarDetailProvider provider = Provider.of<CarDetailProvider>(context);

    Future pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        final imageTemporary = File(image.path);
        setState(() {
          provider.image = imageTemporary;
        });
      } catch (e) {
        log("Failed to pick image: $e");
      }
    }

    Size size = MediaQuery.of(context).size;
    double sizeHeightInput = size.height * 0.12;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.05, 0, size.height * 0.05),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ]),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  const Expanded(
                    flex: 6,
                    child: Text(
                      "Detail Car",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            ),
            UploadImage(
                widget: SizedBox(
                  height: size.height * 0.15,
                  width: size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: provider.image != null
                        ? Image.file(
                            provider.image!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            provider.imageSto!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                pickImage: pickImage,
                removeImage: () {
                  setState(() {
                    provider.image = null;
                  });
                }),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: provider.textBrand.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => provider.clearBrandController(),
                            )
                          : null,
                      labelText: 'Brands',
                      errorText:
                          provider.submitValid ? provider.brand.error : null),
                  autofocus: false,
                  controller: provider.brandController,
                  focusNode: provider.brandFocus,
                  onEditingComplete: () {
                    provider.changeFocus(context, "brand");
                  },
                  onChanged: (String value) {
                    provider.checkValidation(value, "brand");
                  }),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: provider.textColor.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => provider.clearColorController(),
                            )
                          : null,
                      labelText: 'Color',
                      errorText:
                          provider.submitValid ? provider.color.error : null),
                  autofocus: false,
                  controller: provider.colorController,
                  focusNode: provider.colorFocus,
                  onEditingComplete: () {
                    provider.changeFocus(context, "color");
                  },
                  onChanged: (String value) {
                    provider.checkValidation(value, "color");
                  }),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: provider.textModelCode.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  provider.clearModelCodeController(),
                            )
                          : null,
                      labelText: 'Model code',
                      errorText: provider.submitValid
                          ? provider.modelCode.error
                          : null),
                  autofocus: false,
                  controller: provider.modelCodeController,
                  focusNode: provider.modelCodeFocus,
                  onEditingComplete: () {
                    provider.changeFocus(context, "modelCode");
                  },
                  onChanged: (String value) {
                    provider.checkValidation(value, "modelCode");
                  }),
            ),
            SizedBox(
              height: sizeHeightInput,
              child: TextField(
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: provider.textNPlate.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => provider.clearNPlateController(),
                            )
                          : null,
                      labelText: 'N°Plate',
                      errorText:
                          provider.submitValid ? provider.nPlate.error : null),
                  autofocus: false,
                  controller: provider.nPlateController,
                  focusNode: provider.nPlateFocus,
                  onEditingComplete: () {
                    provider.changeFocus(context, "nPlate");
                  },
                  onChanged: (String value) {
                    provider.checkValidation(value, "nPlate");
                  }),
            ),
            Row(
              children: [
                Text(
                  'Type: ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                DropdownButton(
                  value: provider.dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: widget.typeCars?.map((TypeCar items) {
                    return DropdownMenuItem(
                      value: items.id,
                      child: Text(items.name!),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      provider.dropdownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, size.height * 0.07, 0, 0),
              child: ButtonDefault(
                width: size.width,
                content: 'Save',
                voidCallBack: () => {provider.submitData(context)},
              ),
            )
          ],
        ),
      )),
    );
  }
}
