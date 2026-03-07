import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetPage01 extends StatelessWidget {
  const GreetPage01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Lottie.asset(
              "assets/images/anim_one.json",
              width: 500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: const [
              Text(
                "Welcome to TickTask",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Organize your daily tasks and stay focused on what matters most.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 1)
      ],
    ));
  }
}
