import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
              Icons.admin_panel_settings,
              size: 64,
              color: AppColors.grey400,
            ),
            SizedBox(height: 16),
            Text(
              'Admin Dashboard Coming Soon',
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