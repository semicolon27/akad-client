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
    return Doklist(
        id: object['Dokumen']['id'],
        nama: object['Dokumen']['nama'],
        noreg: object['Dokumen']['noreg'],
        jenis: object['singkatan']);
  }

  // @override
  // String toString() {
  //   return "$nama";
  // }
}
