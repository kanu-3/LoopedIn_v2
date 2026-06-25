import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://cmhkcktwcasvumyeakpv.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNtaGtja3R3Y2FzdnVteWVha3B2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0Njc1MzEsImV4cCI6MjA5NjA0MzUzMX0.R6Amk4hk2oXap9RF7DlnXzyd1oIBwmLDm_1h0tftNG0',
    );
  }

  static SupabaseClient get client =>
      Supabase.instance.client;
}