import 'package:fitness_app/data/data_source/home_data_source/home_remote_data_source.dart';
import 'package:fitness_app/domain/repository/home_repository/home_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entity/exercise/exercise_entity.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Result<List<Exercise?>>> getUserData() async {
    final response = await _homeRemoteDataSource.getExercise();
    switch (response) {
      case Success():
        final exercises = response.data?.map((model) => model?.toEntity()).toList() ?? [];
        return Success(data: exercises);

      case Fail():
        return Fail(exception: response.exception);
    }
  }
}
