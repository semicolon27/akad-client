import 'dart:convert';
import 'package:akad/view_model/vm_detail.dart';
import 'package:dio/dio.dart';

class ControllerDetail {
  Future<Dokumen> createDokumen(int jenis, String noreg, var file) async {
    Dio dio = Dio();
    var formData = FormData.fromMap({
      'noreg': noreg,
      'jenis': jenis,
      'file': await MultipartFile.fromBytes(file, filename: 'upload.txt'),
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
}

class Dokumen {
  final int id;
  final int jenis;
  final String noreg;
  final file;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.noreg,
      required this.file});

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    print("factory fromJson");
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: json['id'],
        jenis: json['jenis'],
        noreg: json['noreg'],
        file: json['file']);
  }
}
