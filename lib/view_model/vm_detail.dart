import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailVM extends BaseViewModel {
  GlobalKey formkey = GlobalKey();
  final TextEditingController noreg = TextEditingController();
  var fileBytes;
  var indexDokumen;
  var jenis;
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
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (picked != null) {
      fileBytes = picked.files.first.bytes;
      fileName = picked.files.first.name;
      notifyListeners();
    }
  }

  void pilihJenisDokumen(var newValue) {
    jenis = newValue;
    indexDokumen = jenisDokumen.indexOf(jenis) + 1;
    notifyListeners();
  }
}
