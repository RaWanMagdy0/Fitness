import 'package:fitness_app/data/models/level/level_model.dart';


class GetAllLevelResponseModel {
  GetAllLevelResponseModel({
      this.message, 
      this.levels,});

  GetAllLevelResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['levels'] != null) {
      levels = [];
      json['levels'].forEach((v) {
        levels?.add(LevelModel.fromJson(v));
      });
    }
  }
  String? message;
  List<LevelModel>? levels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (levels != null) {
      map['levels'] = levels?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}