import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/workout_data_source/workout_remote_data_source.dart';
import 'package:fitness_app/data/models/workout/muscle_model.dart';
import 'package:fitness_app/data/repository/workout_repository/workout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workout_repository_impl_test.mocks.dart';

@GenerateMocks([WorkoutRemoteDataSource])
void main() {
  late WorkoutRepositoryImpl workoutRepository;
  late MockWorkoutRemoteDataSource mockWorkoutRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<List<MuscleGroup>?>>(
        Fail(exception: Exception('dummy')));
    provideDummy<Result<MuscleDetailResponse?>>(
        Fail(exception: Exception('dummy')));
  });

  setUp(() {
    mockWorkoutRemoteDataSource = MockWorkoutRemoteDataSource();
    workoutRepository = WorkoutRepositoryImpl(
        workoutRemoteDataSource: mockWorkoutRemoteDataSource);
  });

  group('getMuscleGroups', () {
    final tMuscleGroups = [MuscleGroup(id: '1', name: 'Chest')];
    final tException = Exception('Failed to get muscle groups');

    test(
        'should return a list of MuscleGroup when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockWorkoutRemoteDataSource.getMuscleGroups())
          .thenAnswer((_) async => Success(data: tMuscleGroups));
      // act
      final result = await workoutRepository.getMuscleGroups();
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tMuscleGroups);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockWorkoutRemoteDataSource.getMuscleGroups())
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await workoutRepository.getMuscleGroups();
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('getMuscleGroupDetails', () {
    const tMuscleGroupId = '1';
    final tMuscleDetailResponse = MuscleDetailResponse(message: 'Details');
    final tException = Exception('Failed to get muscle group details');

    test(
        'should return a MuscleDetailResponse when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockWorkoutRemoteDataSource.getMuscleGroupDetails(tMuscleGroupId))
          .thenAnswer((_) async => Success(data: tMuscleDetailResponse));
      // act
      final result =
          await workoutRepository.getMuscleGroupDetails(tMuscleGroupId);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tMuscleDetailResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockWorkoutRemoteDataSource.getMuscleGroupDetails(tMuscleGroupId))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result =
          await workoutRepository.getMuscleGroupDetails(tMuscleGroupId);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });
}
