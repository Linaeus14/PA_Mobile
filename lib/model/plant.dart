part of './model.dart';

class PlantClass {
  int? id;
  String? nama;
  List<String>? sNama;
  List<String>? sinonim;
  String? cycle;
  String? watering;
  List<String>? sunlight;
  String? image;
  bool isFavorite = false;

  PlantClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['common_name'] ?? 'unknown';
    sNama = List<String>.from(json['scientific_name'] ?? []);
    sinonim = List<String>.from(json['other_name'] ?? []);
    cycle = json['cycle'] ?? 'unknown';
    watering = json['watering'] ?? 'unknown';
    sunlight = List<String>.from(json['sunlight'] ?? []);
    image = json['default_image']?['regular_url'];
  }
}
