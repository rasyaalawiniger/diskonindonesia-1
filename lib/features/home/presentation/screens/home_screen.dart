import 'package:diskonindonesia/core/services/auth_service.dart';
import 'package:diskonindonesia/features/home/presentation/widgets/gamifaction_section.dart';
import 'package:diskonindonesia/features/home/presentation/widgets/recent_transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/services/auth_services.dart';
import '../widgets/points_balance_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/featured_offers_section.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final user = authState.user;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(authServiceProvider.notifier).refreshUserData();
          },
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.primaryDark,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                    ),
                    padding: const EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: AppColors.white.withOpacity(0.2),
                              child: const Icon(
                                Icons.person,
                                color: AppColors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back,',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    user?.name ?? 'User',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => context.push('/qr-scanner'),
                              icon: const Icon(
                                Icons.qr_code_scanner,
                                color: AppColors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Points Balance Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: PointsBalanceCard(
                    pointsBalance: user?.pointsBalance ?? 0,
                    walletBalance: user?.walletBalance ?? 0.0,
                  ),
                ),
              ),

              // Quick Actions
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                  child: QuickActionsGrid(),
                ),
              ),

              // Gamification Section
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.md),
                  child: GamificationSection(),
                ),
              ),

              // Featured Offers
              const SliverToBoxAdapter(
                child: FeaturedOffersSection(),
              ),

              // Recent Transactions
              const SliverToBoxAdapter(
                child: RecentTransactionsSection(),
              ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.xxl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}