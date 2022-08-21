class ImagModel {
  late String url;
  late String id;
  ImagModel({
    required this.url,
  });

  ImagModel.fromMap(Map<String, dynamic> map) {
    url = map['url'];
  }

  toMap() {
    return {'url': url};
  }
}
