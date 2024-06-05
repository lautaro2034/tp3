import 'package:app_de_estacionamiento/presentations/screens/admin_reservation_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/calendar_demo.dart';
import 'package:app_de_estacionamiento/presentations/screens/form_reserva.dart';
import 'package:app_de_estacionamiento/presentations/screens/pantalla_principal.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_buscar_auto.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_retiro_auto.dart';
import 'package:app_de_estacionamiento/presentations/widgets/drawer_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  static const String name = 'Home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index + 1;
    });
  }

  // Paginas a mostrar
  final List<Widget> _pages = [
    pantallaPrincipal(),
    //registro de reserva

    const ConfirmReservationPage(),
    // Calendario de las reservas
    const Calendar_demo(),
    //const AdminReservationCalendar(),

    // Screen de retiro de auto

    // Screen de busqueda de auto
    const BuscadorAuto(),
    const RetirarAuto(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScreenMenuLateral(),
      drawer: const DrawerMenuLateral(),
      bottomNavigationBar: MyButtomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _selectedIndex == 0 ? pantallaPrincipal() : _pages[_selectedIndex],
    );
  }
}
