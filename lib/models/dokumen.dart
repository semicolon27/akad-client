class Dokumen {
  final int id;
  final int jenis;
  final String noreg;
  final file;

  Dokumen(
      {required this.id,
      required this.jenis,
      required this.noreg,
      required this.file});

  factory Dokumen.fromJson(Map<String, dynamic> json) {
    print("factory fromJson");
    return Dokumen(
        //bisa ganti key sesuai kebutuhan dengan
        //dengan catatan yang diambil pada object adalah nama colom di DB
        id: json['id'],
        jenis: json['jenis'],
        noreg: json['noreg'],
        file: json['file']);
  }
}
