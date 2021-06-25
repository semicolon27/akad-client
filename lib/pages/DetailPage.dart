import 'package:akad/controller/c_detail.dart';
import 'package:akad/view_model/vm_detail.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
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
                              child: Text("Upload file")),
                          Text(model.fileName)
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
                child: (model.fileBytes == null)
                    ? Text("kosong")
                    : (model.fileExtension == 'pdf')
                        ? Container(
                            width: 500,
                            height: 350,
                            margin: const EdgeInsetsDirectional.all(5),
                            child: PdfPreview(
                              build: (newFile) =>
                                  generatePDF(newFile, model.fileBytes),
                            ))
                        : Image.memory(model.fileBytes))
            // buatpreview
          ],
        ),
      )),
    );
  }
}
