import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constants.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from state management
    final transactions = [
      RecentTransaction(
        id: '1',
        merchantName: 'TechStore',
        amount: 299.99,
        pointsEarned: 300,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        status: TransactionStatus.verified,
      ),
      RecentTransaction(
        id: '2',
        merchantName: 'CafeDeluxe',
        amount: 15.50,
        pointsEarned: 16,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: TransactionStatus.verified,
      ),
      RecentTransaction(
        id: '3',
        merchantName: 'StyleHub',
        amount: 89.99,
        pointsEarned: 90,
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: TransactionStatus.pending,
      ),
    ];

    if (transactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.push('/transaction-history'),
                child: const Text('View All'),
              ),
            ],
          ),
          
          const SizedBox(height: AppSizes.md),
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSizes.sm),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return _TransactionItem(transaction: transaction);
            },
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final RecentTransaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final dateFormatter = DateFormat('MMM dd, HH:mm');

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (transaction.status) {
      case TransactionStatus.verified:
        statusColor = AppColors.success;
        statusText = 'Verified';
        statusIcon = Icons.check_circle;
        break;
      case TransactionStatus.pending:
        statusColor = AppColors.warning;
        statusText = 'Pending';
        statusIcon = Icons.access_time;
        break;
      case TransactionStatus.cancelled:
        statusColor = AppColors.error;
        statusText = 'Cancelled';
        statusIcon = Icons.cancel;
        break;
    }

    return Container(
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
          // Merchant icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: const Icon(
              Icons.store,
              color: AppColors.primaryDark,
              size: AppSizes.iconMd,
            ),
          ),
          
          const SizedBox(width: AppSizes.md),
          
          // Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transaction.merchantName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      currencyFormatter.format(transaction.amount),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSizes.xs),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateFormatter.format(transaction.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          size: AppSizes.iconXs,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Text(
                          '+${transaction.pointsEarned}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSizes.xs),
                
                Row(
                  children: [
                    Icon(
                      statusIcon,
                      size: AppSizes.iconXs,
                      color: statusColor,
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecentTransaction {
  final String id;
  final String merchantName;
  final double amount;
  final int pointsEarned;
  final DateTime date;
  final TransactionStatus status;

  const RecentTransaction({
    required this.id,
    required this.merchantName,
    required this.amount,
    required this.pointsEarned,
    required this.date,
    required this.status,
  });
}