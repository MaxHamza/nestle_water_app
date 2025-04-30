import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nestle_waters_project/core/constants/app_colors.dart';
import 'package:nestle_waters_project/presentation/authintication/pages/Sign_in_body.dart';
import 'package:nestle_waters_project/presentation/authintication/widgets/custom_text_field.dart';

import '../../../cubits/authintication_cubits/sign_in_cubit.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context)=>SignInCubit(),
    child:const SignInBody(),
    );
  }
}
