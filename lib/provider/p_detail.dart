import 'package:flutter/widgets.dart';

class UtamaProvider extends ChangeNotifier {
  String userid = '';
  String userpass = '';

  void setValue(String data) {
    this.userid = data;
    notifyListeners();
  }
}
