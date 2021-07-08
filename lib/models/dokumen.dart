import 'dart:convert';

class Dokumen {
  Dokumen({
    required this.dokumen,
    required this.singkatan,
  });

  DokumenClass dokumen;
  String singkatan;

  factory Dokumen.fromRawJson(String str) => Dokumen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dokumen.fromJson(Map<String, dynamic> json) => Dokumen(
        dokumen: DokumenClass.fromJson(json["Dokumen"]),
        singkatan: json["singkatan"],
      );

  Map<String, dynamic> toJson() => {
        "Dokumen": dokumen.toJson(),
        "singkatan": singkatan,
      };
}

class DokumenClass {
  DokumenClass({
    this.keterangan,
    required this.nama,
    required this.noreg,
    required this.part2,
    required this.part4,
    required this.part6,
    required this.part8,
    required this.id,
    required this.jenis,
    required this.part1,
    required this.part3,
    required this.part5,
    required this.part7,
  });

  String? keterangan;
  String nama;
  String noreg;
  String part2;
  String part4;
  String part6;
  String part8;
  int jenis;
  int id;
  String part1;
  String part3;
  String part5;
  String part7;

  factory DokumenClass.fromRawJson(String str) =>
      DokumenClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DokumenClass.fromJson(Map<String, dynamic> json) => DokumenClass(
        keterangan: json["keterangan"],
        nama: json["nama"],
        noreg: json["noreg"],
        part2: json["part2"],
        part4: json["part4"],
        part6: json["part6"],
        part8: json["part8"],
        jenis: json["jenis"],
        id: json["id"],
        part1: json["part1"],
        part3: json["part3"],
        part5: json["part5"],
        part7: json["part7"],
      );

  Map<String, dynamic> toJson() => {
        "keterangan": keterangan,
        "nama": nama,
        "noreg": noreg,
        "part2": part2,
        "part4": part4,
        "part6": part6,
        "part8": part8,
        "jenis": jenis,
        "id": id,
        "part1": part1,
        "part3": part3,
        "part5": part5,
        "part7": part7,
      };
}
