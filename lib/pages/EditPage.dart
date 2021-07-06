import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/view_model/vm_edit.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class UpdateDokumen extends StatefulWidget {
  UpdateDokumen({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateDokumenState createState() => _UpdateDokumenState();
}

class _UpdateDokumenState extends State<UpdateDokumen> {
  @override
  Widget build(BuildContext context) {
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<UpdateVM>.reactive(
        viewModelBuilder: () => UpdateVM(),
        onModelReady: (vm) => vm.init(Get.parameters['id'].toString()),
        builder: (context, model, child) => !model.busy(model.data)
            ? SingleChildScrollView(
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
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("Nomor Registrasi",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Container(
                                    //height: 50,
                                    width: 300,
                                    child: TextFormField(
                                      controller: model.noreg,
                                      decoration: InputDecoration(
                                        hintText: 'Masukan Nomor Registrasi',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("Keterangan Dokumen",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Container(
                                    width: 300,
                                    child: TextFormField(
                                      controller: model.keterangan,
                                      decoration: InputDecoration(
                                        hintText: '(Opsional)',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Text("Jenis Dokumen",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Container(
                                    width: 300,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                      ),
                                      hint: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text("Pilih Jenis Dokumen",
                                              style: TextStyle(fontSize: 16))),
                                      icon: Icon(Icons.arrow_drop_down),
                                      isExpanded: true,
                                      onChanged: (newValue) {
                                        model.pilihJenisDokumen(newValue);
                                      },
                                      value: model.jenisDok,
                                      items:
                                          model.jenisDokumen.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(valueItem)),
                                        );
                                      }).toList(),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text("File Dokumen",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(children: [
                                  Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                        )),
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      model.data.first.nama,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => model.pilihFile(),
                                    child: Text("Pilih File"),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 22),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ) // Row Baris Utama 2
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(10)),
                        ElevatedButton(
                          onPressed: () {
                            updateDokumen(
                                Get.parameters['id'].toString(),
                                model.indexDokumen,
                                model.noreg.text,
                                model.data.first.file,
                                model.data.first.nama,
                                model.keterangan.text);

                            Get.offAllNamed('/home');
                          },
                          child: Text('Edit'),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'),
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
                                    margin: const EdgeInsetsDirectional.all(25),
                                    child: PdfPreview(
                                      build: (newFile) => generatePDF(
                                          newFile, model.data.first.file),
                                    ))
                                : Container(
                                    width: 650,
                                    height: 350,
                                    margin: const EdgeInsetsDirectional.all(25),
                                    child: Image.memory(model.data.first.file)))
                  ],
                ),
              )
            : Text("Loading..."),
      )),
    );
  }
}
