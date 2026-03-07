import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetPage02 extends StatelessWidget {
  const GreetPage02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Lottie.asset(
              "assets/images/anim_three.json",
              height: 180,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: const [
              Text(
                "Plan Your Day",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Create tasks, set priorities, and schedule them for the right time.",
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
