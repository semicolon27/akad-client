import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/controller/c_JenisDokumen.dart';
import 'package:akad/models/dokumen.dart';
import 'package:akad/models/jenisDokumen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UpdateVM extends BaseViewModel {
  GlobalKey formkey = GlobalKey();
  final TextEditingController noreg = TextEditingController();
  final TextEditingController keterangan = TextEditingController();
  var indexDokumen;

  List jenisDokumen = ["Kartu"];

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
    for (int i = 0; i < _jenis.length; i++) {
      if (_jenis[i].singkatan == newValue) {
        indexDokumen = _jenis[i].id;
      }
    }
    notifyListeners();
  }

  List<Dokumen> _data = [];
  List<Dokumen> get data => _data;
  set data(List<Dokumen> v) {
    _data = v;
    notifyListeners();
  }

  List<Dokumen> _oldData = [];
  List<Dokumen> get listDokumen => _oldData;
  set listDokumen(List<Dokumen> v) {
    _oldData = v;
    notifyListeners();
  }

  void getDokumen(String id) async {
    // setStatus("edit");
    setBusyForObject(_data, true);
    _data = await readDokumen(id);
    _oldData = _data;
    noreg.text = _data.first.noreg;
    keterangan.text = _data.first.keterangan!;
    pilihJenisDokumen(_data.first.jenis);
    setBusyForObject(_data, false);
    notifyListeners();
  }

  List<JenisDokumen> _jenis = [];
  List<JenisDokumen> get jenis => _jenis;
  set jenis(List<JenisDokumen> v) {
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

  void init(String id) {
    getJenisDokumen();
    getDokumen(id);
  }
}
