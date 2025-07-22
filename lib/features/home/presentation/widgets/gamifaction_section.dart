import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class GamificationSection extends StatelessWidget {
  const GamificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Activities',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/missions'),
              child: const Text('View All'),
            ),
          ],
        ),
        
        const SizedBox(height: AppSizes.md),
        
        Row(
          children: [
            Expanded(
              child: _GamificationCard(
                icon: Icons.check_circle_outline,
                title: 'Daily Check-in',
                subtitle: 'Earn 10 points',
                color: AppColors.success,
                isCompleted: false, // TODO: Get from state
                onTap: () => context.push('/daily-checkin'),
              ),
            ),
            
            const SizedBox(width: AppSizes.sm),
            
            Expanded(
              child: _GamificationCard(
                icon: Icons.casino_outlined,
                title: 'Spin Wheel',
                subtitle: 'Try your luck!',
                color: AppColors.warning,
                isCompleted: false, // TODO: Get from state
                onTap: () => context.push('/spin-wheel'),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSizes.sm),
        
        _MissionProgressCard(),
      ],
    );
  }
}

class _GamificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isCompleted;
  final VoidCallback onTap;

  const _GamificationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isCompleted ? null : onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: isCompleted
                ? Border.all(color: AppColors.success, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.success.withOpacity(0.1)
                          : color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : icon,
                      color: isCompleted ? AppColors.success : color,
                      size: AppSizes.iconSm,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                      ),
                      child: Text(
                        'DONE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: AppSizes.sm),
              
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: AppSizes.xs),
              
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MissionProgressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Get actual mission data from state
    const currentProgress = 3;
    const totalRequired = 5;
    const progressPercentage = currentProgress / totalRequired;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: const Icon(
                  Icons.flag_outlined,
                  color: AppColors.info,
                  size: AppSizes.iconSm,
                ),
              ),
              
              const SizedBox(width: AppSizes.sm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Mission',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Make 5 transactions this week',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                '$currentProgress/$totalRequired',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSizes.sm),
          
          LinearProgressIndicator(
            value: progressPercentage,
            backgroundColor: AppColors.grey200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.info),
            borderRadius: BorderRadius.circular(AppSizes.radiusXs),
          ),
          
          const SizedBox(height: AppSizes.xs),
          
          Text(
            'Reward: 100 bonus points',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}