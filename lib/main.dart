import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyButtomNavbar(),
      ),
    );
  }
}
