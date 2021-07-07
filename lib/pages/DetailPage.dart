import 'package:akad/controller/c_Dokumen.dart';
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
          onModelReady: (vm) => vm.init(Get.parameters['id'].toString()),
          builder: (context, model, child) => !model.busy(model.data)
              ? SingleChildScrollView(
                  child: Container(
                    
                    child: Column(
                      children: [
                        Row(
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
                                  child: Text(model.data.first.noreg,
                                      style: TextStyle(fontSize: 18)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Text("Keterangan Dokumen",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: (model.data.first.keterangan == '')
                                      ? Text("-")
                                      : Text(model.data.first.keterangan ?? "",
                                          style: TextStyle(fontSize: 18)),
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
                                  child: Text(model.data.first.jenis,
                                      style: TextStyle(fontSize: 18)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Text("File Dokumen",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(model.data.first.nama,
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ],
                            ) // Row Baris Utama 2
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            ElevatedButton(
                              onPressed: () => {
                                Get.toNamed(
                                    '/edit/${Get.parameters['id'].toString()}')
                              },
                              child: Text('Edit'),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                deleteDokumen(Get.parameters['id'].toString());
                                Get.offAllNamed('/home');
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                        Container(
                            child: (model.data.first.file == null)
                                ? Text(" ")
                                : (model.data.first.extension == 'pdf')
                                    ? Container(
                                        width: 650,
                                        height: 400,
                                        margin:
                                            const EdgeInsetsDirectional.all(25),
                                        child: PdfPreview(
                                          build: (newFile) => generatePDF(
                                              newFile, model.data.first.file),
                                        ))
                                    : Container(
                                        width: 650,
                                        height: 350,
                                        margin:
                                            const EdgeInsetsDirectional.all(25),
                                        child:
                                            Image.memory(model.data.first.file)))
                      ],
                    ),
                  ),
                )
              : Text("loading...")),
    ));
  }
}
