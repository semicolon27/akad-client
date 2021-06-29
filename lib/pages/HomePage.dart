import 'package:akad/constant.dart';
import 'package:akad/controller/c_detail.dart';
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
    // cuma perlu di bungkus saja
    return TemplateWidget(
      child: Scaffold(
          body: ViewModelBuilder<HomeVM>.reactive(
          viewModelBuilder: () => HomeVM(),
          builder: (context, model, child) => Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
            color: Colors.white,
            width: 15,
          ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Data Pengguna", 
                        style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      )),
                    ),
                    Expanded(
                      child: SearchBox(
                      onChanged: (value) {},
                    )),
                  ],
                ),
                /*Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Data Pengguna", 
                        style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      )),
                    ),
                    Expanded(
                      child: SearchBox(
                      onChanged: (value) {},
                    )),
                  ],
                ),*/
                SizedBox(
                  width: double.infinity,
                  child: FutureBuilder<List<Doklist>>(
                    future: readDoklist(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(child: Text("Loading"));
                      } else
                        return DataTable(
                          decoration: BoxDecoration(
                          ),
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

  final ValueChanged onChanged;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 150,
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
          child: TextField(
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
      ],
    );
  }
}
