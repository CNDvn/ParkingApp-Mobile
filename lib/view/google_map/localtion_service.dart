import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocaltionService {
  final String key = "AIzaSyCQY6ns64loiBy8bUa5d0gFkNoMYZUdssM";

  Future<String> getPlaceId(String input) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    if (json['candidates'] != null) {
    var placeId = json['candidates'][0]['place_id'] as String ;
    print(placeId);
    return placeId;
    }
    return "";
  }

  //Future<String> getPlace(String input) async {}
}