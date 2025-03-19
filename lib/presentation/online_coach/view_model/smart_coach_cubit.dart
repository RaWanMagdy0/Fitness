import 'dart:convert';
import 'dart:math';
import 'package:fitness_app/presentation/online_coach/view_model/smart_coach_state.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
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
   // sendWelcomeMessage();
  }

  Future<void> _initObjectBox() async {
    objectBox ??= await ObjectBox.create();
    _isObjectBoxReady = objectBox != null;
    print(" ObjectBox Initialized: $_isObjectBoxReady");
  }


  Future<void> sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    messages.add({"sender": "user", "text": userMessage});
    emit(GeminiLoadingState());

    _saveMessageToObjectBox("user", userMessage);

    if (_handleGreeting(userMessage)) return;

    String responseMessage = await _fetchGeminiResponse(userMessage);

    _saveMessageToObjectBox("gemini", responseMessage);
    messages.add({"sender": "gemini", "text": responseMessage});
    saveChatToHistory();

    emit(GeminiSuccessState(messages: List.from(messages)));
  }

  bool _handleGreeting(String userMessage) {
    List<String> greetings = [
      "hi", "hello", "hey", "good morning", "good evening", "good night",
      "مرحبا", "اهلا", "هاي", "صباح الخير", "مساء الخير"
    ];

    if (greetings.contains(userMessage.toLowerCase())) {
      String greetingResponse = "Hello! How can I assist you with your fitness journey today? 💪";
      messages.add({"sender": "gemini", "text": greetingResponse});
      emit(GeminiSuccessState(messages: List.from(messages)));
      return true;
    }
    return false;
  }

  Future<String> _fetchGeminiResponse(String userMessage) async {
    var result = await profileRepository.smartCoach({
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text": "You are a professional fitness trainer. Only provide answers related to health, exercise, and nutrition. "
                  "If the user's question is unrelated, clearly inform them that you specialize in fitness only.\n\n"
                  "User's question: $userMessage"
            }
          ]
        }
      ]
    });

    switch (result) {
      case Success<String?>():
        return extractTextFromGeminiResponse(result.data) ??
            "I'm here to help you achieve your fitness and health goals!";

      case Fail<String?>():
        emit(GeminiErrorState(errorMessage: getErrorMassageFromException(result.exception)));
        return "I'm having trouble retrieving an answer right now. Please try again later.";
    }
  }

  void _saveMessageToObjectBox(String sender, String message) {
    if (_isObjectBoxReady) {
      var msg = Message(sender: sender, text: message);
      objectBox!.saveMessage(msg);
    }
  }

  List<String> getChatTitles() {
    if (!_isObjectBoxReady) return [];
    return objectBox!.getChatTitles();
  }

  void saveChatToHistory() async {
    if (!_isObjectBoxReady || messages.isEmpty) return;

    String fullText = messages.first['text']!;
    int titleLength = min(30, fullText.length);
    String chatTitle = fullText.substring(0, titleLength).trim();

    ChatHistory? existingChat = objectBox!.getChatHistoryByTitle(chatTitle);

    if (existingChat == null) {
      existingChat = ChatHistory(title: chatTitle);
    } else {
      existingChat.messages.clear();
    }

    for (var msg in messages) {
      Message newMessage = Message(
          sender: msg['sender']!,
          text: msg['text']!
      );
      newMessage.chatHistory.target = existingChat;
      existingChat.messages.add(newMessage);
      objectBox!.saveMessage(newMessage);
    }

    objectBox!.saveChatHistory(existingChat);
  }

  void loadChatByTitle(String title) {
    if (!_isObjectBoxReady) {
      Future.delayed(Duration(seconds: 1), () {
        if (_isObjectBoxReady) {
          loadChatByTitle(title);
        } else {
        }
      });
      return;
    }

    print("🔍 Loading chat for title: $title");
    ChatHistory? chatHistory = objectBox!.getChatHistoryByTitle(title);

    if (chatHistory == null) {
      print("❌ No chat history found for: $title");
      return;
    }

    List<Message> chatMessages = chatHistory.messages.toList();
    print("📩 Found ${chatMessages.length} messages for chat: $title");

    if (chatMessages.isEmpty) {
      print("⚠️ No messages found for chat history: $title");
      return;
    }

    messages.clear();
    messages.addAll(chatMessages.map((msg) => {
      "sender": msg.sender,
      "text": msg.text,
    }));

    print("✅ Messages Loaded: ${messages.length}");
    emit(GeminiSuccessState(messages: List.from(messages)));
  }

  void endConversation() {
    if (messages.isNotEmpty) {
      saveChatToHistory();
    }
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
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speech.initialize();
      if (available) {
        isListening = true;
        recordedText = "";
        emit(GeminiRecordingState(isListening: true));
        _speech.listen(
          onResult: (result) {
            recordedText = result.recognizedWords;
            emit(GeminiRecordingState(isListening: true, recordedText: recordedText));

            if (result.finalResult) {
              isListening = false;
              _speech.stop();
              emit(GeminiRecordingState(isListening: false, recordedText: recordedText));

              if (recordedText.isNotEmpty) {
                sendMessage(recordedText);
              }
            }
          },
          localeId: "en_US",
          listenMode: stt.ListenMode.confirmation,
        );
      } else {
        print("Speech recognition not available!");
      }
    } else {
      print("Microphone permission denied!");
    }
  }

  void stopListening() {
    isListening = false;
    _speech.stop();
    emit(GeminiRecordingState(isListening: false, recordedText: recordedText));
  }
  /*********
  void sendWelcomeMessage() {
    if (messages.isEmpty) {
      messages.add({
        "sender": "gemini",
        "text": "Hello! I'm Gemini, your fitness assistant. How can I help you today?"
      });
      emit(GeminiSuccessState(messages: List.from(messages)));
    }
  }
*********/
}