import 'package:book_finder/pages/home_page.dart';
import 'package:book_finder/theme/theme.dart' as AppTheme;
import 'package:book_finder/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: const MyApp(),
    ),
  );
  //runApp(MyApp());

}

class MyApp extends StatelessWidget{
  const MyApp({super.key,});

  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book Hive',
          theme: AppTheme.lightMode,
          darkTheme: AppTheme.darkMode,
          themeMode: themeManager.themeMode,
          initialRoute: '/',
          home:  const HomePage(),

        );
      },
    );
  }
}