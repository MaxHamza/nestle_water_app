import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/cubits/home/my_cart_cubit.dart';
import 'package:nestle_waters_project/presentation/home/pages/details_page.dart';
import 'package:nestle_waters_project/presentation/home/pages/new_home.dart';
import 'package:nestle_waters_project/presentation/onboarding/pages/onboarding_page.dart';
import 'package:nestle_waters_project/presentation/onboarding/pages/trash.dart';
import 'package:nestle_waters_project/presentation/splash_pages/splash_screen.dart';
import 'cubits/home/home_cubit.dart';
import 'cubits/home/offer_cubit.dart';
import 'cubits/splash_cubit.dart';
import 'data/models/cart_item.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
      )
  );
  runApp(MultiBlocProvider(
  providers: [
  BlocProvider(create: (context)=>HomeCubit(Dio())..fetchCompanyName()),
    BlocProvider(create: (context)=>MyCartCubit()),
  BlocProvider(create: (context)=>OfferCubit(Dio())..fetchOffer()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context)..initial(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:const SplashPage(),
        theme: ThemeData(),
      ),
    );
  }
}
