import 'package:diskonindonesia/pages/auth/loginPage.dart';
import 'package:diskonindonesia/pages/auth/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:diskonindonesia/pages/auth/registPage.dart' hide SplashScreen hide SplashScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kxzcxxbzlxfeqxkybrfx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4emN4eGJ6bHhmZXF4a3licmZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwNzg1NTQsImV4cCI6MjA2ODY1NDU1NH0.YMJCI8jXn6G7L3t-xuRs8KvSl1wjXFTR8uNLr84E5DU',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiskonIndonesia',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
