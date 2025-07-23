import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class MerchantAnalyticsScreen extends StatelessWidget {
  const MerchantAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant Analytics'),
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
              Icons.analytics,
              size: 64,
              color: AppColors.grey400,
            ),
            SizedBox(height: 16),
            Text(
              'Merchant Analytics Coming Soon',
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