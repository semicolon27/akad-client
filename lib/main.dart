import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
// import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

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
  MyHomePage({Key? key, }) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 var valueChoose;
  
  GlobalKey _formKey = new GlobalKey();

  List listItem = [
    "KTP", "Kartu Keluarga", "SIM", 
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
                            Padding(padding: EdgeInsets.only(top: 50, right: 145),
                              child:
                              Text("Nomor Registrasi", style: TextStyle(fontSize: 20)),
                            ),
                          ]
                        ),
                        Row(
                         //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: 
                            <Widget> [ Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              child: Container(
                              height: 50,
                              width: 300,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Masukan Inputan',
                                ) ,
                              )
                            ),
                            ), //padding
                          ],
                        )
                      ],
                    ),
                    Column(
                      children:[
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(top:50, right:160),
                              child:
                                Text("Jenis Dokumen",textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
                            )
                          ]
                        ),
                        Row(
                          children: [ Padding(
                            padding:EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: Container(
                              height: 50,
                              width:300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1)  
                              ),
                              child: DropdownButton(
                                hint: Text("Pilih Jenis Dokumen"),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                underline: SizedBox(),
                                value: valueChoose,
                                onChanged: (newValue){
                                  setState(() {
                                    valueChoose = newValue;
                                  });
                                },
                                items: listItem.map((valueItem){
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                    ); //DropdownMenuItem
                                }).toList(),
                               ), //DropdownButton
                             )  //Container
                          ) //Padding
                          ],
                        )//Row
                      ]
                    ) //Column
                  ],
                ), //Row Baris Utama 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Dua Satu")
                      ]
                    ),
                    Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: Container(
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                startWebFilePicker();
                              }, 
                              label: Text('Tambah'),
                              ),
                          ),
                        )
                      ]
                    )
                  ],
                ) // Row Baris Utama 2
              ],
            ),
          ),
          // buatpreview
        ],
      )
    );
  }
}
