class JenisDokumen {
  JenisDokumen({required this.id, required this.singkatan, required this.nama});

  final int id;
  final String singkatan;
  final String nama;

  factory JenisDokumen.getJenisDokumen(object) {
    return JenisDokumen(
        id: object['id'], singkatan: object['singkatan'], nama: object['nama']);
  }

  @override
  String toString() {
    return "id: $id,singkatan: $singkatan,nama: $nama";
  }
}
