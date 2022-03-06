import 'dart:io';

import 'package:parkingappmobile/model/response/image_res.dart';

abstract class ImageRepo {
  Future<ImageRes> postImage(String url, File image, String token);
}