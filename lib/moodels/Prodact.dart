class Prodact {
  String? id;
  late String name;
  late String description;
  late String imag;
  late num price;
  late int quantity;

  Prodact(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.imag});
  Prodact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
    quantity = map['quantity'];
    imag = map['imag'];
  }
  toMap() {
    return {
      'name': name,
      "quantity": quantity,
      'imag': imag,
      'price': price,
      'description': description
    };
  }
}
