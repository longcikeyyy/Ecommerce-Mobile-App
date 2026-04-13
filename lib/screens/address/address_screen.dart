import 'package:ecommerce_mobile_app/cubit/address/address_cubit.dart';
import 'package:ecommerce_mobile_app/cubit/address/address_state.dart';
import 'package:ecommerce_mobile_app/di/injector.dart';
import 'package:ecommerce_mobile_app/router/route_name.dart';
import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressCubit>()..loadAddresses(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primary,
            onPressed: () async {
              final result = await context.pushNamed(RouteName.addAddressRoute);
              if (result == true && context.mounted) {
                context.read<AddressCubit>().loadAddresses();
              }
            },
            child: const Icon(Icons.add, color: AppColors.white),
          ),
          body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.errorMessage.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              style: AppTypography.bodyText2,
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () => context
                                  .read<AddressCubit>()
                                  .loadAddresses(),
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
                      );
                    }

                    if (state.addresses.isEmpty) {
                      return Center(
                        child: Text(
                          'No addresses yet',
                          style: AppTypography.bodyText2,
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      itemCount: state.addresses.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final address = state.addresses[index];
                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  address.fullAddress,
                                  style: AppTypography.bodyText1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              GestureDetector(
                                onTap: () async {
                                  final result = await context.pushNamed(
                                    RouteName.addAddressRoute,
                                    extra: address,
                                  );
                                  if (result == true && context.mounted) {
                                    context
                                        .read<AddressCubit>()
                                        .loadAddresses();
                                  }
                                },
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
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        children: [
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
          Expanded(
            child: Center(
              child: Text('Address', style: AppTypography.headline3),
            ),
          ),
          SizedBox(width: 36.r),
        ],
      ),
    );
  }
}
