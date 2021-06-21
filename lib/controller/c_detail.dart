import 'dart:convert';
import 'package:akad/models/dokumen.dart';
import 'package:dio/dio.dart';

Future<Dokumen> createDokumen(
    int jenis, String noreg, var file, String filename) async {
  Dio dio = Dio();
  var formData = FormData.fromMap({
    'noreg': noreg,
    'jenis': jenis,
    'file': await MultipartFile.fromBytes(file, filename: filename),
  });

  Response responses = await dio.post(
      'https://webhook.site/c502765b-dfce-405b-8bb3-b2c9c556ed43',
      data: formData);

  if (responses.statusCode == 201) {
    // print("status 201");
    return Dokumen.fromJson(jsonDecode(responses.data));
  } else {
    // print("gagal");
    throw Exception('Gagal membuat dokumen');
  }
}
