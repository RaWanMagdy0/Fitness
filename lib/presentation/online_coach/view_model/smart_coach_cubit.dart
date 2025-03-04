import 'dart:convert';
import 'dart:math';
import 'package:fitness_app/presentation/online_coach/view_model/smart_coach_state.dart';
import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/online_coach_enity.dart';
import '../../../domain/repository/profile_repository/profile_repository.dart';
import '../widget/object_box.dart';

@injectable
class GeminiCubit extends BaseViewModel<GeminiState> {
  final ProfileRepository profileRepository;
  ObjectBox? objectBox;
  final List<Map<String, String>> messages = [];
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String recordedText = "";
  bool _isObjectBoxReady = false;

  GeminiCubit(this.profileRepository) : super(GeminiInitialState()) {
    _initObjectBox();
  }

  Future<void> _initObjectBox() async {
    objectBox ??= await ObjectBox.create();
    _isObjectBoxReady = objectBox != null;
    print("✅ ObjectBox Initialized: $_isObjectBoxReady");
  }


  Future<void> sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    messages.add({"sender": "user", "text": userMessage});
    emit(GeminiLoadingState());

    if (_isObjectBoxReady) {
      var userMsg = Message(sender: "user", text: userMessage);
      objectBox!.saveMessage(userMsg);
      print("✅ Message saved in ObjectBox: $userMessage");
    }

    var result = await profileRepository.smartCoach({
      "contents": [
        {
          "role": "user",
          "parts": [{"text": userMessage}]
        }
      ]
    });

    switch (result) {
      case Success<String?>():
        var jsonResponse = result.data;
        String responseMessage = extractTextFromGeminiResponse(jsonResponse) ??
            "I'm here to help with fitness advice.";

        if (_isObjectBoxReady) {
          var botMsg = Message(sender: "gemini", text: responseMessage);
          objectBox!.saveMessage(botMsg);
          print("✅ Gemini response saved: $responseMessage");
        }

        messages.add({"sender": "gemini", "text": responseMessage});
        print("📝 Saving chat to history...");
        saveChatToHistory();
        emit(GeminiSuccessState(messages: List.from(messages)));

      case Fail<String?>():
        emit(GeminiErrorState(errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  List<String> getChatTitles() {
    if (!_isObjectBoxReady) return [];
    return objectBox!.getChatTitles();
  }

  void loadChatByTitle(String title) {
    if (!_isObjectBoxReady) return;

    print("🔍 Loading chat for title: $title");

    List<Message> chatMessages = objectBox!.getChatByTitle(title);
    if (chatMessages.isEmpty) {
      print("⚠️ No messages found for: $title");
      return;
    }

    messages.clear();
    messages.addAll(chatMessages.map((msg) => {
      "sender": msg.sender,
      "text": msg.text,
    }));

    print("✅ Messages Loaded: ${messages.length}");

    emit(GeminiSuccessState(messages: List.from(messages)));
  }  void saveChatToHistory() async {
    if (!_isObjectBoxReady || messages.isEmpty) return;

    String fullText = messages.first['text']!;
    int titleLength = min(30, fullText.length);

    String chatTitle = fullText.substring(0, titleLength);

    ChatHistory? existingChat = objectBox!.getChatHistoryByTitle(chatTitle);

    if (existingChat == null) {
      existingChat = ChatHistory(title: chatTitle);
      objectBox!.saveChatHistory(existingChat);
      print("✅ New chat history created: $chatTitle");
    } else {
      print("ℹ️ Chat history already exists: $chatTitle");
    }

    for (var msg in messages) {
      Message newMessage = Message(sender: msg['sender']!, text: msg['text']!);
      newMessage.chatHistory.target = existingChat;
      objectBox!.saveMessage(newMessage);
    }

    print("✅ Chat history updated with messages.");
  }

  String? extractTextFromGeminiResponse(String? jsonResponse) {
    if (jsonResponse == null) return null;
    try {
      final decodedJson = jsonDecode(jsonResponse);
      return decodedJson["candidates"]?[0]["content"]["parts"]?[0]["text"];
    } catch (e) {
      print("JSON Parsing Error: $e");
      return null;
    }
  }

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      isListening = true;
      emit(GeminiRecordingState(isListening: true));
      _speech.listen(
        onResult: (result) {
          recordedText = result.recognizedWords;
          emit(GeminiRecordingState(
              isListening: true, recordedText: recordedText));
        },
        localeId: "en_US",
      );
    } else {
      print("Speech recognition not available!");
    }
  }
}
