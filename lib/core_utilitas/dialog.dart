import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showConfirmDialog({
  String title = "Konfirmasi",
  String subtitle = "",
  String textButtonYes = "Iya",
  String textButtonNo = "Tidak",
  TextStyle? styleTextYes,
  TextStyle? styleTextNo,
}) async {
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      TextButton(
        onPressed: () => Get.back(result: true),
        child: Text(
          textButtonYes,
          style: styleTextYes,
        ),
      ),
      TextButton(
        onPressed: () => Get.back(result: false),
        child: Text(
          textButtonNo,
          style: styleTextNo,
        ),
      ),
    ],
  );

  return await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> showNormalDialog({
  String title = "Pesan",
  String subtitle = "",
  String textButton = "Iya",
  TextStyle? styleText,
}) async {
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      TextButton(
        onPressed: () => Get.back(result: true),
        child: Text(
          textButton,
          style: styleText,
        ),
      ),
    ],
  );

  return await showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
