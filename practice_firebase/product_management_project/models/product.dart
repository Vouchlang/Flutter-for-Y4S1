class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String userId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'],
      userId: map['userId'] ?? '',
    );
  }
}
