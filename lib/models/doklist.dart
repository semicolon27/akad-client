import 'dart:convert';

class Doklist {
  int id;
  String nama;
  String noreg;
  String jenis;
  Doklist(
      {required this.id,
      required this.nama,
      required this.noreg,
      required this.jenis});

  factory Doklist.getDoklist(Map<String, dynamic> object) {
    // String base64 = object['part1'] +
    //     object['part2'] +
    //     object['part3'] +
    //     object['part4'] +
    //     object['part5'] +
    //     object['part6'] +
    //     object['part7'] +
    //     object['part8'];
    // final decodedBytes = base64Decode(base64);
    return Doklist(
        id: object['Dokumen']['id'],
        nama: object['Dokumen']['nama'],
        noreg: object['Dokumen']['noreg'],
        jenis: object['singkatan']);
  }

  @override
  String toString() {
    return "$nama";
  }
}
