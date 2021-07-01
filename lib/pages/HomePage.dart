import 'package:akad/controller/c_Dokumen.dart';
import 'package:akad/models/doklist.dart';
import 'package:akad/view_model/vm_home.dart';
import 'package:akad/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<HomeVM>.reactive(
        viewModelBuilder: () => HomeVM(),
        onModelReady: (vm) => vm.init(),
        builder: (context, model, child) => Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.white,
            width: 15,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Text("Data Pengguna",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        )),
                  ),
                  Expanded(
                      child: SearchBox(
                    onChanged: (value) => model.filterData(value),
                  )),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: SingleChildScrollView(
                  child: !model.busy(model.listDokumen)
                      ? DataTable(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          columns: <DataColumn>[
                            DataColumn(
                                label: Text("No. Registrasi",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Nama",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Jenis Dokumen",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Aksi",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: model.listDokumen
                              .map(
                                (data) => DataRow(
                                  cells: [
                                    DataCell(Text(data.noreg)),
                                    DataCell(Text(data.nama)),
                                    DataCell(Text(data.jenis)),
                                    DataCell(ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          onSurface: Colors.blue),
                                      onPressed: () {
                                        Get.toNamed('/detail/${data.id}');
                                      },
                                      child: Text('Detail'),
                                    )),
                                  ],
                                ),
                              )
                              .toList(),
                        )
                      : Text('Loading...'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

// Class Search cuma belum dipindah
class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 170,
          height: 35,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5, // 5 top and bottom
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
          ),
          //Kolom Search : filter data
          child: TextFormField(
            //onChanged: onChanged,
            onChanged: onChanged,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: SvgPicture.asset("assets/icon/Search.svg"),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //Proses filter data
        /*if (vm.listTodo.length == 0)
          Center(
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Kosong'),
          ),
        ),*/
      ],
    );
  }
}
