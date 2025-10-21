import 'dart:io';
import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/profile_data_source/profile_remote_data_source.dart';
import 'package:fitness_app/data/models/profile/user_model.dart';
import 'package:fitness_app/data/repository/profile_repository/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

/// ✅ Added Equatable support to make User comparable by value
class TestUser {
  final String? id;
  final String? email;

  const TestUser({this.id, this.email});

  @override
  List<Object?> get props => [id, email];
}

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepositoryImpl profileRepository;
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;

  setUpAll(() {
    provideDummy<Result<UserModel?>>(Fail(exception: Exception('dummy')));
    provideDummy<Result<String?>>(Fail(exception: Exception('dummy')));
  });

  setUp(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepository = ProfileRepositoryImpl(
      profileRemoteDataSource: mockProfileRemoteDataSource,
    );
  });

  group('getUserData', () {
    final tUserModel = UserModel(id: '1', email: 'Test User');
    final tUserEntity = const TestUser(id: '1', email: 'Test User');
    final tException = Exception('Failed to get user data');

    test(
        'should return a User entity when the call to the remote data source is successful',
        () async {
      // arrange
      when(mockProfileRemoteDataSource.getUserData())
          .thenAnswer((_) async => Success(data: tUserModel));

      // act
      final result = await profileRepository.getUserData();

      // assert
      expect(result, isA<Success>());
      final success = result as Success;
      // ✅ Compare by value
      expect(success.data.id, tUserEntity.id);
      expect(success.data.email, tUserEntity.email);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      // arrange
      when(mockProfileRemoteDataSource.getUserData())
          .thenAnswer((_) async => Fail(exception: tException));

      // act
      final result = await profileRepository.getUserData();

      // assert
      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('uploadPhoto', () {
    final tPhoto = File('test_photo.jpg');
    const tPhotoUrl = 'http://example.com/photo.jpg';
    final tException = Exception('Failed to upload photo');

    test(
        'should return a photo URL when the call to the remote data source is successful',
        () async {
      when(mockProfileRemoteDataSource.uploadPhoto(tPhoto))
          .thenAnswer((_) async => Success(data: tPhotoUrl));

      final result = await profileRepository.uploadPhoto(tPhoto);

      expect(result, isA<Success>());
      expect((result as Success).data, tPhotoUrl);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockProfileRemoteDataSource.uploadPhoto(tPhoto))
          .thenAnswer((_) async => Fail(exception: tException));

      final result = await profileRepository.uploadPhoto(tPhoto);

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('smartCoach', () {
    final tMessage = {'message': 'Hello'};
    const tResponse = 'Hello from the coach';
    final tException = Exception('Failed to send message');

    test(
        'should return a response from the coach when the call to the remote data source is successful',
        () async {
      when(mockProfileRemoteDataSource.smartCoach(tMessage))
          .thenAnswer((_) async => Success(data: tResponse));

      final result = await profileRepository.smartCoach(tMessage);

      expect(result, isA<Success>());
      expect((result as Success).data, tResponse);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockProfileRemoteDataSource.smartCoach(tMessage))
          .thenAnswer((_) async => Fail(exception: tException));

      final result = await profileRepository.smartCoach(tMessage);

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('changePassword', () {
    const tCurrentPassword = 'password123';
    const tNewPassword = 'newPassword456';
    const tSuccessMessage = 'Password changed successfully';
    final tException = Exception('Failed to change password');

    test(
        'should return a success message when the call to the remote data source is successful',
        () async {
      when(mockProfileRemoteDataSource.changePassword(
        currentPassword: tCurrentPassword,
        newPassword: tNewPassword,
      )).thenAnswer((_) async => Success(data: tSuccessMessage));

      final result = await profileRepository.changePassword(
        currentPassword: tCurrentPassword,
        newPassword: tNewPassword,
      );

      expect(result, isA<Success>());
      expect((result as Success).data, tSuccessMessage);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockProfileRemoteDataSource.changePassword(
        currentPassword: tCurrentPassword,
        newPassword: tNewPassword,
      )).thenAnswer((_) async => Fail(exception: tException));

      final result = await profileRepository.changePassword(
        currentPassword: tCurrentPassword,
        newPassword: tNewPassword,
      );

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });
}
