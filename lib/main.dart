import 'dart:html' as html;
import 'dart:async';
import 'dart:convert';
// import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Dokumen> createDokumen(int jenis, String noreg) async {
  // print("createDokumen");
  final msg = jsonEncode({"noreg": noreg, "jenis": jenis});
  // print(msg);
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/text'),
    // Uri.parse('https://webhook.site/c502765b-dfce-405b-8bb3-b2c9c556ed43'),
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

  void pilihJenis(String value) {
    setState(() {
      _jenisDokumen = value;
    });
  }

  GlobalKey _formKey = new GlobalKey();

  List jenisDokumen = [
    "KTP",
    "Kartu Keluarga",
    "SIM",
  ];

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();
  }

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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 50, right: 145),
                                  child: Text("Nomor Registrasi",
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ]),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
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
                              ), //padding
                            ],
                          )
                        ],
                      ),
                      Column(children: [
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50, right: 160),
                            child: Text("Jenis Dokumen",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20)),
                          )
                        ]),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: DropdownButton(
                                      hint: Text("Pilih Jenis Dokumen"),
                                      dropdownColor: Colors.white,
                                      icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      value: _jenisDokumen,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _jenisDokumen = newValue!;
                                          indexDokumen = jenisDokumen
                                                  .indexOf(_jenisDokumen) +
                                              1;
                                        });
                                        print(indexDokumen);
                                      },
                                      items: jenisDokumen.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        ); //DropdownMenuItem
                                      }).toList(),
                                    ),
                                  ), //DropdownButton
                                ) //Container
                                ) //Padding
                          ],
                        ) //Row
                      ]) //Column
                    ],
                  ), //Row Baris Utama 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [Text("Dua Satu")]),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: Container(
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  createDokumen(indexDokumen, noreg.text);
                                });
                              },
                              label: Text('Tambah'),
                            ),
                          ),
                        )
                      ])
                    ],
                  ) // Row Baris Utama 2
                ],
              ),
            ),
            // buatpreview
          ],
        ));
  }
}
