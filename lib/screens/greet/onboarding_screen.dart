import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ticktask_flutter/providers/onboarding_provider.dart';
import 'package:ticktask_flutter/screens/greet/greet_page_01.dart';
import 'package:ticktask_flutter/screens/greet/greet_page_02.dart';
import 'package:ticktask_flutter/screens/greet/greet_page_03.dart';
import 'package:ticktask_flutter/screens/greet/name_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final pageIndex = ref.watch(onBoardingProvider);
    final notifier = ref.read(onBoardingProvider.notifier);
    final isLastPage = notifier.isLastPage;

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            notifier.updatePage(index);
          },
          children: const [
            GreetPage01(),
            GreetPage02(),
            GreetPage03(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotWidth: 12,
                  dotHeight: 12,
                  spacing: 8,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
              isLastPage
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NameScreen(),
                          ),
                        );
                      },
                      child: const Text("Done"),
                    )
                  : IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
