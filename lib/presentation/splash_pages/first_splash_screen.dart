import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset('assets/images/logo.png',
          width: width*0.4,
          height: height*0.2,
        ),
      ),
    );
  }
}
