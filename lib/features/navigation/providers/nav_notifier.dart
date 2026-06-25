import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nav_state.dart';

class NavNotifier extends StateNotifier<NavState> {
  NavNotifier() : super(NavState.initial());

  void setIndex(int index) {
    state = state.copyWith(index: index);
  }
}