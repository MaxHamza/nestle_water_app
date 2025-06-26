import 'package:flutter/material.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/presentation/home/pages/main_list.dart';
import 'package:nestle_waters_project/presentation/home/pages/mycart.dart';
import 'package:nestle_waters_project/presentation/home/pages/orders.dart';
import 'package:nestle_waters_project/presentation/home/pages/profile.dart';

import 'new_home.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 3;

  final List<Widget> pages = [
    Profile(),
    MyCart(),
    Orders(),
    NewHome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: Color(0xffF5F7F8)	,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: primaryColor,    // لون العنصر المحدد
          unselectedItemColor: Colors.grey,  // لون العناصر الغير محددة
          selectedIconTheme: IconThemeData(size: 30), // تكبير الايقونة المحددة
          unselectedIconTheme: IconThemeData(size: 24),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'القائمة الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'عربتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
          ],
        ),
      ),
    );
  }
}