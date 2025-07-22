import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';

class FeaturedOffersSection extends StatelessWidget {
  const FeaturedOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from state management
    final offers = [
      FeaturedOffer(
        id: '1',
        title: '20% Cashback',
        subtitle: 'On all electronics',
        merchantName: 'TechStore',
        imageUrl: 'https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg',
        color: AppColors.info,
      ),
      FeaturedOffer(
        id: '2',
        title: 'Buy 1 Get 1',
        subtitle: 'Coffee & pastries',
        merchantName: 'CafeDeluxe',
        imageUrl: 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
        color: AppColors.warning,
      ),
      FeaturedOffer(
        id: '3',
        title: '50% Off',
        subtitle: 'Fashion items',
        merchantName: 'StyleHub',
        imageUrl: 'https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg',
        color: AppColors.error,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Offers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.go('/coupons'),
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppSizes.md),
        
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < offers.length - 1 ? AppSizes.sm : 0,
                ),
                child: _FeaturedOfferCard(offer: offer),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FeaturedOfferCard extends StatelessWidget {
  final FeaturedOffer offer;

  const _FeaturedOfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to offer details
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Stack(
              children: [
                // Background image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(offer.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Gradient overlay
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                
                // Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                            vertical: AppSizes.xs,
                          ),
                          decoration: BoxDecoration(
                            color: offer.color,
                            borderRadius: BorderRadius.circular(AppSizes.radiusXs),
                          ),
                          child: Text(
                            offer.merchantName,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: AppSizes.sm),
                        
                        Text(
                          offer.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: AppSizes.xs),
                        
                        Text(
                          offer.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Favorite button
                Positioned(
                  top: AppSizes.sm,
                  right: AppSizes.sm,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: AppSizes.iconSm,
                      color: AppColors.grey600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedOffer {
  final String id;
  final String title;
  final String subtitle;
  final String merchantName;
  final String imageUrl;
  final Color color;

  const FeaturedOffer({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.merchantName,
    required this.imageUrl,
    required this.color,
  });
}