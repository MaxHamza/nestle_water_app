import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nestle_waters_project/data/data_source/app_images.dart';
import 'package:nestle_waters_project/presentation/home/widgets/location/country_item.dart';
class CarouselDemo extends StatelessWidget {
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  List<List<String>> myItem = AppImages.country;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
        children: <Widget>[
          CarouselSlider(
            items: [
              CountryItem(title: myItem[0][1], flag: myItem[0][0],),
              CountryItem(title: myItem[1][1], flag: myItem[1][0],),
              CountryItem(title: myItem[2][1], flag: myItem[2][0],),
              CountryItem(title: myItem[3][1], flag: myItem[3][0],),
              CountryItem(title: myItem[4][1], flag: myItem[4][0],),
            ],
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.5,
              enableInfiniteScroll: true,
              aspectRatio: 2.0,
              initialPage: 0,
              height: MediaQuery.of(context).size.height*0.3,
            ),
          ),
        ]
    );
  }
}