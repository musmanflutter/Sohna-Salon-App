import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedIndexProvider extends StateNotifier<int> {
  SelectedIndexProvider() : super(0);

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}

final indexProvider = StateNotifierProvider<SelectedIndexProvider, int>(
  (ref) {
    return SelectedIndexProvider();
  },
);
