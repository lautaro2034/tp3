import 'dart:math';

import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:app_de_estacionamiento/presentations/screens/registracion.dart';
import 'package:app_de_estacionamiento/presentations/widgets/input_text_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  static const String name = 'Login';

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = '';
  String _clave = '';
  final db = FirebaseFirestore.instance;

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

            //Espacio
            const SizedBox(height: 40),

            //EMAIL
            TextField(
              decoration: const InputDecoration(labelText: 'EMAIL'),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),

            // PASS
            TextField(
              decoration: const InputDecoration(labelText: 'PASSWORD'),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _clave = value;
                });
              },
            ),

            /*const InputTextLogin(
                hintText: 'Ingresa tu correo',
                icon: Icon(Icons.email_outlined),
              ),

            //PASSWORD
            const InputTextLogin(
              hintText: 'Ingresa tu contraseña',
              icon: Icon(Icons.key),
            ),
            */

            //Olvdaste la contraseña?
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                '¿Olvidaste la contraseña? Hace click aca',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                ),
              ),
            ),

            //Espacio
            const SizedBox(height: 50),

            //Loguearse
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
                    try {
                      // Realizar la consulta a Firestore para obtener el usuario con el correo electrónico especificado
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection("users")
                          .where("email", isEqualTo: _email)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // Obtener el primer documento que cumple con la consulta
                        QueryDocumentSnapshot userDocument =
                            querySnapshot.docs.first;

                        // Obtener los datos del usuario
                        Map<String, dynamic>? userData =
                            userDocument.data() as Map<String, dynamic>?;

                        if (userData != null) {
                          String? userEmail = userData['email'] as String?;
                          String? userPassword =
                              userData['contrasenia'] as String?;

                          if (userEmail != null && userPassword != null) {
                            // Verificar si el correo electrónico ingresado coincide con el almacenado
                            if (userEmail == _email) {
                              // Verificar si la contraseña ingresada coincide con la almacenada
                              if (userPassword == _clave) {
                                // Usuario autenticado con éxito
                                context.goNamed(Home.name);
                              } else {
                                print('Contraseña incorrecta.');
                              }
                            } else {
                              print(
                                  'El correo electrónico ingresado no coincide con ningún usuario.');
                            }
                          } else {
                            print('Los datos del usuario están incompletos.');
                          }
                        } else {
                          print('No se encontraron datos del usuario.');
                        }
                      } else {
                        print('Usuario no encontrado.');
                      }
                    } catch (e) {
                      print('Error: $e');
                      // Manejar el error
                    }
                  },
                  child: const Text('Login')),
            ),

            const SizedBox(
              height: 20.5,
            ),

            /*Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: const Text('¿No tenes cuenta? Registrate!',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),*/

            //Registrarse / Crear contraseña
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
                    context.goNamed(RegisterScreen.nombre);
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
