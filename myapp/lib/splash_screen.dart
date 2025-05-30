import 'package:flutter/material.dart';
import 'dart:async';
import 'sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textScaleController;
  late Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();

    _textScaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textScaleAnimation = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _textScaleController,
        curve: Curves.easeInOutExpo,
      ),
    );

    _textScaleController.forward();

    // Navigate to SignInPage after delay
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    });
  }

  @override
  void dispose() {
    _textScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _textScaleAnimation,
            // ...existing code...
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'logo.jpg', // <-- Replace with your logo asset path
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'STOCK TRADE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // ...existing code...
          ),
        ),
      ),
    );
  }
}
