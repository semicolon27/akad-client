import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController noreg = TextEditingController();
  final TextEditingController jenis = TextEditingController();
  Future<Dokumen>? _hasilDokumen;

  List<String> jenisDokumen = ["KTP", "SIM", "KK"];
  String _jenisDokumen = "KTP";
  late int indexDokumen;

  void pilihJenis(String value) {
    setState(() {
      _jenisDokumen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_hasilDokumen == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    print("buildColumn");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: noreg,
          decoration: InputDecoration(hintText: 'Enter noreg'),
        ),
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
              indexDokumen = jenisDokumen.indexOf(_jenisDokumen) + 1;
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
        ElevatedButton(
          onPressed: () {
            setState(() {
              _hasilDokumen = createDokumen(indexDokumen, noreg.text);
            });
          },
          child: Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Dokumen> buildFutureBuilder() {
    print("FutureBuilder");
    return FutureBuilder<Dokumen>(
      future: _hasilDokumen,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.noreg);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
