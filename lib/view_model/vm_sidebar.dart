import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SidebarVM extends BaseViewModel {
  String _active = "";
  String get active => _active;
  set active(value) {
    _active = value;
    notifyListeners();
  }

  String _extend = "";
  String get extend => _extend;
  set extend(value) {
    _extend = value;
    notifyListeners();
  }

  void init() {
    _active = Get.currentRoute;
    _extend = Get.currentRoute;
  }

  bool isActive(String route) {
    String currentRoute = Get.currentRoute;
    bool isRouteMatch = currentRoute.contains(route);
    return isRouteMatch;
  }

  bool isExtend(String route) {
    bool isRouteMatch = _extend.contains(route);
    return isRouteMatch;
  }
}
