import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/cubits/home/home_cubit.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/cubits/home/offer_cubit.dart';
import 'package:nestle_waters_project/data/models/offers.dart';

import '../../../data/models/cart_item.dart';
import 'details_page.dart';
import 'mycart.dart';

class CompanyView extends StatefulWidget {
   CompanyView({super.key, required this.companyName});

  final String companyName;

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  List<Offers>company=[];
  List<int> quantities = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(

      backgroundColor: Color(0xffEEF7FF),
      appBar: AppBar(
        title: Text(widget.companyName, style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      body: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          if(state is OffersSuccess) {
            company= state.offer.where((e)=>e.company['name']==widget.companyName).toList();
            if (quantities.length != company.length) {
              quantities = List.generate(
                  company.length,
                      (i) => company[i].quantity
              );
            }
            return Container(
              height: height,
              width: width,
              color: Colors.white,
              child:    GridView.builder(
              shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: height * 0.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: company.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                index: index,
                                quantity: quantities[index],
                              )));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/zamzam.jpeg',
                            height: height * 0.15,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(company[index].title),
                          SizedBox(height: height * 0.01),
                          Text(
                            '${company[index].price.toString()} ل.س',
                            style: const TextStyle(color: Colors.deepOrange),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantities[index] > 1) {
                                        quantities[index]--;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    '-',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                quantities[index].toString(),
                                style: TextStyle(color: primaryColor),
                              ),
                              const Spacer(),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      quantities[index]++;
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
                          SizedBox(
                            height: height * 0.01,
                          ),
                          MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            onPressed: () {
                              var newItem = CartItem(
                                  quantity: quantities[index],
                                  title: company[index].title,
                                  description: company[index].description,
                                  index: state.offer.indexOf(company[index]),
                                  price: company[index].price);
                              BlocProvider.of<MyCartCubit>(context).addToCart(
                                  newItem,
                                  quantity: quantities[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCart()));
                            },
                            color: primaryColor,
                            height: 30,
                            minWidth: width,
                            child: const Text(
                              'الاضافة للسلة',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                // physics: const BouncingScrollPhysics(),
              )
            );
          }
          else if(state is OffersFailure){
           return Center(child: Text(state.message),);
          }
          else{
            return Center(child: CircularProgressIndicator(
              color: primaryColor,
            ),);
          }
        },
      ),
    );
  }
}
