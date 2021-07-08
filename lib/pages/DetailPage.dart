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
      body: ViewModelBuilder<DokumenVM>.reactive(
          viewModelBuilder: () => DokumenVM(),
          onModelReady: (vm) => vm.init(Get.parameters['id'].toString()),
          builder: (context, model, child) => !model.busy(model.data)
              ? SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(100, 60, 160, 90),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 10,
                      )
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[  
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Text("Nomor Registrasi",
                                  style: TextStyle(fontSize: 20)),
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                                child: Text(model.data.first.noreg,
                                style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Text("Keterangan Dokumen",
                                style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                child: (model.data.first.keterangan == '')
                                  ? Text("-")
                                    : Text(model.data.first.keterangan ?? "",
                                      style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                  child: Text("Jenis Dokumen",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                                  child: Text(model.data.first.jenis,
                                  style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                child: Text("File Dokumen",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 82.5),
                                child: Text(model.data.first.nama,
                                style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),      
                          Container(
                            margin: EdgeInsets.only(left: 82.5),
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
                                          height: 400,
                                          margin:
                                              const EdgeInsetsDirectional.all(25),
                                          child:
                                              Image.memory(model.data.first.file))),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(380, 5, 100, 5)),
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
                        ],
                      ),
                    ),
                  ),
                )
              : Text("loading...")),
    ));
  }
}
