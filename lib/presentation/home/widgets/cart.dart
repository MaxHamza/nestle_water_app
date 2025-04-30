import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/data/models/cart_item.dart';
import 'package:nestle_waters_project/presentation/home/pages/mycart.dart';

class Cart extends StatelessWidget {
  const Cart(
      {super.key,
      required this.items,
      required this.index,
      required this.quantity});

  final List<CartItem> items;
  final int index;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    var item = items[index];
    var box = Hive.box<CartItem>('cartBox');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.005),
      child: Container(
        height: height * 0.2,
        width: width * 0.8,
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: width * 0.33,
                    child: Column(
                      children: [
                        Text(
                          'الكمية',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Colors.grey),
                                right: BorderSide(color: Colors.grey),
                                top: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(onTap: () {}, child: Text('+')),
                              Text(item.quantity.toString()),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  '-',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                showDeleteConfirmation(context, index);
                              },
                              child: Text(
                                'ازالة',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDeleteConfirmation(context, index);
                                },
                                icon: Icon(Icons.delete),
                                color: primaryColor),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: width * 0.33,
                      child: Text(
                        item.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Image.asset(
                    'assets/images/zamzam.jpeg',
                    height: height * 0.09,
                    width: width * 0.33,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              '${item.price} ل.س',
              style:
              TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));
  }
}

void showDeleteConfirmation(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('تأكيد الحذف'),
      content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // إلغاء
          child: Text('إلغاء'),
        ),
        TextButton(
          onPressed: () async {
             BlocProvider.of<MyCartCubit>(context).delete(index);
             BlocProvider.of<MyCartCubit>(context).loadCart();
             Navigator.pop(context);
          },
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

