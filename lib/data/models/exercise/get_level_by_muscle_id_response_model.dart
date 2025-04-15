
import 'difficulty_level_model.dart';

class GetLevelByMuscleIdResponseModel {
  GetLevelByMuscleIdResponseModel({
      this.message, 
      this.totalLevels, 
      this.difficultyLevels,});

  GetLevelByMuscleIdResponseModel.fromJson(dynamic json) {
    message = json['message'];
    totalLevels = json['totalLevels'];
    if (json['difficulty_levels'] != null) {
      difficultyLevels = [];
      json['difficulty_levels'].forEach((v) {
        difficultyLevels?.add(DifficultyLevelModel.fromJson(v));
      });
    }
  }
  String? message;
  int? totalLevels;
  List<DifficultyLevelModel>? difficultyLevels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['totalLevels'] = totalLevels;
    if (difficultyLevels != null) {
      map['difficulty_levels'] = difficultyLevels?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}