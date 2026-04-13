import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_mobile_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/home/home_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/models/response/category_response.dart';
import 'package:ecommerce_mobile_app/models/response/product_response.dart';
import 'package:ecommerce_mobile_app/core/utils/string_utils.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()
        ..loadCategories()
        ..loadTopSellingProducts(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildHeader(),
                SizedBox(height: 20.h),
                _buildSearchBar(),
                SizedBox(height: 24.h),
                _buildSectionHeader('Categories', onSeeAll: () {}),
                SizedBox(height: 16.h),
                _buildCategoriesSection(),
                SizedBox(height: 24.h),
                _buildSectionHeader('Top Selling', onSeeAll: () {}),
                SizedBox(height: 16.h),
                _buildTopSellingSection(),
                SizedBox(height: 24.h),
                _buildSectionHeader('New In', onSeeAll: () {}),
                SizedBox(height: 16.h),
                _buildProductGrid(_newInProducts),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColors.lightGrey,
          child: Icon(Icons.person, size: 24.r, color: AppColors.darkGrey),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Text('Men', style: AppTypography.bodyText1),
              SizedBox(width: 4.w),
              Icon(Icons.keyboard_arrow_down, size: 20.r),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.shopping_bag_outlined,
            size: 20.r,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20.r, color: AppColors.darkGreyOpacity50),
          SizedBox(width: 12.w),
          Text('Search', style: AppTypography.bodyText2),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.headline2),
        GestureDetector(
          onTap: onSeeAll,
          child: Text('See All', style: AppTypography.bodyText2),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
            height: 90.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage.isNotEmpty) {
          return SizedBox(
            height: 90.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage, style: AppTypography.bodyText2),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => context.read<HomeCubit>().loadCategories(),
                    child: Text(
                      'Retry',
                      style: AppTypography.bodyText2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.categories.isEmpty) {
          return SizedBox(
            height: 90.h,
            child: Center(
              child: Text('No categories', style: AppTypography.bodyText2),
            ),
          );
        }

        return _buildCategories(state.categories);
      },
    );
  }

  Widget _buildCategories(List<CategoryResponseModel> categories) {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.lightGrey,
                backgroundImage: CachedNetworkImageProvider(category.image),
              ),
              SizedBox(height: 8.h),
              Text(
                StringUtils.capitalize(category.name),
                style: AppTypography.bodyText2.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopSellingSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isTopSellingLoading) {
          return SizedBox(
            height: 260.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.topSellingErrorMessage.isNotEmpty) {
          return SizedBox(
            height: 260.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.topSellingErrorMessage,
                    style: AppTypography.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () =>
                        context.read<HomeCubit>().loadTopSellingProducts(),
                    child: Text(
                      'Retry',
                      style: AppTypography.bodyText2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.topSellingProducts.isEmpty) {
          return SizedBox(
            height: 260.h,
            child: Center(
              child: Text(
                'No top selling products',
                style: AppTypography.bodyText2,
              ),
            ),
          );
        }

        return _buildTopSellingProductGrid(state.topSellingProducts);
      },
    );
  }

  Widget _buildTopSellingProductGrid(List<ProductResponseModel> products) {
    return SizedBox(
      height: 260.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildTopSellingProductCard(product);
        },
      ),
    );
  }

  Widget _buildTopSellingProductCard(ProductResponseModel product) {
    return SizedBox(
      width: 170.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180.h,
                width: 170.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Center(
                    child: SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 48.r,
                      color: AppColors.darkGreyOpacity50,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 16.r,
                    color: product.isFavorite ? Colors.red : AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            product.name,
            style: AppTypography.bodyText2.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                _formatCurrency(product.price),
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (product.oldPrice != null) ...[
                SizedBox(width: 8.w),
                Text(
                  _formatCurrency(product.oldPrice!),
                  style: AppTypography.bodyText2.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.darkGreyOpacity50,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Map<String, dynamic>> products) {
    return SizedBox(
      height: 260.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return SizedBox(
      width: 170.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180.h,
                width: 170.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 48.r,
                    color: AppColors.darkGreyOpacity50,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 16.r,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            product['name'] as String,
            style: AppTypography.bodyText2.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '\$${product['price']}',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (product['oldPrice'] != null) ...[
                SizedBox(width: 8.w),
                Text(
                  '\$${product['oldPrice']}',
                  style: AppTypography.bodyText2.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.darkGreyOpacity50,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(num value) => '\$${value.toStringAsFixed(2)}';
}

final _newInProducts = [
  {'name': 'Nike Air Max 90', 'price': '120.00', 'oldPrice': '150.00'},
  {'name': 'Classic Denim Jacket', 'price': '89.00', 'oldPrice': null},
  {'name': 'Running Shorts', 'price': '35.00', 'oldPrice': '49.99'},
];
