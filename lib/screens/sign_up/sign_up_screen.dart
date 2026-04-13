import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
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
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: 'Lastname',
                controller: _lastNameController,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: 'Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 32.h),
              AppButton(text: 'Continue', onPressed: () {}),
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
    );
  }
}
