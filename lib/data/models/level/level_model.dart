import 'package:fitness_app/domain/entity/level/level.dart';

class LevelModel {
  LevelModel({
    this.id,
    this.name,
  });

  LevelModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

  Level toEntity() {
    return Level(
      id: id,
      name: name,
    );
  }
}
