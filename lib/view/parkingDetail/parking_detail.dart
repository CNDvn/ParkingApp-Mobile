import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/model/entity/image.dart';
import 'package:parkingappmobile/model/response/parking_detail_res.dart';
import 'package:parkingappmobile/view_model/providers/data_point_provider.dart';
import 'package:parkingappmobile/view_model/providers/my_car_provider.dart';
import 'package:parkingappmobile/view_model/providers/parking_detail_provider.dart';
import 'package:parkingappmobile/widgets/button/button.dart';
import 'package:parkingappmobile/widgets/carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ParkingDetail extends StatefulWidget {
  const ParkingDetail({
    Key? key,
    required this.name,
    required this.images,
    required this.parkingSlots,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.slotFull,
    required this.slotEmpty,
    required this.priceLists,
    required this.username,
    required this.phoneNumber,
  }) : super(key: key);

  final String name;
  final List<Images> images;
  final List<dynamic> parkingSlots;
  final String address;
  final String? openTime;
  final String? closeTime;
  final int slotFull;
  final int slotEmpty;
  final List<PriceList> priceLists;
  final String username;
  final String phoneNumber;

  @override
  State<ParkingDetail> createState() => _ParkingDetailState();
}

class _ParkingDetailState extends State<ParkingDetail> {
  @override
  void initState() {
    MyCarProvider myCarProvider =
        Provider.of<MyCarProvider>(context, listen: false);
    super.initState();
    myCarProvider.getMyCar();
    myCarProvider.firstCar = myCarProvider.listMyCar.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final format = NumberFormat("#,##0,000");
    DateTime date = DateTime.now();
    final List<Images> urlImagesDefault = [
      Images(url: 'https://i.ibb.co/0ZYrz1k/6bf25a7075ec.jpg')
    ];
    ParkingDetailsProvider provider =
        Provider.of<ParkingDetailsProvider>(context);
    MyCarProvider myCarProvider = Provider.of<MyCarProvider>(context);
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    bool status() {
      final op = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(widget.openTime!.split(":")[0]),
        int.parse(widget.openTime!.split(":")[1]),
        int.parse(widget.openTime!.split(":")[2]),
      );
      final cl = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(widget.closeTime!.split(":")[0]),
        int.parse(widget.closeTime!.split(":")[1]),
        int.parse(widget.closeTime!.split(":")[2]),
      );
      if (date.isAfter(op) && date.isBefore(cl)) {
        return true;
      }
      return false;
    }

    int checkStatusPriceList() {
      int index = 0;
      for (var i = 0; i < widget.priceLists.length; i++) {
        if (widget.priceLists[i].status == "active") {
          index = i;
        }
      }
      return index;
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        margin:
            EdgeInsets.fromLTRB(0, size.height * 0.005, 0, size.height * 0.005),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    mapProvider.reset();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/BottomTabBar", (route) => false);
                  },
                )),
              ]),
              Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 6,
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
              CarouselSliderImage(
                urlImages:
                    widget.images.isNotEmpty ? widget.images : urlImagesDefault,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  height: size.height * 0.35,
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address:",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                            ),
                            SizedBox(
                              width: size.width * 0.58,
                              child: Text(
                                widget.address,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status:",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                            ),
                            Text(
                              status() ? "Open" : "Close",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: status()
                                      ? AppColor.greenToast
                                      : AppColor.redToast,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Open Time: ",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.greyText),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.openTime!.substring(0, 5),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.blackText,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Close Time: ",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.greyText),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.closeTime!.substring(0, 5),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.blackText,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Slots:",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                            ),
                            Text(
                              widget.parkingSlots.length.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.greenToast,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Slot Full: ",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.greyText),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.slotFull.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.redToast,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Slot Empty: ",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColor.greyText),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.slotEmpty.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.greenToast,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: SingleChildScrollView(
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Text(
                                                widget
                                                    .priceLists[
                                                        checkStatusPriceList()]
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor.blackText,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              for (var detail in widget
                                                  .priceLists[
                                                      checkStatusPriceList()]
                                                  .priceListDetails)
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          detail.typeCar.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .redToast),
                                                        ),
                                                        Text(
                                                          format
                                                                  .format(double.parse(detail
                                                                      .price
                                                                      .substring(
                                                                          0,
                                                                          detail.price.length -
                                                                              4)))
                                                                  .toString() +
                                                              " VND/H",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: AppColor
                                                                  .greenToast,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: const Text("Show Price List")),
                          ],
                        ),
                        Divider(color: AppColor.greyText),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Owner:",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                            ),
                            Text(
                              widget.username,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.blackText,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hotline:",
                              style: TextStyle(
                                  fontSize: 16, color: AppColor.greyText),
                            ),
                            Text(
                              widget.phoneNumber,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.redToast,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(children: [
                const SizedBox(
                  child: Text("Your Car(N°Plate): "),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                SizedBox(
                    height: size.height * 0.09,
                    child: DropdownButton(
                      value: myCarProvider.firstCar,
                      onChanged: (String? newValue) {
                        setState(() {
                          myCarProvider.firstCar = newValue!;
                        });
                      },
                      items: myCarProvider.listMyCar.keys.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
              ]),
              SizedBox(
                height: size.height * 0.01,
              ),
              ButtonDefault(
                width: size.width,
                content: 'Book',
                voidCallBack: () {
                  setState(() {
                    myCarProvider.getIdCar();
                    myCarProvider.parkingName = widget.name;
                  });
                  provider.addInformation(
                      widget.name, widget.phoneNumber, widget.address);
                  provider.booKingParking(context);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
