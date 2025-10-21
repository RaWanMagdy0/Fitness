import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/home_data_source/home_remote_data_source.dart';
import 'package:fitness_app/data/models/exercise/difficulty_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_by_muscle_and_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import 'package:fitness_app/data/models/home/random_muscle/muscle_model.dart';
import 'package:fitness_app/data/models/level/level_model.dart';
import 'package:fitness_app/data/repository/home_repository/home_repository_impl.dart';
import 'package:fitness_app/domain/entity/exercise/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entity/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entity/home/random_muscle_entity.dart';
import 'package:fitness_app/domain/entity/level/level.dart';
import 'package:fitness_app/domain/entity/meal/exercise_by_muscle_and_level_entity.dart';
import 'package:fitness_app/domain/repository/home_repository/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepository homeRepository;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<List<ExerciseModel?>>>(
        Fail(exception: Exception('dummy')));
    provideDummy<Result<List<MuscleModel?>>>(
        Fail(exception: Exception('dummy')));
    provideDummy<Result<List<LevelModel?>>>(
        Fail(exception: Exception('dummy')));
    provideDummy<Result<List<DifficultyLevelModel?>>>(
        Fail(exception: Exception('dummy')));
    provideDummy<Result<List<ExerciseByMuscleAndLevelModel>>>(
        Fail(exception: Exception('dummy')));
  });

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepository = HomeRepositoryImpl(mockHomeRemoteDataSource);
  });

  group('getUserData', () {
    final tExerciseModels = [ExerciseModel(id: '1', grip: 'test')];

    test(
        'should return a list of ExerciseEntity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getExercise())
          .thenAnswer((_) async => Success(data: tExerciseModels));
      // act
      final result = await homeRepository.getUserData();
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, isA<List<Exercise?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get exercises');
      when(mockHomeRemoteDataSource.getExercise())
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result = await homeRepository.getUserData();
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });

  group('getRandomMuscle', () {
    final tMuscleModels = [MuscleModel(id: '1', name: 'test')];

    test(
        'should return a list of MuscleEntity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getRandomMuscle())
          .thenAnswer((_) async => Success(data: tMuscleModels));
      // act
      final result = await homeRepository.getRandomMuscle();
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, isA<List<MuscleEntity?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get random muscle');
      when(mockHomeRemoteDataSource.getRandomMuscle())
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result = await homeRepository.getRandomMuscle();
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });

  group('getMuscleGroupById', () {
    const tMuscleGroupId = '1';
    final tMuscleModels = [MuscleModel(id: '1', name: 'test')];

    test(
        'should return a list of MuscleEntity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getMuscleGroupById(tMuscleGroupId))
          .thenAnswer((_) async => Success(data: tMuscleModels));
      // act
      final result = await homeRepository.getMuscleGroupById(tMuscleGroupId);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, isA<List<MuscleEntity?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get muscle group by id');
      when(mockHomeRemoteDataSource.getMuscleGroupById(tMuscleGroupId))
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result = await homeRepository.getMuscleGroupById(tMuscleGroupId);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });

  group('getAllLevels', () {
    final tLevelModels = [LevelModel(id: '1', name: 'test')];

    test(
        'should return a list of Level when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getAllLevels())
          .thenAnswer((_) async => Success(data: tLevelModels));
      // act
      final result = await homeRepository.getAllLevels();
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, isA<List<Level?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get all levels');
      when(mockHomeRemoteDataSource.getAllLevels())
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result = await homeRepository.getAllLevels();
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });

  group('getLevelsByMuscleId', () {
    const tPrimeMoverMuscleId = '1';
    final tDifficultyLevelModels = [
      DifficultyLevelModel(id: '1', name: 'test')
    ];

    test(
        'should return a list of DifficultyLevelEntity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getLevelsByMuscleId(tPrimeMoverMuscleId))
          .thenAnswer((_) async => Success(data: tDifficultyLevelModels));
      // act
      final result =
          await homeRepository.getLevelsByMuscleId(tPrimeMoverMuscleId);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, isA<List<DifficultyLevelEntity?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get levels by muscle id');
      when(mockHomeRemoteDataSource.getLevelsByMuscleId(tPrimeMoverMuscleId))
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result =
          await homeRepository.getLevelsByMuscleId(tPrimeMoverMuscleId);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });

  group('getExerciseByMuscleAndLevel', () {
    const tPrimeMoverMuscleId = '1';
    const tDifficultyLevelId = '1';
    final tExerciseByMuscleAndLevelModels = [
      ExerciseByMuscleAndLevelModel(id: '1', grip: 'test')
    ];

    test(
        'should return a list of ExerciseByMuscleAndLevelEntity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockHomeRemoteDataSource.getExerciseByMuscleAndLevel(
              tPrimeMoverMuscleId, tDifficultyLevelId))
          .thenAnswer(
              (_) async => Success(data: tExerciseByMuscleAndLevelModels));
      // act
      final result = await homeRepository.getExerciseByMuscleAndLevel(
          tPrimeMoverMuscleId, tDifficultyLevelId);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data,
          isA<List<ExerciseByMuscleAndLevelEntity?>>());
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      final exception = Exception('Failed to get exercise by muscle and level');
      when(mockHomeRemoteDataSource.getExerciseByMuscleAndLevel(
              tPrimeMoverMuscleId, tDifficultyLevelId))
          .thenAnswer((_) async => Fail(exception: exception));
      // act
      final result = await homeRepository.getExerciseByMuscleAndLevel(
          tPrimeMoverMuscleId, tDifficultyLevelId);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, equals(exception));
    });
  });
}
