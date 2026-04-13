import 'package:ecommerce_mobile_app/core/utils/validator_utils.dart';
import 'package:ecommerce_mobile_app/cubit/sign_up/sign_up_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/sign_up/sign_up_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<SignUpCubit>().signUp(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
          }

          if (state.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Account created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            context.pop();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: const BoxDecoration(
                          color: AppColors.lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16.r,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text('Create Account', style: AppTypography.headline1),
                    SizedBox(height: 28.h),
                    AppTextField(
                      hintText: 'Firstname',
                      controller: _firstNameController,
                      validator: (value) => ValidatorUtils.validateRequired(
                        value,
                        fieldName: 'Firstname',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      hintText: 'Lastname',
                      controller: _lastNameController,
                      validator: (value) => ValidatorUtils.validateRequired(
                        value,
                        fieldName: 'Lastname',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      hintText: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidatorUtils.validateEmail,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      validator: ValidatorUtils.validatePassword,
                    ),
                    SizedBox(height: 32.h),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Continue',
                          isLoading: state.isLoading,
                          onPressed: () => _onSignUp(context),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    RichText(
                      text: TextSpan(
                        style: AppTypography.bodyText2,
                        children: [
                          const TextSpan(text: 'Forgot Password ? '),
                          TextSpan(
                            text: 'Reset',
                            style: AppTypography.bodyText2.copyWith(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
