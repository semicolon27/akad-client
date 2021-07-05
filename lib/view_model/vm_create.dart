import 'package:akad/controller/c_JenisDokumen.dart';
import 'package:akad/models/jenisDokumen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateVM extends BaseViewModel {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController noreg = TextEditingController();
  var fileBytes;
  var fileExtension;
  var indexDokumen;
  var jenis;
  String fileName = "File belum dipilih";
  List jenisDokumen = ["Kartu"];

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
    for (int i = 0; i < _jenis.length; i++) {
      if (_jenis[i].singkatan == newValue) {
        indexDokumen = _jenis[i].id;
      }
    }
    jenis = newValue;
    notifyListeners();
  }

  List<JenisDokumen> _jenis = [];
  List<JenisDokumen> get jenisDok => _jenis;
  set jenisDok(List<JenisDokumen> v) {
    _jenis = v;
    notifyListeners();
  }

  void getJenisDokumen() async {
    setBusyForObject(_jenis, true);
    _jenis = await readJenisDokumen();
    jenisDokumen.clear();
    for (int i = 0; i < _jenis.length; i++) {
      jenisDokumen.add(_jenis[i].singkatan);
    }
    setBusyForObject(_jenis, false);
    notifyListeners();
  }

  void init() {
    getJenisDokumen();
  }
}
