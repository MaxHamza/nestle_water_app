import 'package:flutter/material.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import '../widgets/location/countries_slider.dart';

class ChooseLocation extends StatelessWidget {
  const ChooseLocation({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Color(0xffEEF7FF),
            ],
              stops: [0.2,0.8],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
      padding: EdgeInsets.symmetric(vertical: height * 0.05),
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: width * 0.25,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'مرحبا',
            style: TextStyle(fontSize: 18, color: primaryColor),
          ),
          SizedBox(
            height: height * 0.03,
          ),
         const Text(textAlign: TextAlign.center,
            'لتقديم تجربة أفضل , نحتاج الى معرفة موقعك. يرجى تحديد تفضيلات موقع التسليم الخاص بك',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: height*0.02,),
        const  Text('حدد الدولة'),
           SizedBox(height: height*0.06,),
          Container(
            height: height*0.3,
            width: width,
            child: CarouselDemo(),
          ),
          SizedBox(height: height*0.05,),
          Container(
            height: height*0.05,
            width: 70,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.all(Radius.circular(18)),
              border: Border.all(color: primaryColor)
            ),
            child: MaterialButton(onPressed: (){},
            child: Text('يكمل',style: TextStyle(
              color: primaryColor
            ),),
            ),
          ),
      const  Spacer(),
          Container(
            height: 1,
            width: width*0.9,
            color: Colors.grey,
          ),
          SizedBox(height: height*0.03,),
          Container(
            height: height*0.06,
            width: width*0.8,
            decoration: BoxDecoration(
                borderRadius:const BorderRadius.all(Radius.circular(18)),
                border: Border.all(color: primaryColor)
            ),
            child: MaterialButton(onPressed: (){},
              child: Row(
                children: [
                  Icon(Icons.gps_fixed,color: primaryColor,),
                  SizedBox(width: width*0.06,),
                  Text('كشف موقع التسليم الخاص بي',style: TextStyle(
                      color: primaryColor
                  ),),

                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
