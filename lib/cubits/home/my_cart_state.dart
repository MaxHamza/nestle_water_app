part of 'my_cart_cubit.dart';


sealed class MyCartState {}

final class MyCartInitial extends MyCartState {}
class MyCartLoaded extends MyCartState {
  final List<CartItem> items;
  MyCartLoaded(this.items);
}