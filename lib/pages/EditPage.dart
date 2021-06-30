import 'package:akad/controller/c_detail.dart';
import 'package:akad/view_model/vm_create.dart';
import 'package:akad/view_model/vm_detail.dart';
import 'package:flutter/material.dart';

import 'package:akad/pages/template.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

class EditDokumen extends StatefulWidget {
  EditDokumen({
    Key? key,
  }) : super(key: key);

  @override
  _EditDokumenState createState() => _EditDokumenState();
}

class _EditDokumenState extends State<EditDokumen> {
  @override
  Widget build(BuildContext context) {
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<CreateVM>.reactive(
        viewModelBuilder: () => CreateVM(),
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
                            height: 50, width: 300, child: Text("noreg")),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text("nama file")),
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
                              height: 50, width: 300, child: Text("jenis"))),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, right: 15),
                          child: ElevatedButton(
                            //icon: Icon(Icons.edit),
                            onPressed: () => createDokumen(
                                model.indexDokumen,
                                model.noreg.text,
                                model.fileBytes,
                                model.fileName),
                            child: Text('Edit'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                            // icon: Icon(Icons.delete),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () => createDokumen(
                                model.indexDokumen,
                                model.noreg.text,
                                model.fileBytes,
                                model.fileName),
                            child: Text('Delete'),
                          ), //elevated
                        ),
                      ]),
                    ],
                  ) // 
                ],
              ),
            ),
            Container(
                child: (model.fileBytes == null)
                    ? Text(" ")
                    : (model.fileExtension == 'pdf')
                        ? Container(
                            width: 500,
                            height: 350,
                            margin: const EdgeInsetsDirectional.all(20),
                            child: PdfPreview(
                              build: (newFile) =>
                                  generatePDF(newFile, model.fileBytes),
                            ))
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
