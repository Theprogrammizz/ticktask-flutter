import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationController extends StateNotifier<int> {
  NavigationController() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}

final navProvider = StateNotifierProvider<NavigationController, int>(
  (ref) {
    return NavigationController();
  },
);
