class Message {
  late String id;
  late String date;
  late String content;
  bool showTime = true;
  late String sender;
  late String receiver;

  Message(this.id, this.content, this.date, this.sender, this.receiver);

  Message.time(
    this.id,
    this.content,
    this.showTime,
    this.date,
    this.sender,
    this.receiver,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'content': content,
      'showTime': showTime,
      'sender': sender,
      'receiver': receiver
    };
  }
}
