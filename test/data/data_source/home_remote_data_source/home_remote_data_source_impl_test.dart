import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/api/home_api/home_api_magager.dart'
    show HomeApiManager;
import 'package:fitness_app/data/data_source/home_data_source/home_remote_data_source_impl.dart';
import 'package:fitness_app/data/models/exercise/difficulty_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_by_muscle_and_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import 'package:fitness_app/data/models/home/random_muscle/muscle_model.dart';
import 'package:fitness_app/data/models/level/level_model.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiManager])
void main() {
  late MockHomeApiManager mockHomeApiManager;
  late HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;

  setUp(() {
    mockHomeApiManager = MockHomeApiManager();
    homeRemoteDataSourceImpl = HomeRemoteDataSourceImpl(mockHomeApiManager);
  });

  const testToken = 'Bearer test_token';

  group('Home Remote Data Source Tests', () {
    group('getExercise', () {
      test('returns success with exercises when API call is successful',
          () async {
        final mockExercises = [ExerciseModel(id: '1', grip: 'Push-up')];
        when(mockHomeApiManager.getExercise(testToken)).thenAnswer(
            (_) async => ExerciseResponse(exercises: mockExercises));

        final result = await homeRemoteDataSourceImpl.getExercise();

        expect(result, isA<Result<List<ExerciseModel?>>>());
        expect((result as Success).data, mockExercises);
        verify(mockHomeApiManager.getExercise(testToken)).called(1);
      });

      test('returns failure when API call fails', () async {
        when(mockHomeApiManager.getExercise(testToken))
            .thenThrow(Exception('API error'));

        final result = await homeRemoteDataSourceImpl.getExercise();

        expect(result, isA<Result<List<ExerciseModel?>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getExercise(testToken)).called(1);
      });
    });

    group('getRandomMuscle', () {
      test('returns success with muscles when API call is successful',
          () async {
        final mockMuscles = [MuscleModel(id: '1', name: 'Chest')];
        when(mockHomeApiManager.getRandomMuscle(testToken))
            .thenAnswer((_) async => MuscleResponse(muscles: mockMuscles));

        final result = await homeRemoteDataSourceImpl.getRandomMuscle();

        expect(result, isA<Result<List<MuscleModel?>>>());
        expect((result as Success).data, mockMuscles);
        verify(mockHomeApiManager.getRandomMuscle(testToken)).called(1);
      });

      test('returns failure when API call fails', () async {
        when(mockHomeApiManager.getRandomMuscle(testToken))
            .thenThrow(Exception('API error'));

        final result = await homeRemoteDataSourceImpl.getRandomMuscle();

        expect(result, isA<Result<List<MuscleModel?>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getRandomMuscle(testToken)).called(1);
      });
    });

    group('getMuscleGroupById', () {
      test('returns success with muscle group when API call is successful',
          () async {
        final mockMuscles = [MuscleModel(id: '1', name: 'Chest')];
        const muscleGroupId = 'group1';
        when(mockHomeApiManager.getMuscleGroupById(testToken, muscleGroupId))
            .thenAnswer((_) async => MuscleResponse(muscles: mockMuscles));

        final result =
            await homeRemoteDataSourceImpl.getMuscleGroupById(muscleGroupId);

        expect(result, isA<Result<List<MuscleModel?>>>());
        expect((result as Success).data, mockMuscles);
        verify(mockHomeApiManager.getMuscleGroupById(testToken, muscleGroupId))
            .called(1);
      });

      test('returns failure when API call fails', () async {
        const muscleGroupId = 'group1';
        when(mockHomeApiManager.getMuscleGroupById(testToken, muscleGroupId))
            .thenThrow(Exception('API error'));

        final result =
            await homeRemoteDataSourceImpl.getMuscleGroupById(muscleGroupId);

        expect(result, isA<Result<List<MuscleModel?>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getMuscleGroupById(testToken, muscleGroupId))
            .called(1);
      });
    });

    group('getAllLevels', () {
      test('returns success with levels when API call is successful', () async {
        final mockLevels = [LevelModel(id: '1', name: 'Beginner')];
        when(mockHomeApiManager.getAllLevel(testToken))
            .thenAnswer((_) async => LevelResponse(levels: mockLevels));

        final result = await homeRemoteDataSourceImpl.getAllLevels();

        expect(result, isA<Result<List<LevelModel?>>>());
        expect((result as Success).data, mockLevels);
        verify(mockHomeApiManager.getAllLevel(testToken)).called(1);
      });

      test('returns failure when API call fails', () async {
        when(mockHomeApiManager.getAllLevel(testToken))
            .thenThrow(Exception('API error'));

        final result = await homeRemoteDataSourceImpl.getAllLevels();

        expect(result, isA<Result<List<LevelModel?>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getAllLevel(testToken)).called(1);
      });
    });

    group('getLevelsByMuscleId', () {
      test('returns success with difficulty levels when API call is successful',
          () async {
        final mockDifficultyLevels = [
          DifficultyLevelModel(id: '1', name: 'Easy')
        ];
        const primeMoverMuscleId = 'muscle1';
        when(mockHomeApiManager.getLevelsByMuscleId(
                testToken, primeMoverMuscleId))
            .thenAnswer((_) async => DifficultyLevelResponse(
                difficultyLevels: mockDifficultyLevels));

        final result = await homeRemoteDataSourceImpl
            .getLevelsByMuscleId(primeMoverMuscleId);

        expect(result, isA<Result<List<DifficultyLevelModel>>>());
        expect((result as Success).data, mockDifficultyLevels);
        verify(mockHomeApiManager.getLevelsByMuscleId(
                testToken, primeMoverMuscleId))
            .called(1);
      });

      test('returns failure when API call fails', () async {
        const primeMoverMuscleId = 'muscle1';
        when(mockHomeApiManager.getLevelsByMuscleId(
                testToken, primeMoverMuscleId))
            .thenThrow(Exception('API error'));

        final result = await homeRemoteDataSourceImpl
            .getLevelsByMuscleId(primeMoverMuscleId);

        expect(result, isA<Result<List<DifficultyLevelModel>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getLevelsByMuscleId(
                testToken, primeMoverMuscleId))
            .called(1);
      });
    });

    group('getExerciseByMuscleAndLevel', () {
      test('returns success with exercises when API call is successful',
          () async {
        final mockExercises = [
          ExerciseByMuscleAndLevelModel(id: '1', name: 'Squat')
        ];
        const primeMoverMuscleId = 'muscle1';
        const difficultyLevelId = 'level1';
        when(mockHomeApiManager.getExerciseByMuscleAndLevel(
                testToken, primeMoverMuscleId, difficultyLevelId))
            .thenAnswer((_) async =>
                ExerciseByMuscleAndLevelResponse(exercises: mockExercises));

        final result = await homeRemoteDataSourceImpl
            .getExerciseByMuscleAndLevel(primeMoverMuscleId, difficultyLevelId);

        expect(result, isA<Result<List<ExerciseByMuscleAndLevelModel>>>());
        expect((result as Success).data, mockExercises);
        verify(mockHomeApiManager.getExerciseByMuscleAndLevel(
                testToken, primeMoverMuscleId, difficultyLevelId))
            .called(1);
      });

      test('returns failure when API call fails', () async {
        const primeMoverMuscleId = 'muscle1';
        const difficultyLevelId = 'level1';
        when(mockHomeApiManager.getExerciseByMuscleAndLevel(
                testToken, primeMoverMuscleId, difficultyLevelId))
            .thenThrow(Exception('API error'));

        final result = await homeRemoteDataSourceImpl
            .getExerciseByMuscleAndLevel(primeMoverMuscleId, difficultyLevelId);

        expect(result, isA<Result<List<ExerciseByMuscleAndLevelModel>>>());
        expect((result as Fail).exception, isA<Exception>());
        verify(mockHomeApiManager.getExerciseByMuscleAndLevel(
                testToken, primeMoverMuscleId, difficultyLevelId))
            .called(1);
      });
    });
  });
}

// Mock response classes to match the API manager's expected return types
class ExerciseResponse {
  final List<ExerciseModel>? exercises;
  ExerciseResponse({this.exercises});
}

class MuscleResponse {
  final List<MuscleModel>? muscles;
  MuscleResponse({this.muscles});
}

class LevelResponse {
  final List<LevelModel>? levels;
  LevelResponse({this.levels});
}

class DifficultyLevelResponse {
  final List<DifficultyLevelModel>? difficultyLevels;
  DifficultyLevelResponse({this.difficultyLevels});
}

class ExerciseByMuscleAndLevelResponse {
  final List<ExerciseByMuscleAndLevelModel>? exercises;
  ExerciseByMuscleAndLevelResponse({this.exercises});
}
