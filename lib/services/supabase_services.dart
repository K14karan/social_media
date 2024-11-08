import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static final SupabaseClient supabase = Supabase.instance.client;

  SupabaseServices._internal();
  static final SupabaseServices instance = SupabaseServices._internal();
}
