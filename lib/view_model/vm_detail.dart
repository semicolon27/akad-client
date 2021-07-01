import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/models/dokumen.dart';
import 'package:stacked/stacked.dart';

class DetailVM extends BaseViewModel {
  List<Dokumen> _data = [];
  List<Dokumen> get data => _data;
  set data(List<Dokumen> v) {
    _data = v;
    notifyListeners();
  }

  void getDokumen(String id) async {
    setBusyForObject(_data, true);
    _data = await readDokumen(id);
    setBusyForObject(_data, false);
    notifyListeners();
  }

  void init(String id) {
    getDokumen(id);
  }
}
