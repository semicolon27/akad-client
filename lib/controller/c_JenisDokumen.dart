import 'dart:convert';
import 'package:akad/constant.dart';
import 'package:akad/models/doklist.dart';
import 'package:akad/models/jenisDokumen.dart';
import 'package:http/http.dart' as http;

Future<List<JenisDokumen>> readJenisDokumen() async {
  String url = "$apiURL/getjenis";
  var response = await http.get(Uri.parse(url));
  var jsonObject = jsonDecode(response.body);
  List<JenisDokumen> isi = [];

  for (int i = 0; i < jsonObject.length; i++) {
    isi.add(JenisDokumen.getJenisDokumen(jsonObject[i]));
  }
  return (isi);
}
