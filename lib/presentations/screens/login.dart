import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:app_de_estacionamiento/Core/providers/user_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/registracion.dart';
import 'package:app_de_estacionamiento/presentations/widgets/input_text_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  static const String name = 'Login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = '';
  String _clave = '';
  final ValueNotifier<bool> _showPassword =
      ValueNotifier<bool>(false); // Usar ValueNotifier

  @override
  void dispose() {
    _showPassword.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Logo del Login
            const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 120,
            ),

            // Espacio
            const SizedBox(height: 40),

            // EMAIL
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'EMAIL'),
              onChanged: (value) {
                _email = value;
              },
            ),

            // CONTRASEÑA
            ValueListenableBuilder<bool>(
              valueListenable: _showPassword,
              builder: (context, showPassword, _) {
                return TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    // Configuración del campo de contraseña para que sea oculto
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showPassword.value = !_showPassword
                            .value; // Alternar visibilidad de la contraseña
                      },
                    ),
                  ),
                  // Configuración del campo de contraseña para que sea oculto o visible según el estado
                  obscureText: !showPassword,
                  onChanged: (value) {
                    _clave = value;
                  },
                );
              },
            ),

            // Olvidaste la contraseña?
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                '¿Olvidaste la contraseña? Hace click aca',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                ),
              ),
            ),

            // Espacio
            const SizedBox(height: 50),

            // Loguearse
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
                  onPressed: () async {
                    // Resto del código omitido por brevedad
                  },
                  child: const Text('Login')),
            ),

            const SizedBox(
              height: 20.5,
            ),

            // Registrarse / Crear contraseña
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
                    // Resto del código omitido por brevedad
                  },
                  child: const Text('Registrate')),
            ),
          ],
        ),
      ),
    );
  }

  // App Bar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Login V1'),
      centerTitle: true,
      backgroundColor: Colors.blue[200],
    );
  }
}
