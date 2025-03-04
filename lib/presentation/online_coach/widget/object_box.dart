import 'package:objectbox/objectbox.dart';
import '../../../domain/online_coach_enity.dart';
import '../../../objectbox.g.dart';
import 'dart:async';

class ObjectBox {
  static ObjectBox? _instance;

  late final Store store;
  late final Box<Message> messageBox;
  late final Box<ChatHistory> chatHistoryBox;

  ObjectBox._create(this.store) {
    messageBox = Box<Message>(store);
    chatHistoryBox = Box<ChatHistory>(store);
  }

  static Future<ObjectBox> create() async {
    if (_instance == null) {
      final store = await openStore();
      _instance = ObjectBox._create(store);
    }
    return _instance!;
  }

  void saveMessage(Message message) {
    messageBox.put(message);
  }

  List<Message> getMessages() {
    return messageBox.getAll();
  }

  void saveChatHistory(ChatHistory chat) {
    chatHistoryBox.put(chat);
  }

  List<String> getChatTitles() {
    return chatHistoryBox.getAll().map((chat) => chat.title).toList();
  }

  ChatHistory? getChatHistoryByTitle(String title) {
    return chatHistoryBox
        .query(ChatHistory_.title.equals(title, caseSensitive: false))
        .build()
        .findFirst();
  }

  List<Message> getChatByTitle(String title) {
    var chat = getChatHistoryByTitle(title);
    if (chat == null) {
      print("⚠️ No chat history found for: $title");
      return [];
    }
    print("✅ Chat found: ${chat.title}, Messages: ${chat.messages.length}");
    return chat.messages.toList();
  }

  void clearChatHistory() {
    chatHistoryBox.removeAll();
    messageBox.removeAll();
  }

  void dispose() {
    store.close();
    _instance = null;
  }
}
