import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/presentation/home/pages/home_page.dart';
import 'package:nestle_waters_project/presentation/home/pages/main_list.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/cart_item.dart';
import '../widgets/cart.dart';
import 'details_page.dart';
class MyCart extends StatelessWidget {
  const MyCart({super.key, this.quantity});

  final int? quantity;

  @override
  Widget build(BuildContext context) {
    var cartBox = Hive.box<CartItem>('cartBox');
    List<CartItem> cartItems = cartBox.values.toList();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: BlocBuilder<MyCartCubit, MyCartState>(
          builder: (context, state) {
            if (state is MyCartLoaded) {
              return Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: Text(
                        'عربتي',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffEEF7FF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      width: width,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          index: state.items[index].index,
                                          quantity: quantity ?? 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Cart(
                                    items: state.items,
                                    index: index,
                                    quantity: quantity ?? 1,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          MaterialButton(
                            onPressed: () {
                              showDeleteConfirmation(context);
                            },
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: primaryColor),
                            ),
                            minWidth: width * 0.9,
                            color: Colors.white,
                            child: Text(
                              'افراغ العربة',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MaterialButton(
                              minWidth: width,
                              color: primaryColor,
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onPressed: () {
                                // Action here
                              },
                              child: const Text(
                                'متابعة إلى الدفع',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
           return   Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: Text(
                        'عربتي',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffEEF7FF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      width: width,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: cartBox.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          index: cartItems[index].index,
                                          quantity: quantity ?? 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Cart(
                                    items: cartItems,
                                    index: index,
                                    quantity: quantity ?? 1,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          MaterialButton(
                            onPressed: () {
                              showDeleteConfirmation(context);
                            },
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: primaryColor),
                            ),
                            minWidth: width * 0.9,
                            color: Colors.white,
                            child: Text(
                              'افراغ العربة',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MaterialButton(
                              minWidth: width,
                              color: primaryColor,
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onPressed: () {
                                // Action here
                              },
                              child: const Text(
                                'متابعة إلى الدفع',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

void showDeleteConfirmation(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('تأكيد الحذف'),
            content: Text('هل أنت متأكد أنك تريد حذف هذا العنصر؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // إلغاء
                child: Text('إلغاء'),
              ),
              TextButton(
                onPressed: () async {
              await    BlocProvider.of<MyCartCubit>(context).deleteAll();
                   BlocProvider.of<MyCartCubit>(context).loadCart();
                  Navigator.pop(context);
                },
                child: Text('حذف', style: TextStyle(color: Colors.red)),
              ),
            ],
          ));
}
