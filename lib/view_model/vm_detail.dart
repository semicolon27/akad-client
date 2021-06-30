import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailVM extends BaseViewModel {
  GlobalKey formkey = GlobalKey();
  final TextEditingController noreg = TextEditingController();
  final doc = pw.Document();
  var fileBytes;
  var fileExtension;
  var indexDokumen;
  var jenis;
  // ignore: unused_field

  // int? indexDokumen;
  // String? jenis;
  String fileName = "File belum dipilih";
  List jenisDokumen = [
    "KTP",
    "Kartu Keluarga",
    "SIM",
  ];

  void pilihFile() async {
    var picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (picked != null) {
      fileExtension = picked.files.first.extension;
      fileBytes = picked.files.first.bytes;
      fileName = picked.files.first.name;
      notifyListeners();
    } else {}
  }

  void pilihJenisDokumen(var newValue) {
    jenis = newValue;
    indexDokumen = jenisDokumen.indexOf(jenis) + 1;
    notifyListeners();
  }
}
