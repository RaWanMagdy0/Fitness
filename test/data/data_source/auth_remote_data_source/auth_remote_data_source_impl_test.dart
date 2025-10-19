import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/api/auth_api/auth_api_manager.dart';
import 'package:fitness_app/data/data_source/auth_data_source/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:fitness_app/data/models/sign_up/response/sign_up_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart' show MockAuthApiManager;

@GenerateMocks([AuthApiManager])
void main() {
  late MockAuthApiManager mockAuthApiManager;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  setUp(() {
    mockAuthApiManager = MockAuthApiManager();
    authRemoteDataSourceImpl =
        AuthRemoteDataSourceImpl(authApiManager: mockAuthApiManager);
  });
  //signup test
  group("test signup", (() {
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
      when(mockAuthApiManager.signUp(signupRequestBody))
          .thenAnswer((_) async => SignUpResponseModel(message: mockResponse));
      final result = await authRemoteDataSourceImpl.signUp(signupRequestBody);
      expect(result, isA<Result<String?>>());
      expect((result as Success).data, mockResponse);
      verify(mockAuthApiManager.signUp(signupRequestBody)).called(1);
    });
    test("signup returns failure when API call fails", () async {
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
      when(mockAuthApiManager.signUp(signupRequestBody))
          .thenThrow(Exception("API error"));

      final result = await authRemoteDataSourceImpl.signUp(signupRequestBody);

      expect(result, isA<Result<String?>>());
      expect((result as Fail).exception, isA<Exception>());

      verify(mockAuthApiManager.signUp(signupRequestBody)).called(1);
    });
  }));
}
