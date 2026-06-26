import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
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
                
                // Logo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    'assets/images/TF Logo.png',
                    width: 150,
                    height: 150,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 150,
                        height: 150,
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
                          size: 80,
                          color: Color(0xFF8D6E63),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // App Name with cursive-style font
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Tree Familia',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                      letterSpacing: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Subtitle
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Preserve your family legacy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xFF8D6E63),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Create a Family Tree Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to create tree screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A574),
                        foregroundColor: const Color(0xFF3E2723),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFF8D6E63),
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Create a Family Tree',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Import Family Tree Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Navigate to import tree screen
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5D4037),
                        side: const BorderSide(
                          color: Color(0xFFD4A574),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Import Family Tree',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
