import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              CircleAvatar(
                radius: 48.r,
                backgroundColor: AppColors.darkGreyOpacity50,
                child: Icon(
                  Icons.person,
                  size: 48.r,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 20.h),
              _buildInfoCard(),
              SizedBox(height: 16.h),
              _buildMenuItem(
                title: 'Address',
                onTap: () => context.pushNamed(RouteName.addressRoute),
              ),
              SizedBox(height: 8.h),
              _buildMenuItem(title: 'Wishlist', onTap: () {}),
              SizedBox(height: 8.h),
              _buildMenuItem(title: 'Payment', onTap: () {}),
              SizedBox(height: 8.h),
              _buildMenuItem(title: 'Help', onTap: () {}),
              SizedBox(height: 8.h),
              _buildMenuItem(title: 'Support', onTap: () {}),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Sign Out',
                  style: AppTypography.bodyText1.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gilbert Jones',
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Gilbertjones001@gmail.com',
                  style: AppTypography.bodyText2,
                ),
                SizedBox(height: 4.h),
                Text(
                  '121-224-7890',
                  style: AppTypography.bodyText2,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Edit',
              style: AppTypography.bodyText2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTypography.bodyText1),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.r,
              color: AppColors.darkGreyOpacity50,
            ),
          ],
        ),
      ),
    );
  }
}
