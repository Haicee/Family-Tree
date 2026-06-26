import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/onboarding_service.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFEF9E7), // Cream
              Color(0xFFFFF8E1), // Light cream
              Color(0xFFF5E6D3), // Warm beige
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Logo/Illustration
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A574).withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD4A574),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.account_tree,
                      size: 64,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // App Name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Tree Familia',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Description
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Preserve your family history,\nconnect generations, and keep\nmemories alive—all offline.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xFF8D6E63),
                      height: 1.5,
                    ),
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Features
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildFeatureItem(
                        icon: Icons.offline_bolt,
                        text: 'Offline First',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        icon: Icons.security,
                        text: 'Your Data, Your Control',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        icon: Icons.family_restroom,
                        text: 'Connect Generations',
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Get Started Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        await OnboardingService.markWelcomeSeen();
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A574),
                        foregroundColor: const Color(0xFF3E2723),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFFD4A574),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Color(0xFF8D6E63),
          ),
        ),
      ],
    );
  }
}
