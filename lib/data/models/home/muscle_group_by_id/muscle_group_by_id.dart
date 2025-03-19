
import '../random_muscle/muscle_model.dart';

class MuscleGroupById {
  MuscleGroupById({
      this.message, 
      this.totalMuscles, 
      this.muscles,});

  MuscleGroupById.fromJson(dynamic json) {
    message = json['message'];
    totalMuscles = json['totalMuscles'];
    if (json['muscles'] != null) {
      muscles = [];
      json['muscles'].forEach((v) {
        muscles?.add(MuscleModel.fromJson(v));
      });
    }
  }
  String? message;
  int? totalMuscles;
  List<MuscleModel>? muscles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['totalMuscles'] = totalMuscles;
    if (muscles != null) {
      map['muscles'] = muscles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}