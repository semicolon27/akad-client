import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:akad/pages/template.dart';

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
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
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
                                  // jangan di print, banyak banget wkwkwk
                                  // print(fileBytes);
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
            // TODO: container dibungkus pakai widget SingleChildScrollView() agar tidak ada error overflow
            Container(
                child: (fileBytes == null)
                    ? Text("kosong")
                    // TODO: Bikin preview sesuai dengan format filenya
                    // Kalau extensinya png, jpg, dsb load image (seperti dibawah) dan set ukuran imagenya agar saat preview tidak memenuhi layar
                    // Kalau PDF pakai PDF Viewer, bisa pakai => https://pub.dev/packages/advance_pdf_viewer
                    : Container(
                        width: 450,
                        height: 450,
                        decoration: BoxDecoration(
                            image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(fileBytes),
                        )),
                      ))
            // buatpreview
          ],
        ),
      ),
    );
  }
}

Future<Dokumen> createDokumen(int jenis, String noreg, var file) async {
  String base64code = base64.encode(file);

  final msg = jsonEncode({"noreg": noreg, "jenis": jenis, "file": base64code});
  final response = await http.post(
    // Uri.parse('http://127.0.0.1:8000/text'),
    Uri.parse('https://webhook.site/c502765b-dfce-405b-8bb3-b2c9c556ed43'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: msg,
  );
  if (response.statusCode == 201) {
    // print("status 201");
    return Dokumen.fromJson(jsonDecode(response.body));
  } else {
    // print("gagal");
    throw Exception('Gagal membuat dokumen');
  }
}

class Dokumen {
  final int id;
  final int jenis;
  final String noreg;

  Dokumen({required this.id, required this.jenis, required this.noreg});

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    print("factory fromJson");
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: json['id'],
        jenis: json['jenis'],
        noreg: json['noreg']);
  }
}
