import 'dart:html';
import 'dart:js';
import 'dart:typed_data';

import 'package:akad/controller/c_detail.dart';
import 'package:akad/view_model/vm_detail.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


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
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<DetailVM>.reactive(
        viewModelBuilder: () => DetailVM(),
        builder: (context, model, child) => Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: model.formkey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text("Nomor Registrasi",
                            style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                            height: 50,
                            width: 300,
                            child: TextField(
                              controller: model.noreg,
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
                              onPressed: () => model.pilihFile(),
                              child: Text("Upload file")
                            ),
                          Container(
                            height: 30,
                            width: 215,
                            padding: const EdgeInsets.all(5),
                            margin : const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)
                            ),
                            child: Text(model.fileName),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
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
                              value: model.jenis,
                              onChanged: (newValue) =>
                                  model.pilihJenisDokumen(newValue),
                              items: model.jenisDokumen.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: Text(valueItem),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () => createDokumen(
                              model.indexDokumen,
                              model.noreg.text,
                              model.fileBytes,
                              model.fileName),
                          label: Text('Tambah'),
                        ),
                      )
                    ],
                  ) // Row Baris Utama 2
                ],
              ),
            ),
            Container(
                child:
                    (model.fileBytes == null)
                    ? Text("kosong")
                    : Container(
                      // width: 500,
                          // height: 350,
                          // padding: const EdgeInsets.all(25),
                          // margin: const EdgeInsetsDirectional.all(25),
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          //   image: new DecorationImage(
                          //     fit: BoxFit.contain,
                          //     image: MemoryImage(model.fileBytes),
                          //   )
                          // ),
                          width: 500,
                          height: 350,
                          margin: const EdgeInsetsDirectional.all(5),
                        //if (picked == '.jpg'){
                        //return image;
                        //} 
                        //else (pilihFile == '.pdf' && '.doc'){
                        // return PdfPreview
                        // }
                        child: 
                          PdfPreview(
                            build: (newFile) => _generatePdf(newFile, model.fileBytes),
                            )
                      )
            ),
          ],
        ),
      )),
    );
  }
}


Future<Uint8List> _generatePdf(PdfPageFormat format, var filepdf) async {    
    await Printing.layoutPdf(onLayout: (_) => filepdf);

    return filepdf;
}
