import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/calendar_demo.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:app_de_estacionamiento/presentations/screens/pantalla_principal.dart';
import 'package:app_de_estacionamiento/presentations/screens/registracion.dart';
//import 'package:app_de_estacionamiento/presentations/screens/testeo.dart';
import 'package:go_router/go_router.dart';

import '../presentations/screens/mis_reservas.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Login(),
      name: Login.name,
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Home(),
      name: Home.name,
    ),
    GoRoute(
      path: '/registracion',
      builder: (context, state) => RegisterScreen(),
      name: RegisterScreen.nombre,
    ),
    GoRoute(
      path: '/calendarioReserva',
      builder: (context, state) => const Calendar_demo(),
      name: Calendar_demo.name,
    ),
    GoRoute(
      path: '/pantallaPrincipal',
      builder: (context, state) => pantallaPrincipal(),
      name: pantallaPrincipal.name,
    ),
    GoRoute(
      path: '/misReservas',
      builder: (context, state) => const MisReservas(),
      name: MisReservas.name,
    ),
  ],
);
