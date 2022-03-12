import 'package:parkingappmobile/model/response/card_res.dart';

abstract class CardRepo {
  Future<ListCard> getListCardMe(String url);
}
