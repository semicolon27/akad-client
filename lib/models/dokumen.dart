class Dokumen {
  final int id;
  final int jenis;
  final String nama;
  final String noreg;
  final file;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.nama,
      required this.noreg,
      required this.file});

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: json['id'],
        jenis: json['jenis'],
        nama: json['nama'],
        noreg: json['noreg'],
        file: json['file']);
  }
}
