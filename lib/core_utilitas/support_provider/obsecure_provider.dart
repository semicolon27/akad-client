import 'package:flutter/foundation.dart';

class PasswordProvider with ChangeNotifier{
  bool obsText = true;

  set obscureText(bool obsText) {
    this.obsText = obsText;
    notifyListeners();
  }

  bool get obsecureText => obsText;
}