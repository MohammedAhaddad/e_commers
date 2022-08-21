class AppUser {
  String email;
  String? id;
  String? name;
  String? password;

  AppUser({required this.email, this.name, this.id, this.password});

  Map<String, dynamic> toMap() {
    return {"email": email, "name": name};
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(email: map["email"], name: map['name']);
  }
}
