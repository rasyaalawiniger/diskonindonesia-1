import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constants.dart';

class PointsBalanceCard extends StatelessWidget {
  final int pointsBalance;
  final double walletBalance;

  const PointsBalanceCard({
    super.key,
    required this.pointsBalance,
    required this.walletBalance,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$');

    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Balance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Text(
                  'ACTIVE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSizes.lg),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.stars,
                          color: AppColors.white,
                          size: AppSizes.iconSm,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Text(
                          'Points',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      NumberFormat('#,###').format(pointsBalance),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                width: 1,
                height: 40,
                color: AppColors.white.withOpacity(0.3),
              ),
              
              const SizedBox(width: AppSizes.md),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: AppColors.white,
                          size: AppSizes.iconSm,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Text(
                          'Wallet',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      currencyFormatter.format(walletBalance),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSizes.lg),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to rewards screen
                  },
                  icon: const Icon(Icons.redeem, size: AppSizes.iconSm),
                  label: const Text('Redeem'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.accent,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: AppSizes.sm),
              
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to transaction history
                  },
                  icon: const Icon(Icons.history, size: AppSizes.iconSm),
                  label: const Text('History'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.white),
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}