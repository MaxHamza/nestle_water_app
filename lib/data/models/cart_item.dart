import 'package:hive/hive.dart';
part 'cart_item.g.dart';
@HiveType(typeId: 0)
class CartItem  extends HiveObject{
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String title;
  @HiveField(2)
 final String description;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final double price;
  CartItem ({required this.quantity,required this.index,required this.description,required this.price,required this.title});
}