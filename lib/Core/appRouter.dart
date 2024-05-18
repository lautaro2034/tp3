import 'package:app_de_estacionamiento/Core/Entities/user.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:app_de_estacionamiento/presentations/screens/registracion.dart';
import 'package:app_de_estacionamiento/presentations/screens/testeo.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Login(),
      name: Login.name,
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Home(),
      name: Home.name,
    ),
    GoRoute(
      path: '/registracion',
      builder: (context, state) => Registracion(),
      name: Registracion.name,
    ),
    GoRoute(
        path: '/testeo',
        builder: (context, state) => testeo(
              elUsuario: state.extra as user,
            ),
        name: testeo.nombre),
  ],
);
