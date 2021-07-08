import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/view_model/vm_detail.dart';
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
    void showAlert(String message) {
      AlertDialog alert = AlertDialog(
        title: Text("Data Tidak Lengkap"),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("ok"),
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<DokumenVM>.reactive(
              viewModelBuilder: () => DokumenVM(),
              onModelReady: (vm) => vm.init(Get.parameters['id'].toString()),
              builder: (context, model, child) => SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(100, 40, 160, 90),
                      padding: EdgeInsets.fromLTRB(40, 30, 20, 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 10)),
                              Expanded(
                                child: Text("Formulir Tambah Data",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: model.formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Text("Nomor Registrasi ",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 19),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                          //height: 50,
                                          width: 500,
                                          child: TextFormField(
                                            controller: model.noreg,
                                            decoration: InputDecoration(
                                              hintText: 'Masukan Inputan',
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                //return '';
                                              }
                                              //return null;
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Text("Keterangan Dokumen ",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                          //height: 50,
                                          width: 500,
                                          child: TextFormField(
                                            controller: model.keterangan,
                                            // onChanged: (String val) {
                                            //   model.setNoregField(val);
                                            // },
                                            decoration: InputDecoration(
                                              hintText: 'Masukan Inputan',
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                //return '';
                                              }
                                              //return null;
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Text("Jenis Dokumen ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 27),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Container(
                                          //height: 50,
                                          width: 500,
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            hint: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Text(
                                                    "Pilih Jenis Dokumen",
                                                    style: TextStyle(
                                                        fontSize: 16))),
                                            icon: Icon(Icons.arrow_drop_down),
                                            isExpanded: true,
                                            onChanged: (newValue) {
                                              model.pilihJenisDokumen(newValue);
                                              // model.jenis = Value;
                                            },
                                            value: model.jenisDok,
                                            items: model.jenisDokumen
                                                .map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Text(valueItem)),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Text("File Dokumen",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 37),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(children: [
                                        Container(
                                          height: 50,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.grey,
                                              )),
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(right: 5),
                                          child: Text(
                                            model.fileName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
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
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: (model.getExtension(
                                        model.data.dokumen.nama) ==
                                    'pdf')
                                ? Container(
                                    width: 650,
                                    height: 400,
                                    margin: const EdgeInsetsDirectional.all(25),
                                    child: PdfPreview(
                                      build: (newFile) => generatePDF(newFile,
                                          model.getFile(model.data.dokumen)),
                                    ))
                                : Container(
                                    width: 650,
                                    height: 350,
                                    margin: const EdgeInsetsDirectional.all(25),
                                    child: Image.memory(
                                        model.getFile(model.data.dokumen)),
                                  ),
                          ),
                          Container(
                            width: 650,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    var hasil = model.toUpdate(
                                        Get.parameters['id'].toString(),
                                        model.idJenis,
                                        model.noreg.text,
                                        model.getFile(model.data.dokumen),
                                        model.data.dokumen.nama,
                                        model.keterangan.text);

                                    Get.offAllNamed('/home', arguments: hasil);
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
                          ),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
