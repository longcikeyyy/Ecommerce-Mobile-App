import 'package:ecommerce_mobile_app/core/assets_gen/assets.gen.dart';
import 'package:ecommerce_mobile_app/screens/sign_in/widgets/social_button.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
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
              SizedBox(height: 48.h),
              Text('Sign in', style: AppTypography.headline1),
              SizedBox(height: 32.h),
              AppTextField(
                hintText: 'Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.darkGreyOpacity50,
                    size: 20.r,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              AppButton(text: 'Continue', onPressed: () {}),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  style: AppTypography.bodyText2,
                  children: [
                    const TextSpan(text: "Don't have an Account ? "),
                    TextSpan(
                      text: 'Create One',
                      style: AppTypography.bodyText2.copyWith(
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              SocialButton(
                icon: Assets.icons.icApple.svg(width: 24.r, height: 24.r),
                label: 'Continue With Apple',
                onPressed: () {},
              ),
              SizedBox(height: 16.h),
              SocialButton(
                icon: Assets.icons.icApple.svg(width: 24.r, height: 24.r),
                label: 'Continue With Google',
                onPressed: () {},
              ),
              SizedBox(height: 16.h),
              SocialButton(
                icon: Assets.icons.icApple.svg(width: 24.r, height: 24.r),
                label: 'Continue With Facebook',
                onPressed: () {},
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
