class PhotoModel {
  int? id;
  int? lieu_id;
  String? url_photo;

  PhotoModel({this.id, this.lieu_id, this.url_photo});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      lieu_id: json['lieu_id'],
      url_photo: json['url_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'lieu_id': lieu_id, 'url_photo': url_photo};
  }
}
