import 'package:app_de_estacionamiento/Core/Entities/user.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:app_de_estacionamiento/presentations/screens/testeo.dart';
import 'package:app_de_estacionamiento/presentations/widgets/input_text_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Registracion extends StatelessWidget {
  static const String name = 'Registracion';
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passWordTextController = TextEditingController();

  Registracion({super.key});

  @override
  Widget build(BuildContext context) {
    //final db = FirebaseFirestore.instance;

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

            const SizedBox(height: 20),

            //EMAIL
            TextField(
              controller: _emailTextController,
              decoration: InputDecoration(
                hintText: 'Ingrese un correo',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            //PASSWORD
            TextField(
              controller: _passWordTextController,
              decoration: InputDecoration(
                hintText: 'Ingrese una clave',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 40),

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
                    user elusuario = user(
                        nombre: _emailTextController.text,
                        password: _passWordTextController.text);
                    context.goNamed(testeo.nombre, extra: elusuario);
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
