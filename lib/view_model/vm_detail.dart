import 'dart:convert';
import 'dart:typed_data';

import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/controller/c_JenisDokumen.dart';
import 'package:akad/models/dokumen.dart';
import 'package:akad/models/jenisDokumen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DokumenVM extends BaseViewModel {
  // Variabel
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController noreg = TextEditingController();
  final TextEditingController keterangan = TextEditingController();
  String fileName = "File belum dipilih";
  List jenisDokumen = ["Kartu"];
  String jenisDok = "";
  int idJenis = 0;

  // Function manipulasi data
  String getExtension(String nama) {
    var ext = nama.split('.');
    return ext.last;
  }

  Uint8List getFile(DokumenClass data) {
    String base64 =
        """${data.part1}${data.part2}${data.part3}${data.part4}${data.part5}${data.part6}${data.part7}${data.part8}""";
    Uint8List decodedBytes = base64Decode(base64);
    return decodedBytes;
  }

  void pilihJenisDokumen(var newValue) {
    for (int i = 0; i < _jenis.length; i++) {
      if (_jenis[i].singkatan == newValue) {
        idJenis = _jenis[i].id;
      }
    }
    jenisDok = newValue;
    notifyListeners();
  }

  void pilihFile() async {
    var picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (picked != null && _data != null) {
      // _data.first.file = picked.files.first.bytes;
      _data!.dokumen.nama = picked.files.first.name;
      notifyListeners();
    } else {}
  }
  // end manipulasi data

  // function Controller
  Future<String> toUpdate(String idDokumen, int idJenis, String noreg, var file,
      String namaFile, String keterangan) async {
    var response = await updateDokumen(
        idDokumen, idJenis, noreg, file, namaFile, keterangan);
    if (response.statusCode == 201) {
      Dokumen hasil = Dokumen.fromJson(jsonDecode(response.data));
      return "Berhasil update dokumen dengan nomor registrasi ${hasil.dokumen.noreg}";
    } else {
      throw Exception('Gagal update dokumen');
    }
  }
  // end function controller

  // Initial function get Data
  Dokumen? _data;
  Dokumen? get data => _data;
  set data(Dokumen? v) {
    _data = v;
    notifyListeners();
  }
 
  void getDokumen(String id) async {
    setBusyForObject(_data, true);
    _data = await readDokumen(id);
    noreg.text = _data?.dokumen.noreg ?? "";
    keterangan.text = _data?.dokumen.keterangan ?? "";
    pilihJenisDokumen(_data?.singkatan);
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
    getDokumen(id);
    getJenisDokumen();
  }
}
