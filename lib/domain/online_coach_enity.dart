import 'package:objectbox/objectbox.dart';

@Entity()
class Message {
  int id = 0;
  String sender;
  String text;
  DateTime timestamp;

  final ToOne<ChatHistory> chatHistory; // ربط الرسالة بالمحادثة

  Message({required this.sender, required this.text, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now(),
        chatHistory = ToOne<ChatHistory>();
}
@Entity()
class ChatHistory {
  int id = 0;
  String title; // عنوان المحادثة
  final ToMany<Message> messages = ToMany<Message>(); // ربط مع الرسائل

  ChatHistory({required this.title});
}
