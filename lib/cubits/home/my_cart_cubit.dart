import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:nestle_waters_project/data/models/cart_item.dart';
part 'my_cart_state.dart';

class MyCartCubit extends Cubit<CartState> {
  MyCartCubit() : super(CartState(cart:[]));

  void delete(int index)async{
    var noteBox   =Hive.box<CartItem>('cartBox');
   await noteBox.deleteAt(index);
  }
  Future<void> deleteAll()async{
    var noteBox   =Hive.box<CartItem>('cartBox');
    await noteBox.clear();
    emit(CartState(cart: []));
  }
  void loadCart() async{
    var noteBox   =Hive.box<CartItem>('cartBox');
    List<CartItem> allItems = noteBox.values.toList();
    emit(CartState( cart: allItems));
  }

  void addToCart(CartItem item,{int?quantity }) async{
    var noteBox   =Hive.box<CartItem>('cartBox');

    final updatedCart = noteBox.values.toList();
    final existingItem = updatedCart.firstWhereOrNull(
          (e) => e.index == item.index,
    );

    if (existingItem != null) {

      final index = updatedCart.indexOf(existingItem);
     final updatedItem = CartItem(
        index: existingItem.index,
        title: existingItem.title,
        description: existingItem.description,
        price: existingItem.price,
        quantity: existingItem.quantity + (quantity??1),
      );
      updatedCart[index]=updatedItem;
      noteBox.putAt(index,updatedItem);
    } else {
      updatedCart.add(item);
      noteBox.add(item);
    }

    emit(state.copyWith(cart: updatedCart));
  }

  void removeOrDecrease(CartItem item) {
    final updatedCart = List<CartItem>.from(state.cart!);

    final existingItem = updatedCart.firstWhereOrNull(
          (e) => e.index == item.index,
    );

    if (existingItem != null) {
      final index = updatedCart.indexOf(existingItem);
      if (existingItem.quantity > 1) {
        updatedCart[index] = CartItem(
          index: existingItem.index,
          title: existingItem.title,
          description: existingItem.description,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedCart.removeAt(index);
      }

      emit(state.copyWith(cart: updatedCart));
    }
  }

  double? totalPrice() {
    return state.cart?.fold(
      0,
          (sum, item) => sum! + (item.price * item.quantity),
    );
  }

  int totalCount() {
    return state.cart!.fold(0, (sum, item) => sum + item.quantity);
  }



  String displayReceipt() {
    final buffer = StringBuffer();
    buffer.writeln("Here's your receipt.\n");
    final date = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    buffer.writeln(date);
    buffer.writeln('\n--------------');

    for (var item in state.cart!) {
      buffer.writeln('${item.quantity}x ${item.title} - ${_formatPrice(item.price)}');
      buffer.writeln('--------------');
    }

    buffer.writeln('\nTotal Items: ${totalCount()}');
    buffer.writeln('Total Price: ${_formatPrice(totalPrice()!)}');

    return buffer.toString();
  }

  String _formatPrice(double price) => '\$${price.toStringAsFixed(2)}';
  }
  // late Box<CartItem> cartBox;
  //
  // Future<void> init() async {
  //   cartBox = Hive.box<CartItem>('cartBox');
  //   loadCart();
  // }
  //
  // void loadCart() {
  //   emit(MyCartLoaded(cartBox.values.toList()));
  // }

  // void addItem(CartItem item) async {
  //   await cartBox.put(item.index, item);
  //   loadCart();
  // }
  //
  // void removeItem(int key) async {
  //   await cartBox.delete(key);
  //   loadCart();
  // }
  //
  // void clearCart() async {
  //   await cartBox.clear();
  //   loadCart();
  // }

