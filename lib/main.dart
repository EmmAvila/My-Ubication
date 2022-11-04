import 'package:flutter/material.dart';
import 'package:my_position/screens/login_screen.dart';
import 'package:my_position/screens/map_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ubication',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MapsScreen.routeName: (context) => const MapsScreen(),
      },
      theme: ThemeData.light().copyWith(),
    );
  }
}
