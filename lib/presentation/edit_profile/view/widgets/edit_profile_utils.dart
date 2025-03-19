import 'package:shared_preferences/shared_preferences.dart';

class EditProfileUtils {
  static String mapGoalToDisplay(String? goal) {
    final goalMap = {
      'gain_weight': 'Gain Weight',
      'lose_weight': 'Lose Weight',
      'get_fitter': 'Get Fitter',
      'gain_flexible': 'Gain More Flexible',
      'learn_basic': 'Learn The Basics'
    };

    return goalMap[goal] ?? 'Gain Weight';
  }

  static String mapActivityToDisplay(String? activity) {
    final activityMap = {
      'level1': 'Rookie',
      'level2': 'Beginner',
      'level3': 'Intermediate',
      'level4': 'Advanced',
      'level5': 'Expert'
    };

    return activityMap[activity] ?? 'Rookie';
  }

  static String? convertGoalToApiFormat(String displayGoal) {
    final reverseGoalMap = {
      'Gain Weight': 'gain_weight',
      'Lose Weight': 'lose_weight',
      'Get Fitter': 'get_fitter',
      'Gain More Flexible': 'gain_flexible',
      'Learn The Basics': 'learn_basic'
    };

    return reverseGoalMap[displayGoal];
  }

  static String? convertActivityToApiFormat(String displayActivity) {
    final reverseActivityMap = {
      'Rookie': 'level1',
      'Beginner': 'level2',
      'Intermediate': 'level3',
      'Advanced': 'level4',
      'Expert': 'level5'
    };

    return reverseActivityMap[displayActivity];
  }

  static Future<void> saveCurrentValues(String weight, String goal, String activityLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_weight', weight.replaceAll(' KG', ''));
    await prefs.setString('current_goal', goal);
    await prefs.setString('current_activity', activityLevel);
  }

  static Future<void> clearSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('edit_profile_weight');
    await prefs.remove('edit_profile_goal');
    await prefs.remove('edit_profile_activity');
    await prefs.remove('current_weight');
    await prefs.remove('current_goal');
    await prefs.remove('current_activity');
  }
}