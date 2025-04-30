import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/cubits/home/home_cubit.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/data/data_source/app_images.dart';
import 'package:nestle_waters_project/presentation/home/pages/details_page.dart';
import '../../../cubits/home/offer_cubit.dart';
import '../../../data/models/cart_item.dart';


class MainListPage extends StatefulWidget {
  MainListPage({super.key});

  @override
  State<MainListPage> createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage> {
  List<String> myItem = AppImages.water;
  final CarouselSliderController _controller = CarouselSliderController();
  List<int> quantities = []; // هنا
  List<CartItem>items=[];
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: primaryColor,
              width: width,
              height: height * 0.11,
              padding: EdgeInsets.all(8.0),
              child: SafeArea(
                child: Text(
                  'الصفحة الرئيسية',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 3),
                viewportFraction: 1.0,
                enlargeCenterPage: false,
              ),
              items: myItem
                  .map((item) =>
                  Container(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      height: height,
                    ),
                  ))
                  .toList(),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: width,
              padding: EdgeInsets.only(right: 8),
              child: Text(
                'جميع شركات المياه',
                style: TextStyle(color: primaryColor),
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.2,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CompanySuccess)
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/company.jpeg',
                                height: height * 0.13,
                                width: width * 0.3,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                state.companies[index].name,
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: state.companies.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                    );
                  else if (state is CompanyFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
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
            SizedBox(height: height * 0.02),
            Container(
              width: width,
              padding: EdgeInsets.only(right: 8),
              child: Text(
                'العروض',
                style: TextStyle(color: primaryColor),
                textAlign: TextAlign.end,
              ),
            ),
            BlocBuilder<OfferCubit, OfferState>(
              builder: (context, state) {
                if (state is OffersSuccess) {
                  // تأكدنا أن quantities لها نفس عدد العروض
                  return SizedBox(
                    height: height * 0.6,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: height * 0.4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.offer.length,
                      itemBuilder: (context, index) {
                        if (quantities.length != state.offer.length) {
                          quantities = List.generate(state.offer.length,
                                  (_) => state.offer[index].quantity);
                          //we give it length and data
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(
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
                                  style:
                                  const TextStyle(color: Colors.deepOrange),
                                ),
                                SizedBox(height: height * 0.02),
                                Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () {
                                    var cartBox = Hive.box<CartItem>('cartBox');
                                    var newItem = CartItem(
                                        quantity: quantities[index],
                                        title: state.offer[index].title,description: state.offer[index].description,
                                    index: index,
                                      price: state.offer[index].price
                                    );
                                    cartBox.add(newItem);
                                    items.add(newItem);
                                    BlocProvider.of<MyCartCubit>(context).loadCart();
                                  },
                                  color: primaryColor,
                                  child: Text(
                                    'الاضافة للسلة',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  height: 30,
                                  minWidth: width,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      physics: const BouncingScrollPhysics(),
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
            ),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
