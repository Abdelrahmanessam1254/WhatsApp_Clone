enum MessageStatus { sent, delivered, read }

class Message {
  String id;
  String text;
  String senderId;
  String senderName;
  DateTime timestamp;
  bool isMe;
  MessageStatus status;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.isMe,
    this.status = MessageStatus.sent,
  });

  Message copyWith({MessageStatus? status}) => Message(
    id: id,
    text: text,
    senderId: senderId,
    senderName: senderName,
    timestamp: timestamp,
    isMe: isMe,
    status: status ?? this.status,
  );
}
