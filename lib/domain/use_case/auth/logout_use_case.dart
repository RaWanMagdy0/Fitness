import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/auth_repository/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Result<String?>> invoke() {
    return authRepository.logout();
  }
}