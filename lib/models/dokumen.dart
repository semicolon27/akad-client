import 'dart:convert';
import 'dart:io' as Io;

class Dokumen {
  int id;
  String nama;
  String noreg;
  var jenis;
  var file;
  String? extension;
  String? keterangan;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.nama,
      required this.noreg,
      required this.file,
      this.keterangan,
      this.extension});

  factory Dokumen.fromJson(Map<String, dynamic> x) {
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: x['id'],
        jenis: x['jenis'],
        nama: x['nama'],
        noreg: x['noreg'],
        keterangan: x['keterangan'],
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
          keterangan: x['Dokumen']['keterangan'],
          jenis: x['singkatan'],
          extension: ext.last,
          file: decodedBytes);
    } catch (e) {
      print(e);
      throw Exception('Gagal Melihat Dokumen');
    }
  }

  @override
  String toString() {
    return "$nama";
  }
}
