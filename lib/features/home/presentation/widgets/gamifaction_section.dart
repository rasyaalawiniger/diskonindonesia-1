import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class GamificationSection extends StatelessWidget {
  const GamificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final gamificationItems = [
      GamificationItem(
        icon: Icons.check_circle_outline,
        title: 'Daily Check-in',
        subtitle: 'Earn 10 points daily',
        color: AppColors.success,
        onTap: () => context.push('/daily-checkin'),
      ),
      GamificationItem(
        icon: Icons.casino_outlined,
        title: 'Spin the Wheel',
        subtitle: 'Try your luck!',
        color: AppColors.warning,
        onTap: () => context.push('/spin-wheel'),
      ),
      GamificationItem(
        icon: Icons.flag_outlined,
        title: 'Missions',
        subtitle: 'Complete challenges',
        color: AppColors.info,
        onTap: () => context.push('/missions'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gamification',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppSizes.md),
        
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gamificationItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppSizes.sm),
          itemBuilder: (context, index) {
            final item = gamificationItems[index];
            return _GamificationCard(item: item);
          },
        ),
      ],
    );
  }
}

class _GamificationCard extends StatelessWidget {
  final GamificationItem item;

  const _GamificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: AppSizes.iconMd,
                ),
              ),
              
              const SizedBox(width: AppSizes.md),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Icon(
                Icons.arrow_forward_ios,
                size: AppSizes.iconSm,
                color: AppColors.grey500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const GamificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}