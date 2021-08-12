class ChatMessage {
  String id;
  String chatId;
  String senderId;
  String recipientId;
  String senderName;
  String recipientName;
  String content;
  String timestamp;
  String status;

  ChatMessage(
      {this.id,
      this.chatId,
      this.senderId,
      this.recipientId,
      this.senderName,
      this.recipientName,
      this.content,
      this.timestamp,
      this.status});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    chatId = json['chatId'];
    senderId = json['senderId'].toString();
    recipientId = json['recipientId'].toString();
    senderName= json['senderName'];
    recipientName= json['recipientName'].toString();
    content=json['content'];
    timestamp= json['timestamp'].toString();

  }
}
