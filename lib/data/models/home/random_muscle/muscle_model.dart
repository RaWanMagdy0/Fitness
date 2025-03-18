import '../../../../domain/entity/home/random_muscle_entity.dart';

class MuscleModel {
  MuscleModel({
      this.id, 
      this.name, 
      this.image,});

  MuscleModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
  MuscleEntity toEntity(){
    return MuscleEntity(
      id: id,
      image: image,
      name: name,
    );
  }
}