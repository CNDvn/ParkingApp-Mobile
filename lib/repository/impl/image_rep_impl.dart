import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parkingappmobile/configs/toast/toast.dart';
import 'package:parkingappmobile/model/response/image_res.dart';
import 'package:parkingappmobile/repository/image_rep.dart';
import 'package:parkingappmobile/view_model/service/service_storage.dart';

class ImageRepImpl implements ImageRepo {
  @override
  Future<ImageRes> postImage(String url, File image, String accessToken) async {
    var result = ImageRes();
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName)
      });
      Response response = await Dio().post(url,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
          }));

      result = ImageRes.imageResFromJson(jsonEncode(response.data));
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.writeSecureData("imageID", result.result!.id);
      await secureStorage.writeSecureData("displayUrl", result.result!.displayUrl);
    } on DioError catch (e) {
      showToastFail(e.response?.data["message"]);
    }
    return result;
  }
}
