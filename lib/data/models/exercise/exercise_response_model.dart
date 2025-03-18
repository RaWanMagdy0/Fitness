import 'exercise_model.dart';

class ExerciseResponseModel {
  ExerciseResponseModel({
      this.message, 
      this.totalExercises, 
      this.totalPages, 
      this.currentPage, 
      this.exercises,});

  ExerciseResponseModel.fromJson(dynamic json) {
    message = json['message'];
    totalExercises = json['totalExercises'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    if (json['exercises'] != null) {
      exercises = [];
      json['exercises'].forEach((v) {
        exercises?.add(ExerciseModel.fromJson(v));
      });
    }
  }
  String? message;
  int? totalExercises;
  int? totalPages;
  int? currentPage;
  List<ExerciseModel>? exercises;

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