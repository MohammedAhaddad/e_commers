class Catgory {
  late String catId;
  late String name;
  late String ImageUrl;
  Catgory({required this.name, required this.ImageUrl}) {}
  Catgory.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    ImageUrl = map["ImageUrl"];
  }
  toMap() {
    return {'name': name, 'ImageUrl': ImageUrl};
  }
}
