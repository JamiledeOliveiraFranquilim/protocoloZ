import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  const AppConfig._();

  static const String supabaseUrl =
      'https://sydsmjniyotwbbzonwjr.supabase.co';

  static const String publishableKey =
      'sb_publishable_JE_QjiMsCkkzOiL5GBXF5Q_gH0MACWl';
}

Future<void> main() async {
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    publishableKey: AppConfig.publishableKey,
  );
}