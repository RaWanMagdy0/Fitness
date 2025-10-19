import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:fitness_app/data/repository/auth_repository/auth_repository_impl.dart';

import 'auth_repository_impl.mocks.dart' show MockAuthRemoteDataSource;

@GenerateMocks([AuthRemoteDataSource]) // 🟢 This tells Mockito what to mock
void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl =
        AuthRepositoryImpl(authRemoteDataSource: mockAuthRemoteDataSource);
  });

  group("test signup", () {
    test("signup returns success when API call is successful", () async {
      final mockResponse = "success";
      final signupRequestBody = SignupRequestBody(
          firstName: "Test",
          lastName: "User",
          password: "Test@123",
          email: "test@gmail.com",
          rePassword: "Test@123",
          gender: "female",
          height: 170,
          weight: 60,
          activityLevel: "level1",
          goal: "loss weight",
          age: 22);

      when(mockAuthRemoteDataSource.signUp(signupRequestBody))
          .thenAnswer((_) async => Success<String?>(data: mockResponse));

      final result = await authRepositoryImpl.signUp(signupRequestBody);

      expect(result, isA<Success<String?>>());
      expect((result as Success<String?>).data, mockResponse);

      verify(mockAuthRemoteDataSource.signUp(signupRequestBody)).called(1);
    });
  });
}
