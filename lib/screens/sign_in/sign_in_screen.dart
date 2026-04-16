import 'package:ecommerce_mobile_app/core/assets_gen/assets.gen.dart';
import 'package:ecommerce_mobile_app/core/utils/validator_utils.dart';
import 'package:ecommerce_mobile_app/cubit/sign_in/sign_in_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/sign_in/sign_in_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/screens/sign_in/widgets/social_button.dart';
import 'package:ecommerce_mobile_app/shared/app_button.dart';
import 'package:ecommerce_mobile_app/shared/app_text_field.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<SignInCubit>().signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInCubit>(),
      child: BlocListener<SignInCubit, SignInState>(
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
            context.goNamed(RouteName.dashboardRoute);
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
                    SizedBox(height: 48.h),
                    Text('Sign in', style: AppTypography.headline1),
                    SizedBox(height: 32.h),
                    AppTextField(
                      hintText: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidatorUtils.validateEmail,
                    ),
                    SizedBox(height: 16.h),
                    BlocBuilder<SignInCubit, SignInState>(
                      buildWhen: (_, __) => false,
                      builder: (context, state) {
                        return AppTextField(
                          hintText: 'Password',
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: ValidatorUtils.validatePassword,
                          suffixIcon: GestureDetector(
                            onTap: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.darkGreyOpacity50,
                              size: 20.r,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Continue',
                          isLoading: state.isLoading,
                          onPressed: () => _onSignIn(context),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          "Don't have an Account ? ",
                          style: AppTypography.bodyText2,
                        ),
                        GestureDetector(
                          onTap: () => context.pushNamed(RouteName.signUpRoute),
                          child: Text(
                            'Create One',
                            style: AppTypography.bodyText2.copyWith(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    SocialButton(
                      icon: Assets.icons.icApple.image(
                        width: 24.r,
                        height: 24.r,
                      ),
                      label: 'Continue With Apple',
                      onPressed: () {},
                    ),
                    SizedBox(height: 16.h),
                    SocialButton(
                      icon: Assets.icons.icGoogle.image(
                        width: 24.r,
                        height: 24.r,
                      ),
                      label: 'Continue With Google',
                      onPressed: () {},
                    ),
                    BlocBuilder<SignInCubit, SignInState>(
                      buildWhen: (prev, curr) =>
                          prev.isShowFacebookSignIn !=
                          curr.isShowFacebookSignIn,
                      builder: (context, state) {
                        if (!state.isShowFacebookSignIn) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            SizedBox(height: 16.h),
                            SocialButton(
                              icon: Assets.icons.icFacebook.image(
                                width: 24.r,
                                height: 24.r,
                              ),
                              label: 'Continue With Facebook',
                              onPressed: () {},
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
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
