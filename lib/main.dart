import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/app/app.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize();

  runApp(
    const ProviderScope(
      child: LoopedInApp(),
    ),
  );
}