
class Notif {

  int? id;
  String? title;
  String? content;
  String? type;
  String? image;
  String? link;

  // extra attribute
  int? createdAt;
  bool isRead = false;

  Notif(this.title, this.content){
    this.type = "NORMAL";
    this.createdAt = DateTime.now().millisecondsSinceEpoch;
    this.id = this.createdAt;
  }

  Notif.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.content = json['content'];
    this.type = json['type'];
    this.image = json['image'];
    this.link = json['link'];
    this.createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'type': type,
    'image': image,
    'link': link,
    'createdAt': createdAt,
  };

}