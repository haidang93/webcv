class HomeItem {
  String photo;
  String title;
  String content;
  String button;
  String routes;

  HomeItem({this.photo, this.title, this.content, this.button, this.routes});

  HomeItem.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    title = json['title'];
    content = json['content'];
    button = json['button'];
    routes = json['routes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['photo'] = photo;
    data['title'] = title;
    data['content'] = content;
    data['button'] = button;
    data['routes'] = routes;
    return data;
  }
}
