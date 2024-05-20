import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:app_de_estacionamiento/presentations/screens/registracion.dart';
//import 'package:app_de_estacionamiento/presentations/screens/testeo.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const BookingCalendarDemoApp(),
      name: BookingCalendarDemoApp.name,
    ),
  ],
);
