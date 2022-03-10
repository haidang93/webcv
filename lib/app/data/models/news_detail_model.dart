class NewsDetail {
  String id;
  String author;
  String title;
  String status;
  String content;
  String preview;
  String url;
  String image;
  String language;
  int state;
  List<String> categories;
  List<String> tag;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String source;
  Stat stat;
  Draft draft;

  NewsDetail(
      {this.id,
      this.author,
      this.title,
      this.status,
      this.content,
      this.preview,
      this.url,
      this.image,
      this.language,
      this.state,
      this.categories,
      this.tag,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.source,
      this.stat,
      this.draft});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    status = json['status'];
    content = json['content'];
    preview = json['preview'];
    url = json['url'];
    image = json['image'];
    language = json['language'];
    state = json['state'];
    categories = json['categories'].cast<String>();
    tag = json['tag'].cast<String>();
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    source = json['source'];
    stat = json['stat'] != null ? Stat.fromJson(json['stat']) : null;
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['title'] = title;
    data['status'] = status;
    data['content'] = content;
    data['preview'] = preview;
    data['url'] = url;
    data['image'] = image;
    data['language'] = language;
    data['state'] = state;
    data['categories'] = categories;
    data['tag'] = tag;
    data['published_at'] = publishedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['source'] = source;
    if (stat != null) {
      data['stat'] = stat.toJson();
    }
    if (draft != null) {
      data['draft'] = draft.toJson();
    }
    return data;
  }
}

class Stat {
  int like;
  int dislike;
  int share;

  Stat({this.like, this.dislike, this.share});

  Stat.fromJson(Map<String, dynamic> json) {
    like = json['like'];
    dislike = json['dislike'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['like'] = like;
    data['dislike'] = dislike;
    data['share'] = share;
    return data;
  }
}

class Draft {
  String title;
  String content;
  String image;
  String author;
  String createdUserEmail;
  String createdUserName;
  String createdUserId;
  String preview;

  Draft(
      {this.title,
      this.content,
      this.image,
      this.author,
      this.createdUserEmail,
      this.createdUserName,
      this.preview,
      this.createdUserId});

  Draft.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    author = json['author'];
    createdUserEmail = json['created_user_email'];
    createdUserName = json['created_user_name'];
    createdUserId = json['created_user_id'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['author'] = author;
    data['created_user_email'] = createdUserEmail;
    data['created_user_name'] = createdUserName;
    data['created_user_id'] = createdUserId;
    data['preview'] = preview;
    return data;
  }
}
