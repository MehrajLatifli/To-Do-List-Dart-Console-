class ToDo<T extends String,  T3 extends DateTime> {
  T? id;
  T? userId;
  T? title;
  T? text;
  T3? releaseDate;

  ToDo(id, userId, title,text, releaseDate){
    this.id=id;
    this.userId=userId;
    this.title=title;
    this.text=text;

    this.releaseDate=releaseDate;
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      json['id'] as T?,
      json['userId'] as T?,
      json['title'] as T?,
      json['text'] as T?,
      json['releaseDate'] != null ? DateTime.parse(json['releaseDate'] as String) : null,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'text': text,
      'releaseDate': releaseDate?.toIso8601String(),
    };
  }


}