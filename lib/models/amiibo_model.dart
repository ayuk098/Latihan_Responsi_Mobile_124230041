import 'package:hive/hive.dart';
part 'amiibo_model.g.dart';

@HiveType(typeId: 0)
class AmiiboModel extends HiveObject {
  @HiveField(0)
  String amiiboSeries;

  @HiveField(1)
  String character;

  @HiveField(2)
  String gameSeries;

  @HiveField(3)
  String head;

  @HiveField(4)
  String image;

  @HiveField(5)
  String name;

  @HiveField(6)
  ReleaseModel release;

  @HiveField(7)
  String tail;

  @HiveField(8)
  String type;

  AmiiboModel({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.image,
    required this.name,
    required this.release,
    required this.tail,
    required this.type,
  });

  factory AmiiboModel.fromJson(Map<String, dynamic> json) {
    return AmiiboModel(
      amiiboSeries: json['amiiboSeries'] ?? '',
      character: json['character'] ?? '',
      gameSeries: json['gameSeries'] ?? '',
      head: json['head'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      release: ReleaseModel.fromJson(json['release']),
      tail: json['tail'] ?? '',
      type: json['type'] ?? '',
    );
  }

  toJson() {}
}

@HiveType(typeId: 1)
class ReleaseModel {
  @HiveField(0)
  String? au;

  @HiveField(1)
  String? eu;

  @HiveField(2)
  String? jp;

  @HiveField(3)
  String? na;

  ReleaseModel({
    this.au,
    this.eu,
    this.jp,
    this.na,
  });

  factory ReleaseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReleaseModel();
    }

    return ReleaseModel(
      au: json['au'],
      eu: json['eu'],
      jp: json['jp'],
      na: json['na'],
    );
  }
}
