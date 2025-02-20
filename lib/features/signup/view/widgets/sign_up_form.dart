import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nti_form/features/signup/cubit/sign_up_cubit.dart';
import 'package:nti_form/features/signup/view/widgets/custom_button.dart';
import 'package:nti_form/features/signup/view/widgets/custom_text_form_field.dart';
import 'package:nti_form/core/constants/countries.dart';
import 'package:nti_form/features/signup/view/widgets/custom_dropdown_form_field.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpInvalid) {
          autovalidateMode = AutovalidateMode.always;
        }
      },
      builder: (context, state) {
        SignUpCubit cubit = BlocProvider.of<SignUpCubit>(context);
        String fullName = '';
        String phoneNumber = '';
        String email = '';
        String password = '';
        String country = '';
        String card = '';
        return Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  fullName = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  phoneNumber = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              CustomDropdownFormField(
                selectedCountry: null,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a country';
                  }
                  return null;
                },
                onChanged: (Country? newValue) {
                  country = newValue?.name ?? '';
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Card',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Card is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  card = value;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  cubit.validateForm(
                    fullName,
                    phoneNumber,
                    email,
                    password,
                    country,
                    card,
                  );
                  if (formKey.currentState!.validate()) {
                    cubit.loading();
                  }
                },
                child: state is SignUpLoading
                    ? LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.greenAccent,
                        leftDotColor: Colors.red,
                        size: 20,
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
