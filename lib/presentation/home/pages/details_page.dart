import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/cubits/home/offer_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../cubits/home/my_cart_cubit.dart';
import '../../../data/models/cart_item.dart';

class DetailsPage extends StatefulWidget {
   DetailsPage({super.key, required this.quantity, required this.index});
  int quantity;
final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xffEEF7FF),
        body: Container(
            padding: EdgeInsets.only(right: width * 0.04,left: width * 0.04,top: height*0.05),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.8, 0.2],
                colors: [
                  primaryColor,
                  const Color(0xffEEF7FF),
                ],
              ),
            ),
        child: BlocBuilder<OfferCubit, OfferState>(
  builder: (context, state) {
    if(state is OffersSuccess){
    return Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: width*0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width,
                  height: height*0.5,
                  child:Image.asset('assets/images/zamzam.jpeg') ,
                ),
                SizedBox(height: height*0.02,),
                Text(
                  state.offer[widget.index].title,style: TextStyle(color: primaryColor,fontSize: 18),),
                SizedBox(height: height*0.02,),
                Align(
                  alignment: Alignment.topRight,
                  child: Text('${state.offer[widget.index].price.toString()} ل.س',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                SizedBox(height: height*0.04,),
                Text(state.offer[widget.index].description,textAlign: TextAlign.center,),
                SizedBox(height: height*0.02,),
                Align(
                    alignment: Alignment.topRight,
                    child: Text('الشركة المصنعة',style: TextStyle(color: primaryColor,fontSize: 18),),),
                SizedBox(height: height*0.02,),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(state.offer[widget.index].company['name'],style: TextStyle(color: primaryColor),),),
                SizedBox(height: height*0.02,),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(state.offer[widget.index].company['description']),),
               SizedBox(height: height*0.1,),
                Align(
                  alignment: Alignment.topRight,
                  child: Text('أضف الكمية'),),
                SizedBox(height: height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (widget.quantity > 1) {
                              widget.quantity--;
                            }
                          });
                        },
                        child: const Text(
                          '-',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: width*0.08,),
                    Text(
                      widget.quantity.toString(),
                      style: TextStyle(color: primaryColor),
                    ),
                    SizedBox(width: width*0.08,),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.quantity++;
                          });
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.02,),
                MaterialButton(onPressed: (){
                  var cartBox = Hive.box<CartItem>('cartBox');
                  var newItem = CartItem(
                      quantity: widget.quantity,
                      title: state.offer[widget.index].title,description: state.offer[widget.index].description,
                      index: widget.index,
                      price: state.offer[widget.index].price
                  );
                  cartBox.add(newItem);
                  BlocProvider.of<MyCartCubit>(context).loadCart();
                },
                  color: Colors.white,
                  minWidth: width,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(
                      color: primaryColor
                    )
                  ),
                height: 50,
                  child: Text('أضف الى العربة',style: TextStyle(color: primaryColor),),
                ),
                SizedBox(height: height*0.08,),
              ],
            ),
          ),
        );
  }
    else if(state is OffersFailure){
    return  Center(child: Text(state.message),);
    }
    else{
    return  Center(child: CircularProgressIndicator(
      color: primaryColor,
      ),);
    }
    },
),
        ));
  }
}
