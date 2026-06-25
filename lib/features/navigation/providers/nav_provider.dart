import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nav_notifier.dart';
import 'nav_state.dart';

final navProvider =
StateNotifierProvider<NavNotifier, NavState>(
      (ref) => NavNotifier(),
);