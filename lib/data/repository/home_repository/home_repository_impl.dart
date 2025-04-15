import 'package:fitness_app/data/data_source/home_data_source/home_remote_data_source.dart';
import 'package:fitness_app/domain/entity/exercise/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entity/home/random_muscle_entity.dart';
import 'package:fitness_app/domain/entity/meal/exercise_by_muscle_and_level_entity.dart';
import 'package:fitness_app/domain/repository/home_repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entity/exercise/exercise_entity.dart';
import '../../../domain/entity/level/level.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Result<List<Exercise?>>> getUserData() async {
    final response = await _homeRemoteDataSource.getExercise();
    switch (response) {
      case Success():
        final exercises = response.data?.map((model) => model?.toEntity())
            .toList() ?? [];
        return Success(data: exercises);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<MuscleEntity?>>> getRandomMuscle() async {
    final response = await _homeRemoteDataSource.getRandomMuscle();
    switch (response) {
      case Success():
        final randomMuscle = response.data?.map((model) => model?.toEntity())
            .toList() ?? [];
        return Success(data: randomMuscle);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<MuscleEntity?>>> getMuscleGroupById(
      String muscleGroupId) async {
    final response = await _homeRemoteDataSource.getMuscleGroupById(
        muscleGroupId);
    switch (response) {
      case Success():
        final randomMuscle = response.data?.map((model) => model?.toEntity())
            .toList() ?? [];
        return Success(data: randomMuscle);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<Level?>>> getAllLevels() async {
    final response = await _homeRemoteDataSource.getAllLevels();
    switch (response) {
      case Success():
        final levels = response.data?.map((model) => model?.toEntity())
            .toList() ?? [];
        return Success(data: levels);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<DifficultyLevelEntity?>>> getLevelsByMuscleId(
      String primeMoverMuscleId) async {
    final response = await _homeRemoteDataSource.getLevelsByMuscleId(primeMoverMuscleId);
    switch (response) {
      case Success():
        final levels = response.data?.map((model) => model?.toEntity())
            .toList() ?? [];
        return Success(data: levels);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

  @override
  Future<Result<List<ExerciseByMuscleAndLevelEntity?>>> getExerciseByMuscleAndLevel(String primeMoverMuscleId, String difficultyLevelId)async {
    final response = await _homeRemoteDataSource.getExerciseByMuscleAndLevel(primeMoverMuscleId,difficultyLevelId);
    switch (response) {
      case Success():
        final exersice = response.data?.map((model) => model.toEntity())
            .toList() ?? [];
        return Success(data: exersice);

      case Fail():
        return Fail(exception: response.exception);
    }
  }

}