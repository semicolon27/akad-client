import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/models/dokumen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/widgets.dart' as pw;

class UpdateVM extends BaseViewModel {
  GlobalKey formkey = GlobalKey();
  final TextEditingController noreg = TextEditingController();
  var status;
  var indexDokumen;

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
      _data.first.extension = picked.files.first.extension;
      _data.first.file = picked.files.first.bytes;
      _data.first.nama = picked.files.first.name;
      notifyListeners();
    } else {}
  }

  void pilihJenisDokumen(var newValue) {
    _data.first.jenis = newValue;
    indexDokumen = jenisDokumen.indexOf(_data.first.jenis) + 1;
    notifyListeners();
  }

  List<Dokumen> _data = [];
  List<Dokumen> get data => _data;
  set data(List<Dokumen> v) {
    _data = v;
    notifyListeners();
  }

  void getDokumen(String id) async {
    // setStatus("edit");
    setBusyForObject(_data, true);
    _data = await readDokumen(id);
    noreg.text = _data.first.noreg;
    pilihJenisDokumen(_data.first.jenis);
    setBusyForObject(_data, false);
    notifyListeners();
  }

  // void setStatus(String value) {
  //   status = value;
  //   notifyListeners();
  // }

  void init(String? id) {
    getDokumen(id!);
  }
}
