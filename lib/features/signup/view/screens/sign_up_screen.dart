import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_form/features/signup/cubit/sign_up_cubit.dart';
import 'package:nti_form/features/signup/view/widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (context) => SignUpCubit(),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
