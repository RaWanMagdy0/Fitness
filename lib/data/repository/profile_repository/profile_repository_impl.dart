import 'package:fitness_app/data/data_source/profile_data_source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../domain/entity/profile/user.dart';
import '../../../domain/repository/profile_repository/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Result<User?>> getUserData()async {
    final response = await profileRemoteDataSource.getUserData();
    switch (response) {
      case Success():
        return Success(data: response.data?.toEntity());
      case Fail():
        return Fail(exception: response.exception);
    }
  }}


