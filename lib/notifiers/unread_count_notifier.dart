import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnreadCountsNotifier extends StateNotifier<int> {
  UnreadCountsNotifier() : super(0);

  void updateCount(int count) {
    state = count;
  }
}
