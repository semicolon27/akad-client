import 'package:get/get.dart';
import 'package:akad/window/wd_detail.dart';

String routeUtama = '/detail';

List<GetPage> pages = [
  GetPage(
    name: routeUtama,
    page: () => DetailDokumen(),
    // parameter: {'title': 'Login'},
  ),
  GetPage(name: '/dokumen', page: () => DetailDokumen())
];
