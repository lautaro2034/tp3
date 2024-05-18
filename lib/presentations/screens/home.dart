import 'package:app_de_estacionamiento/presentations/screens/admin_reservation_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/form_reserva.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_buscar_auto.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
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
      _selectedIndex = index;
    });
  }

  // Paginas a mostrar
  final List<Widget> _pages = [
    // Screen de retiro de auto
    const Text('Retirar Auto'),

    // Calendario de las reservas
    //ConfirmReservationPage(),
    const BookingCalendarDemoApp(),
    //const AdminReservationCalendar(),

    // Screen de busqueda de auto
    const BuscadorAuto()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScreenMenuLateral(),
      drawer: const DrawerMenuLateral(),
      bottomNavigationBar: MyButtomNavbar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
