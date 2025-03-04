
sealed class GeminiState {}

final class GeminiInitialState extends GeminiState {}

class GeminiLoadingState extends GeminiState {}

class GeminiSuccessState extends GeminiState {
  final List<Map<String, String>> messages;

  GeminiSuccessState({required this.messages});
}

class GeminiErrorState extends GeminiState {
  final String? errorMessage;

  GeminiErrorState({this.errorMessage});
}

class GeminiRecordingState extends GeminiState {
  bool? isListening ;
  String?recordedText;
  GeminiRecordingState({required this.isListening,this.recordedText});

}
