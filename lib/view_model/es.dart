import 'dart:html' as html;
import 'dart:async';
import 'dart:convert';
// import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Dokumen> createDokumen(int jenis, String noreg, var file) async {
  Dio dio = Dio();
  var formData = FormData.fromMap({
    'noreg': noreg,
    'jenis': jenis,
    'file': await MultipartFile.fromBytes(file, filename: 'upload.txt'),
  });

  Response responses = await dio.post(
      'https://webhook.site/c502765b-dfce-405b-8bb3-b2c9c556ed43',
      data: formData);

  if (responses.statusCode == 201) {
    // print("status 201");
    return Dokumen.fromJson(jsonDecode(responses.data));
  } else {
    // print("gagal");
    throw Exception('Gagal membuat dokumen');
  }
}

class Dokumen {
  final int id;
  final int jenis;
  final String noreg;
  final file;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.noreg,
      required this.file});

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    print("factory fromJson");
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: json['id'],
        jenis: json['jenis'],
        noreg: json['noreg'],
        file: json['file']);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController noreg = TextEditingController();
  late int indexDokumen;
  var _jenisDokumen;
  var fileBytes;
  String fileName = "File belum dipilih";
  GlobalKey _formKey = new GlobalKey();

  void pilihJenis(String value) {
    setState(() {
      _jenisDokumen = value;
    });
  }

  List jenisDokumen = [
    "KTP",
    "Kartu Keluarga",
    "SIM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AKAD"),
        ),
        body: Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("Nomor Registrasi",
                            style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: noreg,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Masukan Inputan',
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(children: [
                          ElevatedButton(
                              onPressed: () async {
                                var picked =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'jpg',
                                    'jpeg',
                                    'png',
                                    'pdf'
                                  ],
                                );
                                if (picked != null) {
                                  setState(() {
                                    fileBytes = picked.files.first.bytes;
                                    fileName = picked.files.first.name;
                                  });

                                  print(fileBytes);
                                }
                              },
                              child: Text("Upload file")),
                          Text(fileName)
                        ]),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("Jenis Dokumen",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: DropdownButton(
                              hint: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: Text("Pilih Jenis Dokumen"),
                              ),
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              underline: SizedBox(),
                              value: _jenisDokumen,
                              onChanged: (newValue) {
                                setState(() {
                                  _jenisDokumen = newValue!;
                                  indexDokumen =
                                      jenisDokumen.indexOf(_jenisDokumen) + 1;
                                });
                                print(indexDokumen);
                              },
                              items: jenisDokumen.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              createDokumen(
                                  indexDokumen, noreg.text, fileBytes);
                            });
                          },
                          label: Text('Tambah'),
                        ),
                      )
                    ],
                  ) // Row Baris Utama 2
                ],
              ),
            ),
            Container(
                child: (fileBytes == null)
                    ? Text("kosong")
                    : Image.memory(fileBytes))
            // buatpreview
          ],
        ));
  }
}
