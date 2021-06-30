import 'dart:convert';
import 'dart:typed_data';
import 'package:akad/models/doklist.dart';
import 'package:akad/models/dokumen.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

Future<Dokumen> createDokumen(
    int jenis, String noreg, var file, String filename) async {
  Dio dio = Dio();
  var formData = FormData.fromMap({
    "noreg": noreg,
    "jenis": 1,
    "nama": filename,
    'file': MultipartFile.fromBytes(file, filename: filename),
  });
  Response responses = await dio.post('http://127.0.0.1:8000/', data: formData);
  if (responses.statusCode == 201) {
    return Dokumen.fromJson(jsonDecode(responses.data));
  } else {
    throw Exception('Gagal membuat dokumen');
  }
}

Future<List<Doklist>> readDoklist() async {
  String url = "http://127.0.0.1:8000/";
  var response = await http.get(Uri.parse(url));
  var jsonObject = jsonDecode(response.body);
  List<Doklist> isi = [];

  for (int i = 0; i < jsonObject.length; i++) {
    isi.add(Doklist.getDoklist(jsonObject[i]));
  }
  return (isi);
}

Future<Uint8List> generatePDF(PdfPageFormat format, var filepdf) async {
  await Printing.layoutPdf(onLayout: (_) => filepdf);

  return filepdf;
}
