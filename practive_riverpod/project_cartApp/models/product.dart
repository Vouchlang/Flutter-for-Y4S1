class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

final List<Product> products = const [
  Product(id: '1', name: 'Apple', price: 1.5, imageUrl: 'assets/apple.png'),
  Product(id: '2', name: 'Banana', price: 0.8, imageUrl: 'assets/banana.png'),
  Product(id: '3', name: 'Orange', price: 1.2, imageUrl: 'assets/orange.png'),
  Product(id: '4', name: 'Mango', price: 2.0, imageUrl: 'assets/mango.png'),
];
