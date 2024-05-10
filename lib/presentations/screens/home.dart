import 'package:app_de_estacionamiento/presentations/screens/screen_menu_lateral.dart';
import 'package:app_de_estacionamiento/presentations/widgets/input_text_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  static const String name = 'Home';
  const Home({super.key});

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
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 150,
            ),

            const SizedBox(height: 40),

            //USERNAME
            const InputTextLogin(
                hintText: 'Ingresa tu nombre de usuario',
                icon: Icon(Icons.accessibility_new_sharp)),

            //PASSWORD
            const InputTextLogin(
                hintText: 'Ingresa tu contraseña', icon: Icon(Icons.key)),

            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                '¿Olvidaste la contraseña? Hace click aca',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                ),
              ),
            ),

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
                    context.goNamed(ScreenMenuLateral.name);
                  },
                  child: const Text('Login')),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: const Text('¿No tenes cuenta? Registrate!',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Login form V1'),
      centerTitle: true,
      backgroundColor: Colors.blue[200],
    );
  }
}
