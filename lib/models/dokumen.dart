import 'dart:convert';
import 'dart:io' as Io;

class Dokumen {
  final int id;
  final String nama;
  final String noreg;
  final jenis;
  final file;
  final String? extension;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.nama,
      required this.noreg,
      required this.file,
      this.extension});

  factory Dokumen.fromJson(Map<String, dynamic> x) {
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: x['id'],
        jenis: x['jenis'],
        nama: x['nama'],
        noreg: x['noreg'],
        file: x['file']);
  }

  factory Dokumen.getDokumen(Map<String, dynamic> x) {
    String base64 =
        """${x['Dokumen']['part1']}${x['Dokumen']['part2']}${x['Dokumen']['part3']}${x['Dokumen']['part4']}${x['Dokumen']['part5']}${x['Dokumen']['part6']}${x['Dokumen']['part7']}${x['Dokumen']['part8']}""";

    try {
      var decodedBytes = base64Decode(base64);
      String nameFile = x['Dokumen']['nama'];
      var ext = nameFile.split('.');

      return Dokumen(
          id: x['Dokumen']['id'],
          nama: x['Dokumen']['nama'],
          noreg: x['Dokumen']['noreg'],
          jenis: x['singkatan'],
          extension: ext.last,
          file: decodedBytes);
    } catch (e) {
      print(e);
      return Dokumen(
          id: x['Dokumen']['id'],
          nama: x['Dokumen']['nama'],
          noreg: x['Dokumen']['noreg'],
          jenis: x['singkatan'],
          file: "fail");
    }
  }

  @override
  String toString() {
    return "$nama";
  }
}
