import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jenisDokumen = ["KTP", "SIM", "KK"];
  String _jenisDokumen = "KTP";

  late List<int> _selectedFile;
  late Uint8List _bytesData;

  GlobalKey _formKey = new GlobalKey();

  void pilihJenis(String value) {
    setState(() {
      _jenisDokumen = value;
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future makeRequest() async {
    var url = Uri.parse("http://127.0.0.1:8000/");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up"));

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();
      reader.onLoadEnd.listen((e) {
        _handleResult(reader);
      });
      reader.readAsDataUrl(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tester"),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  decoration: InputDecoration(
                hintText: "No. Registrasi",
              )),
              DropdownButton<String>(
                  value: _jenisDokumen,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurple,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _jenisDokumen = newValue!;
                    });
                  },
                  items: <String>['KTP', 'KK', 'SIM']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              MaterialButton(
                color: Colors.deepPurple,
                elevation: 8,
                highlightElevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textColor: Colors.white,
                child: Text('Choose File'),
                onPressed: () {
                  startWebFilePicker();
                },
              ),
              Divider(
                color: Colors.teal,
              ),
              MaterialButton(
                color: Colors.purple,
                elevation: 8.0,
                textColor: Colors.white,
                onPressed: () {
                  makeRequest();
                },
                child: Text('Send file to server'),
              ),
            ],
          )),
    );
  }
}
