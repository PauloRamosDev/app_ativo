import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class Api {
  static const url = 'http://solutionapp.ddns.net:9000/';

  static BaseOptions options = new BaseOptions(
    baseUrl: url,
    connectTimeout: 15000,
  );

  Dio _dio = Dio(options);

  Dio get request => _dio;

  uploadFile(pathFile, {ProgressCallback onSendProgress}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(pathFile,
          filename: path.basename(pathFile))
    });

    var response = await _dio.post("/upload",
        data: formData, onSendProgress: onSendProgress
//          (count, total) {
//        var up = 0;
//
//        up += count;
//
//        print(
//            'UPLOAD UP: ${(up / 1000) / 1000} MB TOTAL: ${(total / 1000) / 1000} MB');
//      },
        );
    return response;
  }

   Future<int> insertAtivo(ativo) async {
    var response = await _dio.post('/insertativo', data: ativo);

    return response.statusCode;
  }
}
