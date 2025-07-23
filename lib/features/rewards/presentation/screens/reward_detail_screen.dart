import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class RewardDetailScreen extends StatelessWidget {
  final String rewardId;

  const RewardDetailScreen({
    super.key,
    required this.rewardId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reward Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 64,
              color: AppColors.grey400,
            ),
            SizedBox(height: 16),
            Text(
              'Reward Details Coming Soon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}