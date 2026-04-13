import 'package:ecommerce_mobile_app/theme/app_colors.dart';
import 'package:ecommerce_mobile_app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Text('Notifications', style: AppTypography.headline1),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => Divider(
                color: AppColors.lightGrey,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationItem(notification);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, String> notification) {
    final isUnread = notification['isUnread'] == 'true';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.lightGrey,
            child: Icon(
              _getIcon(notification['type']!),
              size: 20.r,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title']!,
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification['subtitle']!,
                  style: AppTypography.bodyText2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  notification['time']!,
                  style: AppTypography.bodyText2.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              width: 8.r,
              height: 8.r,
              margin: EdgeInsets.only(top: 6.h),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.local_shipping_outlined;
      case 'promo':
        return Icons.discount_outlined;
      case 'info':
        return Icons.info_outline;
      default:
        return Icons.notifications_outlined;
    }
  }
}

final _notifications = [
  {
    'title': 'Order Shipped',
    'subtitle': 'Your order #1234 has been shipped and is on its way.',
    'time': '2 min ago',
    'type': 'order',
    'isUnread': 'true',
  },
  {
    'title': '30% Special Discount!',
    'subtitle': 'Get 30% off on all hoodies this weekend only.',
    'time': '1 hour ago',
    'type': 'promo',
    'isUnread': 'true',
  },
  {
    'title': 'Order Delivered',
    'subtitle': 'Your order #1230 has been delivered successfully.',
    'time': '3 hours ago',
    'type': 'order',
    'isUnread': 'false',
  },
  {
    'title': 'New Arrivals',
    'subtitle': 'Check out the latest collection of summer wear.',
    'time': 'Yesterday',
    'type': 'info',
    'isUnread': 'false',
  },
  {
    'title': 'Flash Sale Tomorrow',
    'subtitle': 'Up to 50% off on selected items starting at 10 AM.',
    'time': '2 days ago',
    'type': 'promo',
    'isUnread': 'false',
  },
];
