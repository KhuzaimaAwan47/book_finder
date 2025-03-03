import 'package:book_finder/pages/home_page.dart';
import 'package:book_finder/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeManager = ThemeManager();
  await themeManager.loadTheme();



  runApp(
    ChangeNotifierProvider.value(
      value: themeManager,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeManager.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}