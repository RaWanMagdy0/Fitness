import 'package:objectbox/objectbox.dart';

@Entity()
class Message {
  int id = 0;
  String sender;
  String text;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  final ToOne<ChatHistory> chatHistory;

  Message({required this.sender, required this.text, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now(),
        chatHistory = ToOne<ChatHistory>();
}

@Entity()
class ChatHistory {
  int id = 0;
  String title;
  final ToMany<Message> messages = ToMany<Message>();

  ChatHistory({required this.title});
}
