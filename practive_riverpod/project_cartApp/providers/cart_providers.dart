import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state[index].quantity += 1;
      state = [...state];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (state[index].quantity > 1) {
        state[index].quantity -= 1;
        state = [...state];
      } else {
        state = state.where((item) => item.product.id != product.id).toList();
      }
    }
  }

  void clearCart() {
    state = [];
  }
}
