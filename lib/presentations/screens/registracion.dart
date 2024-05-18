import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:app_de_estacionamiento/presentations/widgets/input_text_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Registracion extends StatelessWidget {
  static const String name = 'Registracion';
  const Registracion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Icon(
              Icons.assignment_add,
              color: Colors.white,
              size: 150,
            ),

            const SizedBox(height: 40),

            const InputTextLogin(
                hintText: 'Ingrese correo a registrar',
                icon: Icon(Icons.email_outlined)),

            //PASSWORD
            const InputTextLogin(
                hintText: 'Genere su contraseña', icon: Icon(Icons.key)),

            const SizedBox(height: 50),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ])),
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //context.goNamed(Home.name);
                  },
                  child: const Text('Crear')),
            ),

            SizedBox(
              height: 20.5,
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ])),
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    context.goNamed(Login.name);
                  },
                  child: const Text('Cancelar')),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Registration Form V1'),
      centerTitle: true,
      backgroundColor: Colors.blue[200],
    );
  }
}
