import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;

  const TextFormWidget(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    );
  }
}
