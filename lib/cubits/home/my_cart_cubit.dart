import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/data/models/cart_item.dart';

part 'my_cart_state.dart';

class MyCartCubit extends Cubit<MyCartState> {
  MyCartCubit() : super(MyCartInitial());

  void delete(int index)async{
    var noteBox   =Hive.box<CartItem>('cartBox');
   await noteBox.deleteAt(index);
  }
  Future<void> deleteAll()async{
    var noteBox   =Hive.box<CartItem>('cartBox');
    await noteBox.clear();
  }
  void loadCart() async{
    var noteBox   =Hive.box<CartItem>('cartBox');
    List<CartItem> allItems = noteBox.values.toList();
    emit(MyCartLoaded(allItems));
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

}
