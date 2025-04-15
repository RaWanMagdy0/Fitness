import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/local/sign_up_provider.dart';
import '../../../../profile/view_model/profile_cubit.dart';
import '../../../../profile/view_model/profile_state.dart';
import 'activity_constants.dart';

class ActivityScreenState {
  final ValueNotifier<String?> selectedActivityLevel =
      ValueNotifier<String?>(null);
  bool isFromEditProfile = false;
  bool isLoading = true;

  Future<void> checkSourceAndLoadData(BuildContext context) async {
    try {
      final route = ModalRoute.of(context);
      final args = route?.settings.arguments;

      if (args is Map && args['isFromEdit'] == true) {
        isFromEditProfile = true;
      } else {
        isFromEditProfile = false;
      }

      final signupProvider = context.read<SignupProvider>();
      final prefs = await SharedPreferences.getInstance();

      if (isFromEditProfile) {
        final currentActivity = prefs.getString('current_activity');

        if (currentActivity != null) {
          final activityKey =
              ActivityConstants.getReverseActivityMap()[currentActivity] ??
                  'level1';
          selectedActivityLevel.value = activityKey;
          isLoading = false;
          return;
        }

        try {
          final profileCubit = getIt<ProfileCubit>();
          final state = profileCubit.state;

          if (state is GetUserDataSuccessState && state.user != null) {
            selectedActivityLevel.value = state.user?.activityLevel ?? 'level1';
            isLoading = false;
            return;
          }

          await profileCubit.getUserData();
          await Future.delayed(Duration(milliseconds: 300));

          final newState = profileCubit.state;
          if (newState is GetUserDataSuccessState && newState.user != null) {
            selectedActivityLevel.value =
                newState.user?.activityLevel ?? 'level1';
            isLoading = false;
            return;
          }
        } catch (e) {
          print("Error fetching profile data: $e");
        }
      } else {
        selectedActivityLevel.value = signupProvider.getData("activityLevel");
      }

      isLoading = false;
    } catch (e) {
      print("Error in checkSourceAndLoadData: $e");
      isLoading = false;
    }
  }

  void dispose() {
    selectedActivityLevel.dispose();
  }
}
