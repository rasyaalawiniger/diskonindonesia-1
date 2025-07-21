import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  PageController pageController = PageController();
  int currentIndex = 0;
  
  late AnimationController _animationController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      icon: Icons.local_offer_rounded,
      title: "Dapatkan Diskon\nTerbaik",
      description: "Temukan ribuan promo dan diskon menarik dari berbagai merchant terpercaya di seluruh Indonesia",
      color: const Color(0xFF23282E),
    ),
    OnboardingData(
      icon: Icons.star_rounded,
      title: "Kumpulkan Poin\nLoyalty",
      description: "Setiap pembelian memberikan poin reward yang bisa ditukar dengan diskon dan hadiah menarik",
      color: const Color(0xFF23282E),
    ),
    OnboardingData(
      icon: Icons.notifications_active_rounded,
      title: "Notifikasi Promo\nTerbaru",
      description: "Jangan sampai terlewat! Dapatkan pemberitahuan untuk setiap promo dan penawaran terbatas",
      color: const Color(0xFF23282E),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _startAnimations();
  }

  void _startAnimations() {
    _animationController.forward();
    _fadeController.forward();
  }

  void _resetAnimations() {
    _animationController.reset();
    _fadeController.reset();
    _startAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 60),
                  // Page indicators
                  Row(
                    children: List.generate(
                      onboardingPages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? const Color(0xFF23282E)
                              : const Color(0xFF23282E).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  // Skip button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF23282E).withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                  _resetAnimations();
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon with animation
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFF23282E),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF23282E).withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                onboardingPages[index].icon,
                                size: 56,
                                color: const Color(0xFFF5F5F5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        
                        // Title with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
                          )),
                          child: FadeTransition(
                            opacity: Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(CurvedAnimation(
                              parent: _fadeController,
                              curve: const Interval(0.2, 1.0),
                            )),
                            child: Text(
                              onboardingPages[index].title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF23282E),
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Description with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                          )),
                          child: FadeTransition(
                            opacity: Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(CurvedAnimation(
                              parent: _fadeController,
                              curve: const Interval(0.4, 1.0),
                            )),
                            child: Text(
                              onboardingPages[index].description,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color(0xFF23282E).withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Bottom navigation
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  currentIndex > 0
                      ? TextButton.icon(
                          onPressed: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Color(0xFF23282E),
                          ),
                          label: Text(
                            'Back',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF23282E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(width: 80),
                  
                  // Next/Get Started button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentIndex < onboardingPages.length - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF23282E),
                        foregroundColor: const Color(0xFFF5F5F5),
                        elevation: 8,
                        shadowColor: const Color(0xFF23282E).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentIndex < onboardingPages.length - 1
                                ? 'Next'
                                : 'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}