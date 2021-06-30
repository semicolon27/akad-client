import 'package:akad/controller/c_detail.dart';
import 'package:akad/models/doklist.dart';
import 'package:stacked/stacked.dart';

class HomeVM extends BaseViewModel {
  List<Doklist> _data = [];
  List<Doklist> get data => _data;
  set data(List<Doklist> v) {
    _data = v;
    notifyListeners();
  }

  void getDataDokumen() async {
    setBusyForObject(_listDokumen, true);
    _data = await readDoklist();
    _listDokumen = _data;
    setBusyForObject(_listDokumen, false);
    notifyListeners();
  }
  
  List<Doklist> _listDokumen = [];
  List<Doklist> get listDokumen => _listDokumen;
  set listDokumen(List<Doklist> v) {
    _listDokumen = v;
    notifyListeners();
  }

  void init() {
    getDataDokumen();
  }
  
  void filterData(String keyword) {
    print(_data);
    _listDokumen = data.where((element) => 
      element.noreg.contains(keyword)).toList();
    notifyListeners();
  }
}
