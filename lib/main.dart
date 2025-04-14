import 'package:flutter/material.dart';
import 'package:shopping_cart_bloc/DependencyInjection/service_locator.dart';
import 'package:shopping_cart_bloc/Screens/Home/ui/home_screen.dart';

void main() {
  //mescp added
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.tealAccent, // AppBar, etc.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.orange, // Accent/floating button
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
