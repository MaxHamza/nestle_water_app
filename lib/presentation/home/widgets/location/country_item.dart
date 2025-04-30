import 'package:flutter/material.dart';
class CountryItem extends StatelessWidget {
  const CountryItem({super.key, required this.flag,required this.title});
 final String flag;
 final String title;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image.asset(flag,
        height: height*0.15,
        ),
        SizedBox(height: height*0.03,),
         Text(title),
      ],
    );
  }
}
