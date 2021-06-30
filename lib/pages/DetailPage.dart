import 'package:akad/controller/c_detail.dart';
import 'package:akad/models/dokumen.dart';
import 'package:akad/view_model/vm_detail.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class DetailDokumen extends StatefulWidget {
  DetailDokumen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailDokumenState createState() => _DetailDokumenState();
}

class _DetailDokumenState extends State<DetailDokumen> {
  @override
  Widget build(BuildContext context) {
    return TemplateWidget(
        child: Scaffold(
      body: ViewModelBuilder<DetailVM>.reactive(
        viewModelBuilder: () => DetailVM(),
        builder: (context, model, child) => FutureBuilder<List<Dokumen>>(
            // child: FutureBuilder<List<Doklist>>(
            future: readDokumen(Get.parameters['id']),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(child: Text("Loading"));
              } else
                return Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("Nomor Registrasi",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(snapshot.data!.first.noreg,
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("File",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(snapshot.data!.first.nama,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("Jenis Dokumen",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(snapshot.data!.first.jenis,
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      //icon: Icon(Icons.edit),
                                      onPressed: () => {},
                                      child: Text('Edit'),
                                    ),
                                    ElevatedButton(
                                      //icon: Icon(Icons.edit),
                                      onPressed: () => {},
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ) // Row Baris Utama 2
                        ],
                      ),
                    ),
                    Container(
                        child: (snapshot.data!.first.extension == 'pdf')
                            ? Container(
                                width: 650,
                                height: 400,
                                margin: const EdgeInsetsDirectional.all(25),
                                child: PdfPreview(
                                  build: (newFile) => generatePDF(
                                      newFile, snapshot.data!.first.file),
                                ))
                            : Container(
                                width: 650,
                                height: 350,
                                margin: const EdgeInsetsDirectional.all(25),
                                child: Image.memory(snapshot.data!.first.file)))
                    // buatpreview
                  ],
                );
            }),
      ),
    ));
  }
}
