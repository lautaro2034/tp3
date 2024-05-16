import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
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
    
    
  ],
);
