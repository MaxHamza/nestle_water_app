import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:nestle_waters_project/presentation/authintication/widgets/sign_up_snack.dart';
import 'package:nestle_waters_project/presentation/home/pages/home_page.dart';
import 'package:nestle_waters_project/presentation/home/pages/main_list.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() :
        emailCon = TextEditingController(),
  formKey = GlobalKey<FormState>(),
  passCon=TextEditingController(),
        userCon=TextEditingController(),
        resetPassCon=TextEditingController(),
        super(SignUpInitial());


  late final TextEditingController emailCon;
  late final TextEditingController userCon;
  late final TextEditingController passCon;
  late final TextEditingController resetPassCon;
  late final GlobalKey<FormState> formKey;

  @override
  Future<void> close() {
    emailCon.dispose(); // مهم جدًا لتفادي تسرب الذاكرة
    return super.close();
  }
  bool visible=true;
  hide(){
    visible=!visible;
    emit(SignUpCubitChangeVis());
  }

  Future<void> createUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://zamzaam.onrender.com',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final data = {
      "username": username,
      "email": email,
      "password": password,
      "role":'user',
    };

    try {
       final response = await dio.post('/users/', data: data);

      if (response.statusCode == 200||response.statusCode==201) {
        print('✅ تم إنشاء المستخدم بنجاح');
        final snackBar=SignUpSnack(response:'✅ تم إنشاء المستخدم بنجاح' );
        ScaffoldMessenger.of(context).showSnackBar(snackBar.snackBar);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()),(route) => false,);
      } else {
        print('⚠️ استجابة غير متوقعة: ${response.statusCode}');
        final signUpSnack = SignUpSnack(response: response.statusCode.toString());
        ScaffoldMessenger.of(context).showSnackBar(signUpSnack.snackBar);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('❌ خطأ من السيرفر: ${e.response?.data}');
        final signUpSnack = SignUpSnack(response: 'صيغة البريد الالكتروني او كلمة السر غير صحيحة');
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
