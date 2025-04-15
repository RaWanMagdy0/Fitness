import 'exercise_by_muscle_and_level_model.dart';

class GetExerciseByMuscleAndLevelResponseModel{
  GetExerciseByMuscleAndLevelResponseModel({
      this.message, 
      this.totalExercises, 
      this.totalPages, 
      this.currentPage, 
      this.exercises,});

  GetExerciseByMuscleAndLevelResponseModel.fromJson(dynamic json) {
    message = json['message'];
    totalExercises = json['totalExercises'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    if (json['exercises'] != null) {
      exercises = [];
      json['exercises'].forEach((v) {
        exercises?.add(ExerciseByMuscleAndLevelModel.fromJson(v));
      });
    }
  }
  String? message;
  int? totalExercises;
  int? totalPages;
  int? currentPage;
  List<ExerciseByMuscleAndLevelModel>? exercises;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['totalExercises'] = totalExercises;
    map['totalPages'] = totalPages;
    map['currentPage'] = currentPage;
    if (exercises != null) {
      map['exercises'] = exercises?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}