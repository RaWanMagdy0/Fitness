import '../../../domain/entity/exercise/difficulty_level_entity.dart';

class DifficultyLevelModel {
  DifficultyLevelModel({
      this.id, 
      this.name,});

  DifficultyLevelModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
  DifficultyLevelEntity toEntity(){
    return DifficultyLevelEntity(
      id: id,
      name: name
    );
  }
}