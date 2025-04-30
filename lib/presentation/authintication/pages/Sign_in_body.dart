import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/presentation/authintication/pages/sign_up.dart';
import '../../../core/constants/app_colors.dart';
import '../../../cubits/authintication_cubits/sign_in_cubit.dart';


class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>(); // استخدمه خارج BlocBuilder

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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                child: Text(
                  'تسجيل الدخول',
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
                      height: height * 0.43,
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
                              'تسجيل الدخول',
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
                                        if(value!.length<3){
                                          return'ادخل اسم مستخدم صحيح';
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
                                          hintText: 'ادخل اسم المستخدم',
                                          hintTextDirection: TextDirection.rtl),
                                      controller: cubit.emailCon,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  BlocBuilder<SignInCubit, SignInCubitState>(
                                    builder: (context, state) {
                                      return SizedBox(
                                        height: 50,
                                        width: width * 0.85,
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.length<8){
                                              return'ادخل كلمة مرور صحيحة';
                                            }
                                            return null;
                                          },
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                        SignInCubit>(context)
                                                        .hide();
                                                  },
                                                  icon: BlocProvider
                                                      .of<SignInCubit>(context)
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
                                              .of<SignInCubit>(context)
                                              .visible,
                                          controller: cubit.passCon,
                                          keyboardType:
                                          TextInputType.visiblePassword,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.04,),
                                  MaterialButton(
                                    onPressed: () {
                                      if(cubit.formKey.currentState!.validate()){
                                        BlocProvider.of<SignInCubit>(context)
                                            .login(username1: cubit.emailCon.text,
                                            password1: cubit.passCon.text,
                                            context: context);
                                      }
                                    },
                                    height: 40,
                                    minWidth: width * 0.85,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'تسجيل الدخول', style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    color: primaryColor,
                                  ),
                                  TextButton(onPressed: () {},
                                      child: Text('هل نسيت كلمة السر ؟')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                            }, child: Text('سجل الان', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: primaryColor
                        ),)),
                        Text('ليس لديك حساب؟'),
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
