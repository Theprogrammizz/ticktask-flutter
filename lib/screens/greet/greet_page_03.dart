import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetPage03 extends StatelessWidget {
  const GreetPage03({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Lottie.asset(
              "assets/images/anim_two.json",
              height: 300,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: const [
              Text(
                "Manage Your Time",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Stay organized and plan your tasks so nothing slips through the cracks.",
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
