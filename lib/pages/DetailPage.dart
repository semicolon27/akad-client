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
    return TemplateWidget(
          child: Scaffold(
              body: ViewModelBuilder<DetailVM>.reactive(
                viewModelBuilder: () => DetailVM(),
                builder: (context, model, child) => SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: model.formkey,
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [ 
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ Padding(
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
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Row(children: [
                              ElevatedButton(
                                  onPressed: () => model.pilihFile(),
                                  child: Text("Upload File")
                              ),
                              Container(
                                width: 210,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(5),
                                child:
                                 Text(model.fileName),
                              ),
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
                                    Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
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
                                  onChanged: (newValue) => model.pilihJenisDokumen(newValue),
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
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                                  onPressed: () => createDokumen(
                                      model.indexDokumen,
                                      model.noreg.text,
                                      model.fileBytes,
                                      model.fileName),
                                  child: Text('Tambah'),
                                  
                                ),
                          )
                        ],
                      ) 
                  ],
                  ),
                ),
                Container(
                    child: (model.fileBytes == null)
                        ? Text(" ")
                        : (model.fileExtension == 'pdf')
                            ? Container(
                                width: 650,
                                height: 400,
                                margin: const EdgeInsetsDirectional.all(20),
                                child: 
                                PdfPreview(
                                  build: (newFile) =>
                                      generatePDF(newFile, model.fileBytes),
                                )
                              )
                            : Container(
                                width: 650,
                                height: 350,
                                margin: const EdgeInsetsDirectional.all(20),
                                child:
                                  Image.memory(model.fileBytes)
                              )
                )
              ],
                ),
                )
              )
          ),
    );
  }
}
