import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/cubits/authintication_cubits/sign_up_cubit.dart';
import 'package:nestle_waters_project/presentation/authintication/pages/sign_up_body.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>SignUpCubit(),
    child:const SignUpBody(),
    );
  }
}
