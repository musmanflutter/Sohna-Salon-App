import 'package:flutter_riverpod/flutter_riverpod.dart';

class OthersIndexProvider extends StateNotifier<int> {
  OthersIndexProvider() : super(0);

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}

final othersIndex = StateNotifierProvider<OthersIndexProvider, int>(
  (ref) {
    return OthersIndexProvider();
  },
);
