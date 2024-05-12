import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/drawer_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  static const String name = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ScreenMenuLateral(),
      drawer: DrawerMenuLateral(),
      bottomNavigationBar: MyButtomNavbar(),
    );


  }
  

  
}
