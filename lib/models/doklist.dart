class Doklist {
  int id;
  String nama;
  String noreg;
  String jenis;
  String? keterangan;
  Doklist(
      {required this.id,
      required this.nama,
      required this.noreg,
      required this.jenis,
      this.keterangan});

  factory Doklist.getDoklist(Map<String, dynamic> object) {
    String namaDok = object['Dokumen']['nama'];
    var ext = namaDok.split('.');
    namaDok = namaDok.substring(0, namaDok.length - (ext.last.length + 1));

    String ket = object['Dokumen']['keterangan'];
    if (ket.length > 25) ket = ket.substring(0, 25);

    return Doklist(
        nama: namaDok,
        keterangan: ket,
        id: object['Dokumen']['id'],
        noreg: object['Dokumen']['noreg'],
        jenis: object['singkatan']);
  }
}
