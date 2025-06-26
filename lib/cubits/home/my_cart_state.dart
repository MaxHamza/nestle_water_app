part of 'my_cart_cubit.dart';

class CartState {
  final List<CartItem> ?cart;

  CartState({required this.cart});

  CartState copyWith({List<CartItem>? cart}) {
    return CartState(cart: cart ?? this.cart);
  }
}
