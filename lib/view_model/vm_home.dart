import 'package:akad/controller/c_detail.dart';
import 'package:akad/models/doklist.dart';
import 'package:stacked/stacked.dart';

class HomeVM extends BaseViewModel {
  List<Doklist> data = [];

  void getDataDokumen() async {
  //Future<Doklist> getDataDokumen() async {
    data = await readDoklist();
    notifyListeners();
  }
  
  List<Doklist> _listTodo = [];
  List<Doklist> get listTodo => _listTodo;
  set listTodo(List<Doklist> v) {
    _listTodo = v;
    notifyListeners();
  }

  void init() {
    _listTodo = data;
  }
  
  void filterData(String keyword) {
    _listTodo = data.where((element) => 
      element.noreg.contains(keyword)).toList();
    notifyListeners();
  }
}
