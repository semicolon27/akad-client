import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/view_model/vm_create.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class CreateDokumen extends StatefulWidget {
  CreateDokumen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateDokumenState createState() => _CreateDokumenState();
}

class _CreateDokumenState extends State<CreateDokumen> {


  @override
  Widget build(BuildContext context) {
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<CreateVM>.reactive(
              viewModelBuilder: () => CreateVM(),
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
                                        child: TextFormField(
                                          controller: model.noreg,
                                          decoration: InputDecoration(
                                            hintText: 'Masukan Inputan',
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.all(10),
                                          ),
                                          validator: (value) {
                                            if(value == null || value.isEmpty){
                                              return 'Please enter field';
                                            }
                                            return null; 
                                          },
                                        )
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Row(children: [
                                      ElevatedButton(
                                          onPressed: () => model.pilihFile(),
                                          child: Text("Upload file")),
                                      Container(
                                        // height: 0,
                                        width: 195,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.grey,
                                            )),
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(left: 5),
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
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: 
                                                  Colors.white),),  
                                          ),
                                          hint: Padding(padding: EdgeInsets.symmetric(horizontal:5),
                                            child: Text("Pilih Jenis Dokumen", style: TextStyle(fontSize: 16) )
                                          ),
                                          icon: Icon(Icons.arrow_drop_down),
                                          isExpanded: true,
                                          onChanged: (Value) async {
                                             setState(() { model.jenis = Value; });
                                          },
                                          value: model.jenis,
                                          items: model.jenisDokumen
                                          .map((valueItem){
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Padding(
                                                padding:EdgeInsets.symmetric(horizontal:5),
                                                child: Text(valueItem)),
                                            );
                                          }).toList(),
                                          validator: (valueItem) => valueItem == null
                                            ? 'Please choose an option' : null,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // if (model.formkey.currentState!.validate()) {
                                        //   //form is valid, proceed further
                                        //   //model.formkey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                                        // } else {
                                        //   // setState(() {
                                        //   //   _autovalidate = true; //enable realtime validation
                                        //   // });
                                          createDokumen(
                                            model.indexDokumen,
                                            model.noreg.text,
                                            model.fileBytes,
                                            model.fileName
                                          );
                                          Get.offAllNamed('/home');
                                        //}

                                        // createDokumen(
                                        //     model.indexDokumen,
                                        //     model.noreg.text,
                                        //     model.fileBytes,
                                        //     model.fileName);
                                        // Get.offAllNamed('/home');
                                      },
                                      child: Text('Tambah'),
                                    ),
                                  )
                                ],
                              ) // Row Baris Utama 2
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
                                      margin:
                                          const EdgeInsetsDirectional.all(25),
                                      child: PdfPreview(
                                        build: (newFile) => generatePDF(
                                            newFile, model.fileBytes),
                                      ),
                                    )
                                  : Container(
                                      width: 650,
                                      height: 350,
                                      margin:
                                          const EdgeInsetsDirectional.all(25),
                                      child: Image.memory(model.fileBytes),
                                    ),
                        )
                      ],
                    ),
                  ))),
    );
  }
}
