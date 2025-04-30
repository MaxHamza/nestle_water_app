import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/cubits/authintication_cubits/sign_up_cubit.dart';
import 'package:nestle_waters_project/presentation/authintication/pages/sign_in.dart';

import '../../../core/constants/app_colors.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>(); // استخدمه خارج BlocBuilder

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                child: Text(
                  'انشاء حساب',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffEEF7FF),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(28),
                        topLeft: Radius.circular(28))),
                width: width,
                height: height * 0.9,
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.04, horizontal: width * 0.03),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: width * 0.4,
                    ),
                    SizedBox(height: height * 0.05),
                    Container(
                      width: width,
                      height: height * 0.52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'انشاء حساب جديد',
                              style:
                              TextStyle(fontSize: 20, color: primaryColor),
                            ),
                            SizedBox(height: height * 0.02),
                            Form(
                              key: cubit.formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: width * 0.85,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value==null||value.length<3){
                                          return 'الرجاء عدم ترك الحقل فارغا';
                                        }
                                        return null;
                                      },
                                      textDirection: TextDirection.rtl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: 'اسم المستخدم',
                                          hintTextDirection: TextDirection.rtl),
                                      controller: cubit.userCon,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    height: 50,
                                    width: width * 0.85,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value==null||value.length<8){
                                          return 'الرجاء عدم ترك الحقل فارغا';
                                        }
                                        return null;
                                      },
                                      textDirection: TextDirection.rtl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: 'البريد الالكتروني العنوان',
                                          hintTextDirection: TextDirection.rtl),
                                      controller: cubit.emailCon,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  BlocBuilder<SignUpCubit, SignUpState>(
                                    builder: (context, state) {
                                      return SizedBox(
                                        height: 50,
                                        width: width * 0.85,
                                        child: TextFormField(
                                          validator: (value){
                                            if(value==null||value.length<8){
                                              return 'الرجاء عدم ترك الحقل فارغا';
                                            }
                                            return null;
                                          },
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                              prefixIcon: IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                        SignUpCubit>(context)
                                                        .hide();
                                                  },
                                                  icon: BlocProvider
                                                      .of<SignUpCubit>(context)
                                                      .visible == true
                                                      ? Icon(Icons
                                                      .remove_red_eye_outlined)
                                                      : Icon(Icons
                                                      .visibility_off_outlined)),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hintText: 'كلمة المرور',
                                              hintTextDirection: TextDirection
                                                  .rtl),
                                          obscureText: BlocProvider
                                              .of<SignUpCubit>(context)
                                              .visible,
                                          controller: cubit.passCon,
                                          keyboardType:
                                          TextInputType.visiblePassword,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  BlocBuilder<SignUpCubit, SignUpState>(
                                    builder: (context, state) {
                                      return SizedBox(
                                        height: 50,
                                        width: width * 0.85,
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!=cubit.passCon.text){
                                              return 'الرجاء التحقق من صحة كلمة المرور';
                                            }
                                          else  if(value==null||value.length<8){
                                              return 'الرجاء عدم ترك الحقل فارغا';
                                            }
                                            return null;
                                          },
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                              prefixIcon: IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                        SignUpCubit>(context)
                                                        .hide();
                                                  },
                                                  icon: BlocProvider
                                                      .of<SignUpCubit>(context)
                                                      .visible == true
                                                      ? Icon(Icons
                                                      .remove_red_eye_outlined)
                                                      : Icon(Icons
                                                      .visibility_off_outlined)),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hintText: 'ادخل كلمة المرور مجددا',
                                              hintTextDirection: TextDirection
                                                  .rtl),
                                          obscureText: BlocProvider
                                              .of<SignUpCubit>(context)
                                              .visible,
                                          controller: cubit.resetPassCon,
                                          keyboardType:
                                          TextInputType.visiblePassword,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02,),
                                  MaterialButton(
                                    onPressed: () async {
                                      if(cubit.formKey.currentState!.validate()) {
                                        await BlocProvider.of<SignUpCubit>(context)
                                            .createUser(
                                          context: context,
                                          username: cubit.userCon.text,
                                          email: cubit.emailCon.text,
                                          password: cubit.passCon.text,
                                        );

                                      }
                                    },
                                    height: 40,
                                    minWidth: width * 0.85,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: primaryColor,
                                    child:const Text('انشاء حساب', style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                            },
                            child: Text('تسجيل الدخول من هنا', style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: primaryColor
                            ),)),
                        Text('هل لديك حساب؟ '),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
