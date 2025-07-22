import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google login button
        SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeightLg,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement Google login
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google login coming soon!'),
                ),
              );
            },
            icon: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.g_mobiledata,
                color: Colors.red,
                size: 20,
              ),
            ),
            label: const Text('Continue with Google'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryDark,
              side: const BorderSide(color: AppColors.grey300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: AppSizes.md),
        
        // Apple login button (iOS only)
        if (Theme.of(context).platform == TargetPlatform.iOS)
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeightLg,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Implement Apple login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Apple login coming soon!'),
                  ),
                );
              },
              icon: const Icon(
                Icons.apple,
                color: AppColors.primaryDark,
                size: 24,
              ),
              label: const Text('Continue with Apple'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryDark,
                side: const BorderSide(color: AppColors.grey300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
            ),
          ),
      ],
    );
  }
}