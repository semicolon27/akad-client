import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:akad/core_widget/navigation/navigation_widget.dart';

class TemplateVM extends BaseViewModel {
  bool _isExtended = false;

  bool get isExtended => _isExtended;

  set isExtended(bool value) {
    _isExtended = value;
  }

  List _listIcon = [
    "Dashboard",
    "CIF",
    "Deposito",
    "Deposito",
    "Pembiayaan",
    "rahn",
    "Money changer",
    "inventaris",
    "Treasury",
    "Mitra kerja",
    "Manajemen",
    "Transaksi",
    "Group 7",
  ];
}
