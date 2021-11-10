import 'dart:convert';
import 'dart:typed_data';
import 'package:akad/constant.dart';
import 'package:akad/models/doklist.dart';
import 'package:akad/models/dokumen.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

Future<Dokumen> createDokumen(
  int jenis,
  String noreg,
  var file,
  String filename,
  String keterangan,
) async {
  Dio dio = Dio();
  var formData = FormData.fromMap({
    "noreg": noreg,
    "jenis": jenis,
    "nama": filename,
    "keterangan": keterangan,
    'file': MultipartFile.fromBytes(file, filename: filename),
  });
  Response responses = await dio.post('$apiURL/', data: formData);
  if (responses.statusCode == 201) {
    return Dokumen.fromJson(jsonDecode(responses.data));
  } else {
    throw Exception('Gagal membuat dokumen');
  }
}

Future<Dokumen> readDokumen(String? id) async {
  String url = "$apiURL/getbyid/$id";
  var response = await http.get(Uri.parse(url));
  var jsonObject = jsonDecode(response.body);
  Dokumen isi = Dokumen.fromJson(jsonObject);
  print(isi);
  return isi;
}

Future<Response> updateDokumen(
  String id,
  int jenis,
  String noreg,
  var file,
  String filename,
  String keterangan,
) async {
  Dio dio = Dio();
  var formData = FormData.fromMap({
    "noreg": noreg,
    "jenis": jenis,
    "nama": filename,
    "keterangan": keterangan,
    'file': MultipartFile.fromBytes(file, filename: filename),
  });
  Response responses = await dio.put('$apiURL/$id', data: formData);

  return responses;
}

Future<Dokumen> deleteDokumen(String? id) async {
  String url = "$apiURL/$id";
  var responses = await http.delete(Uri.parse(url));
  var jsonObject = jsonDecode(responses.body);
  if (responses.statusCode == 201) {
    return Dokumen.fromJson(jsonDecode(jsonObject));
  } else {
    throw Exception('Gagal menghapus dokumen');
  }
}

Future<List<Doklist>> readDoklist() async {
  String url = "$apiURL/";
  var response = await http.get(Uri.parse(url));
  var jsonObject = jsonDecode(response.body);
  List<Doklist> isi = [];

  for (int i = 0; i < jsonObject.length; i++) {
    isi.add(Doklist.getDoklist(jsonObject[i]));
  }
  return (isi);
}

Future<Uint8List> generatePDF(PdfPageFormat format, var filepdf) async {
  // await Printing.layoutPdf(onLayout: (_) => filepdf);

  return filepdf;
}
