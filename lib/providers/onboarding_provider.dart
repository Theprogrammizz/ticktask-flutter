import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingNotifier extends StateNotifier<int> {
  OnBoardingNotifier() : super(0);

  final int totalPages = 3;

  void updatePage(int index) {
    state = index;
  }

  bool get isLastPage => state == totalPages - 1;
}

final onBoardingProvider =
    StateNotifierProvider<OnBoardingNotifier, int>((ref) {
  return OnBoardingNotifier();
});