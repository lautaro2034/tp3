import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/my_bottom_navbar.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Home(),
      name: Home.name,
    ),
    GoRoute(
      path: '/myButtomNavBar',
      builder: (context, state) => MyButtomNavbar(),
      name: MyButtomNavbar.name,
    ),
    GoRoute(
      path: '/screenLateral',
      builder: (context, state) => ScreenMenuLateral(),
      name: ScreenMenuLateral.name,
    ),
  ],
);
