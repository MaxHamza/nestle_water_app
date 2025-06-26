import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/presentation/home/pages/mycart.dart';

import '../../../core/constants/app_colors.dart';
import '../../../cubits/home/home_cubit.dart';
import '../../../cubits/home/my_cart_cubit.dart';
import '../../../cubits/home/offer_cubit.dart';
import '../../../data/data_source/app_images.dart';
import '../../../data/models/cart_item.dart';
import 'details_page.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  List<String> myItem = AppImages.water;
  final CarouselSliderController _controller = CarouselSliderController();
  List<int> quantities = []; // هنا
  List<CartItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TopBar(),
                SearchInput(),
                PromoCard(),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Headline(),
                CardListView(),
                SHeadline(),
                BestOffers(),
              ],
            ),
          ),
        ));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.25)),
          ]),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.water,
              size: 25,
              color: primaryColor,
            ),
          ),
        ),
        const Text(
          '''ابحث عن أفضل مياه''',
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
          onChanged: (value) {
            //Do something wi
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  PromoCard({Key? key}) : super(key: key);
  List<String> myItem = AppImages.water;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: primaryColor),
        child: Stack(
          children: [
            Opacity(
                opacity: .9,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  ),
                  items: myItem
                      .map((item) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              height: 150,
                              width: width,
                            ),
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "شركات المياه",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "أفضل شركات المياه قريبا منك",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Text(
          "View More",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class SHeadline extends StatelessWidget {
  const SHeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أفضل العروض",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "أفضل عروض المياه لك",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Text(
          "View More",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class CardListView extends StatelessWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is CompanySuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Cards(
                          state.companies[index].name,
                          'assets/images/company.jpeg',
                          '3 minutes',
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.companies.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              );
            } else if (state is CompanyFailure) {
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  const Cards(this.text, this.imageUrl, this.subtitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15),
      child: Container(
        width: 150,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageUrl, height: 70, fit: BoxFit.cover),
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class BestOffers extends StatefulWidget {
  BestOffers({super.key});

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  List<int> quantities = [];
  List<CartItem> items = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is OffersSuccess) {
          // تأكدنا أن quantities لها نفس عدد العروض
          return SizedBox(
            //height: height * 0.6,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: height * 0.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.offer.length,
              itemBuilder: (context, index) {
                if (quantities.length != state.offer.length) {
                  quantities = List.generate(
                      state.offer.length, (_) => state.offer[index].quantity);
                  //we give it length and data
                }
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
                        Text(state.offer[index].title),
                        SizedBox(height: height * 0.01),
                        Text(
                          '${state.offer[index].price.toString()} ل.س',
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
                            Spacer(),
                            Text(
                              quantities[index].toString(),
                              style: TextStyle(color: primaryColor),
                            ),
                            Spacer(),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10))),
                          onPressed: () {
                            var newItem = CartItem(
                                quantity: quantities[index],
                                title: state.offer[index].title,description: state.offer[index].description,
                                index: index,
                                price: state.offer[index].price
                            );
                            BlocProvider.of<MyCartCubit>(context).addToCart(newItem,quantity: quantities[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCart()));
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
            ),
          );
        } else if (state is OffersFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
      },
    );
  }
}
