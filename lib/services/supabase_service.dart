import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // TODO: Replace with your actual Supabase URL and Anon Key
  static const String supabaseUrl = 'https://xgaaycwyazpljoncmvco.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhnYWF5Y3d5YXpwbGpvbmNtdmNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYxNzg5OTEsImV4cCI6MjA4MTc1NDk5MX0._5qQw_waT6a26nN4rHx916To1hwOLxuea3aQcFaWE6M';

  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
