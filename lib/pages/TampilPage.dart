/*
import 'package:flutter/material.dart';
import 'package:tabel/constant.dart';
import 'package:tabel/model/recentFile.dart';

class Tampil extends StatelessWidget {
  const Tampil({ 
    Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        automaticallyImplyLeading: false,
        title: Text("Data Pengguna"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search, 
            color: Colors.white
          ), onPressed: () { },),
        ],
      ),
      body: Scrollbar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            " ",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('+Tambah Data'),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("No.Registrasi"),
                ),
                DataColumn(
                  label: Text("Jenis Dokumen"),
                ),
                DataColumn(
                  label: Text("File"),
                ),
                DataColumn(
                  label: Text("Aksi"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            )
          )
        ]),
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.jenis!)),
      DataCell(Text(fileInfo.file!)),
      DataCell(Text(fileInfo.aksi!))
    ],
  );
}
*/