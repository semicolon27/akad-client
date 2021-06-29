import 'package:akad/controller/c_detail.dart';
import 'package:akad/models/doklist.dart';
import 'package:akad/view_model/vm_home.dart';
import 'package:akad/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
        body: ViewModelBuilder<HomeVM>.reactive(
        viewModelBuilder: () => HomeVM(),
        builder: (context, model, child) => Container(
          margin: new EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FutureBuilder<List<Doklist>>(
                  // child: FutureBuilder<List<Doklist>>(
                  future: readDoklist(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(child: Text("Loading"));
                    } else
                      return DataTable(
                        //data secara horizontal
                        columns: <DataColumn>[
                          DataColumn(label: Text("No. Registrasi")),
                          DataColumn(label: Text("Nama")),
                          DataColumn(label: Text("Jenis Dokumen")),
                          DataColumn(label: Text("Aksi")),
                        ],

                        //data secara vertikal
                        rows: snapshot.data!
                            .map(
                              (data) => DataRow(
                                cells: [
                                  DataCell(Text(data.noreg)),
                                  DataCell(Text(data.nama)),
                                  DataCell(Text(data.jenis)),
                                  DataCell(ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        onSurface: Colors.blue[600]),
                                    onPressed: null,
                                    child: Text('Detail'),
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      );
                    // return ListTile(
                    //   title: Text(snapshot.data![i].nama),
                    //   subtitle: Text(snapshot.data![i].noreg),
                    // );
                    // });
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
