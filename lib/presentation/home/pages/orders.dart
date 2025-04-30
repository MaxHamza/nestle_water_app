import 'package:flutter/material.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: primaryColor ,
      body:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            height: height*0.1,
            child: SafeArea(child: Align(
                alignment: Alignment.topRight,
                child: Text('طلباتي',style: TextStyle(color: Colors.white,fontSize: 20),)),),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color: Color(0xffEEF7FF)
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.05),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error,size: 90,color: primaryColor,),
                        Text('You dont have any order',style: TextStyle(
                          color: primaryColor,
                          fontSize: 20
                        ),)
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              width: width,
            ),
          )
        ],
      )
    );
  }
}
