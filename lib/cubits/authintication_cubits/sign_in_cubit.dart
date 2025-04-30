import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/presentation/home/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/authintication/widgets/sign_up_snack.dart';
import '../../presentation/home/pages/main_list.dart';
part 'sign_in_cubit_state.dart';
class SignInCubit extends Cubit<SignInCubitState> {
  SignInCubit() : super(SignInCubitInitial()) {
    emailCon = TextEditingController();
    formKey = GlobalKey<FormState>();
    passCon=TextEditingController();
  }

  late final TextEditingController emailCon;
  late final TextEditingController passCon;
  late final GlobalKey<FormState> formKey;

  @override
  Future<void> close() {
    emailCon.dispose(); // مهم جدًا لتفادي تسرب الذاكرة
    return super.close();
  }
  bool visible=true;
  hide(){
    visible=!visible;
    emit(SignInCubitChangeVis());
  }
  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }
Future<void>login ({required String username1,required String password1,required BuildContext context,})async{
    final String username= username1;
    final String password=password1;
    final dio=Dio(
      BaseOptions(
      baseUrl: 'https://zamzaam.onrender.com',
        headers: {'Content-Type': 'application/json'},
      )
    );
    final queryParameters={
     'username':username,
     'password':password, 
    };
    try {
      final response=await dio.post('/login',queryParameters: queryParameters);

      if (response.statusCode == 200||response.statusCode==201) {
        print('✅ تم تسجيل الدخول بنجاح');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ تم تسجيل الدخول بنجاح',),
        backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));
        await saveLoginState();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()),(route) => false,);
      } else {
        print('⚠️ استجابة غير متوقعة: ${response.statusCode}');
        final signUpSnack = SignUpSnack(response: response.statusCode.toString());
        ScaffoldMessenger.of(context).showSnackBar(signUpSnack.snackBar);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('❌ خطأ من السيرفر: ${e.response?.data}');
        final signUpSnack = SignUpSnack(response: ' البريد الالكتروني او كلمة السر غير صحيحة');
        ScaffoldMessenger.of(context).showSnackBar(signUpSnack.snackBar);
      } else {
        print('❌ خطأ في الاتصال: ${e.message}');
        final signUpSnack = SignUpSnack(response: 'هناك مشكلة بالاتصال بالانترنت!');
        ScaffoldMessenger.of(context).showSnackBar(signUpSnack.snackBar);
      }
    } catch (e) {
      print('❌ خطأ غير متوقع: $e');
      final signUpSnack = SignUpSnack(response: e.toString());
      ScaffoldMessenger.of(context).showSnackBar(signUpSnack.snackBar);
    }
    }
}
