import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/core_utilitas/dialog.dart';
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
                    )),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Nomor Registrasi",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50),
                                child: Text(
                                  model.data?.dokumen.noreg ?? "",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Keterangan Dokumen",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15),
                                child: (model.data?.dokumen.keterangan == '')
                                    ? Text("-")
                                    : Text(
                                        model.data?.dokumen.keterangan ?? "",
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Jenis Dokumen",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 70,
                                ),
                                child: Text(
                                  model.data?.singkatan ?? "",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "File Dokumen",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 82.5),
                                child: Text(
                                  model.data?.dokumen.nama ?? "",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          if (model.data != null)
                            Container(
                              margin: EdgeInsets.only(left: 82.5),
                              child: (model.getExtension(
                                          model.data?.dokumen.nama ?? "") ==
                                      'pdf')
                                  ? Container(
                                      width: 650,
                                      height: 400,
                                      margin:
                                          const EdgeInsetsDirectional.all(25),
                                      child: PdfPreview(
                                        build: (newFile) => generatePDF(
                                          newFile,
                                          model.getFile(model.data!.dokumen),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 650,
                                      height: 350,
                                      margin:
                                          const EdgeInsetsDirectional.all(25),
                                      child: Image.memory(
                                        model.getFile(model.data!.dokumen),
                                      ),
                                    ),
                            ),
                          Container(
                            margin: EdgeInsets.only(left: 107.5),
                            width: 650,
                            // height: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Padding(
                                //     padding: EdgeInsets.fromLTRB(380, 5, 100, 5)),
                                ElevatedButton(
                                  onPressed: () => {
                                    Get.toNamed(
                                      '/edit/${Get.parameters['id'].toString()}',
                                    )
                                  },
                                  child: Text('Edit'),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  onPressed: () async {
                                    bool confirm = await showConfirmDialog(
                                      subtitle: "Anda yakin akan menghapus ?",
                                      styleTextYes: TextStyle(
                                        color: Colors.red,
                                      ),
                                    );

                                    if (confirm) {
                                      deleteDokumen(
                                        Get.parameters['id'].toString(),
                                      );
                                      Get.offAllNamed('/home');
                                    }
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Text("loading..."),
        ),
      ),
    );
  }
}
