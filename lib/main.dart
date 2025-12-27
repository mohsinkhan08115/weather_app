import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/theme/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key}); // ab9f0d97d14d4a589d5160859252512

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(ThemeNotifierProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: dartTheme,
      themeMode: themeMode,

      title: 'Weather',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
