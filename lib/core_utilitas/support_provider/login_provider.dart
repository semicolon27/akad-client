import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  bool _isLogin = false;
  String? _nama;
  String? _userId;
  String? _passId;
  double? _batch;
  String? _akses;
  String? _levelx;
  String? _kdcab;
  String? _kdkas;
  String? _kdloc;
  String? _sbbkas;
  String? _kantor;

  fromMap(Map<String, dynamic> map) {
    isLogin = map['isLogin'];
    nama = map['nama'];
    userId = map['userId'];
    passId = map['passId'];
    batch = map['batch'];
    akses = map['akses'];
    levelx = map['levelx'];
    kdcab = map['kdcab'];
    kdkas = map['kdkas'];
    kdloc = map['kdloc'];
    sbbkas = map['sbbkas'];
    kantor = map['kantor'];

    notifyListeners();
  }

  String? get sbbkas => _sbbkas;

  set sbbkas(String? value) {
    _sbbkas = value;
  }

  String? get kdloc => _kdloc;

  set kdloc(String? value) {
    _kdloc = value;
  }

  String? get kdkas => _kdkas;

  set kdkas(String? value) {
    _kdkas = value;
  }

  String? get kdcab => _kdcab;

  set kdcab(String? value) {
    _kdcab = value;
  }

  String? get levelx => _levelx;

  set levelx(String? value) {
    _levelx = value;
  }

  String? get akses => _akses;

  set akses(String? value) {
    _akses = value;
  }

  double? get batch => _batch;

  set batch(double? value) {
    _batch = value;
  }

  String? get passId => _passId;

  set passId(String? value) {
    _passId = value;
  }

  String? get userId => _userId;

  set userId(String? value) {
    _userId = value;
  }

  String? get nama => _nama;

  set nama(String? value) {
    _nama = value;
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }

  String? get kantor => _kantor;

  set kantor(String? value) {
    _kantor = value;
  }
}
