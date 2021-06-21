import 'package:flutter/foundation.dart';

class TermsProvider with ChangeNotifier{
  bool check = false;

  set checkTerms(bool check) {
    this.check = check;
    notifyListeners();
  }

  bool get checkTerms => check;

}