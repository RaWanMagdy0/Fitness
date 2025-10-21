import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:fitness_app/data/models/edit_profile/edit_profile_request_model.dart';
import 'package:fitness_app/data/models/forgot_password/request/forgot_password_request_model.dart';
import 'package:fitness_app/data/models/forgot_password/request/reset_password_request_model.dart';
import 'package:fitness_app/data/models/forgot_password/request/verify_code_request_model.dart';
import 'package:fitness_app/data/models/login/request/login_request_model.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:fitness_app/data/repository/auth_repository/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<String?>>(Fail(exception: Exception('dummy')));
  });

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepository =
        AuthRepositoryImpl(authRemoteDataSource: mockAuthRemoteDataSource);
  });

  group('signUp', () {
    final tSignupRequestBody = SignupRequestBody(
      email: 'test@test.com',
      password: 'password',
      lastName: 'Test User',
      gender: 'Male',
      weight: 70,
      height: 180,
      age: 25,
      goal: 'Lose Weight',
      activityLevel: 'Active',
    );
    const tSuccessResponse = 'Signup successful';
    final tException = Exception('Signup failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.signUp(tSignupRequestBody))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.signUp(tSignupRequestBody);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.signUp(tSignupRequestBody))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.signUp(tSignupRequestBody);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('login', () {
    final tLoginRequestModel =
        LoginRequestModel(email: 'test@test.com', password: 'password');
    const tSuccessResponse = 'Login successful';
    final tException = Exception('Login failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.login(tLoginRequestModel))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.login(tLoginRequestModel);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.login(tLoginRequestModel))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.login(tLoginRequestModel);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('editProfile', () {
    final tRequestModel = EditProfileRequestModel(lastName: 'New Name');
    const tSuccessResponse = 'Profile updated';
    final tException = Exception('Edit profile failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.editProfile(tRequestModel))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.editProfile(tRequestModel);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.editProfile(tRequestModel))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.editProfile(tRequestModel);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('forgotPassword', () {
    final tRequestModel = ForgotPasswordRequestModel(email: 'test@test.com');
    const tSuccessResponse = 'Password reset email sent';
    final tException = Exception('Forgot password failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.forgotPassword(tRequestModel))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.forgotPassword(tRequestModel);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.forgotPassword(tRequestModel))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.forgotPassword(tRequestModel);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('verifyResetCode', () {
    final tRequestModel = VerifyCodeRequestModel(resetCode: '123456');
    const tSuccessResponse = 'Code verified';
    final tException = Exception('Code verification failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.verifyResetCode(tRequestModel))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.verifyResetCode(tRequestModel);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.verifyResetCode(tRequestModel))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.verifyResetCode(tRequestModel);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('resetPassword', () {
    final tRequestModel = ResetPasswordRequestModel(
        email: 'test@test.com', newPassword: 'newPassword');
    const tSuccessResponse = 'Password has been reset';
    final tException = Exception('Password reset failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.resetPassword(tRequestModel))
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.resetPassword(tRequestModel);
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.resetPassword(tRequestModel))
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.resetPassword(tRequestModel);
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('logout', () {
    const tSuccessResponse = 'Logout successful';
    final tException = Exception('Logout failed');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.logout())
          .thenAnswer((_) async => Success(data: tSuccessResponse));
      // act
      final result = await authRepository.logout();
      // assert
      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockAuthRemoteDataSource.logout())
          .thenAnswer((_) async => Fail(exception: tException));
      // act
      final result = await authRepository.logout();
      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });
}
