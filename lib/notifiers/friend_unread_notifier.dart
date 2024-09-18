import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsUnreadCountsNotifier extends StateNotifier<int> {
  FriendsUnreadCountsNotifier() : super(0);

  void updateCount(int count) {
    state = count;
  }
}