import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyButtomNavbar extends StatelessWidget {
  // void Function(int)? onTabChange;
  static const String name = 'MyButtomNavbar';

  const MyButtomNavbar({
    super.key,
    //required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                context.goNamed(ScreenMenuLateral.name);
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ),
      ),
      // Para situar el navbar por debajo
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),

          // Libreria de google_nav_bar
          child: GNav(
            color: Colors.grey[400],
            activeColor: Colors.grey.shade700,
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: Colors.grey.shade100,
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 16,
            gap: 8,
            //onTabChange: (value) => onTabChange!(value),

            tabs: const [
              // Boton de icono + 'Reservar'

              GButton(
                icon: Icons.garage_outlined,
                text: 'Reservar',
              ),

              // Boton de icono + 'Mis Reservas'
              GButton(
                icon: Icons.list,
                text: 'Mis Reservas',
              ),

              // Boton de icono + 'Buscar Auto'
              GButton(
                icon: Icons.search,
                text: 'Buscar Auto',
              ),
            ],
          )),
    );
  }
}
