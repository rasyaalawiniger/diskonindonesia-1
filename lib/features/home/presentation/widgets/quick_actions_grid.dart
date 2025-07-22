import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickAction(
        icon: Icons.qr_code_scanner,
        label: 'Scan QR',
        color: AppColors.info,
        onTap: () => context.push('/qr-scanner'),
      ),
      QuickAction(
        icon: Icons.local_offer,
        label: 'Coupons',
        color: AppColors.warning,
        onTap: () => context.go('/coupons'),
      ),
      QuickAction(
        icon: Icons.card_giftcard,
        label: 'Rewards',
        color: AppColors.success,
        onTap: () => context.go('/rewards'),
      ),
      QuickAction(
        icon: Icons.share,
        label: 'Refer Friends',
        color: AppColors.accent,
        onTap: () => context.push('/referral'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppSizes.md),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSizes.sm,
            mainAxisSpacing: AppSizes.sm,
            childAspectRatio: 1,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _QuickActionItem(action: action);
          },
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final QuickAction action;

  const _QuickActionItem({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  action.icon,
                  color: action.color,
                  size: AppSizes.iconMd,
                ),
              ),
              
              const SizedBox(height: AppSizes.xs),
              
              Text(
                action.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}