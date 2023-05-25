class Message {
  late String id;
  late String date;
  late String content;
  late bool fromMe;
  bool showTime = true;

  Message(this.id, this.content, this.fromMe, this.date);

  Message.time(this.id, this.content, this.fromMe, this.showTime, this.date);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'content': content,
      'fromMe': fromMe,
      'showTime': showTime,
    };
  }
}
