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
    String namaDok = object['Dokumen']['nama'];
    var ext = namaDok.split('.');
    namaDok = namaDok.substring(0, namaDok.length - (ext.last.length + 1));
    return Doklist(
        id: object['Dokumen']['id'],
        nama: namaDok,
        noreg: object['Dokumen']['noreg'],
        jenis: object['singkatan']);
  }
}
