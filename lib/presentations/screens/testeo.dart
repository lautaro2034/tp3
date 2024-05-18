import 'package:app_de_estacionamiento/Core/Entities/user.dart';
import 'package:flutter/material.dart';

class testeo extends StatelessWidget {
  static final String nombre = 'testeo';
  user elUsuario;

  testeo({super.key, required this.elUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(elUsuario.nombre),
            Text(this.elUsuario.password),
          ],
        ),
      ),
    );
  }
}
