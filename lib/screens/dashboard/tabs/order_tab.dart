import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Text('My Orders', style: AppTypography.headline1),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: _orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final order = _orders[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, String> order) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ${order['id']}',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildStatusChip(order['status']!),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 24.r,
                    color: AppColors.darkGreyOpacity50,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['product']!,
                      style: AppTypography.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${order['quantity']} item · \$${order['total']}',
                      style: AppTypography.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order['date']!, style: AppTypography.bodyText2),
              Text(
                'Track Order',
                style: AppTypography.bodyText2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Delivered':
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
      case 'Shipping':
        bgColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFE65100);
      case 'Processing':
        bgColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1565C0);
      default:
        bgColor = AppColors.lightGrey;
        textColor = AppColors.darkGrey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status,
        style: AppTypography.bodyText2.copyWith(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

final _orders = [
  {
    'id': '#1234',
    'product': "Men's Harrington Jacket",
    'quantity': '1',
    'total': '148.00',
    'status': 'Shipping',
    'date': 'Apr 10, 2026',
  },
  {
    'id': '#1230',
    'product': "Max Cirro Men's Slides",
    'quantity': '2',
    'total': '110.00',
    'status': 'Delivered',
    'date': 'Apr 5, 2026',
  },
  {
    'id': '#1228',
    'product': 'Nike Air Max 90',
    'quantity': '1',
    'total': '120.00',
    'status': 'Processing',
    'date': 'Apr 3, 2026',
  },
  {
    'id': '#1225',
    'product': 'Classic Denim Jacket',
    'quantity': '1',
    'total': '89.00',
    'status': 'Delivered',
    'date': 'Mar 28, 2026',
  },
];
