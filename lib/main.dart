import 'package:app_de_estacionamiento/Core/appRouter.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  Intl.defaultLocale = 'es_ES';
  initializeDateFormatting("es_ES");

  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
 // );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
