import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State <HomePage> {
  @override
  Widget build(BuildContext context){
    Provider.of<ThemeManager>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Hive'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Login');
              }, icon: Icon(Icons.logout),
            ),
            IconButton(
              onPressed: (){
                Provider.of<ThemeManager>(context, listen: false).toggleTheme();
              }, icon: const Icon(Icons.brightness_6),
            )
          ],
        ),
        body: Center(
          child: Text('Home Page',style: Theme.of(context).textTheme.titleLarge,),
        )
    );
  }
}