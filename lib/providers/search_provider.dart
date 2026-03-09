import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProvider extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void searchQuery(String query) {
    state = query.toLowerCase();
  }
}

final searchQueryProvider = NotifierProvider<SearchProvider, String>(
  () {
    return SearchProvider();
  },
);
