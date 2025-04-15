class ActivityConstants {
  static const Map<String, String> activityMap = {
    'level1': 'Rookie',
    'level2': 'Beginner',
    'level3': 'Intermediate',
    'level4': 'Advanced',
    'level5': 'Expert'
  };

  static Map<String, String> getReverseActivityMap() {
    return Map.fromEntries(
        activityMap.entries.map((e) => MapEntry(e.value, e.key)));
  }
}
