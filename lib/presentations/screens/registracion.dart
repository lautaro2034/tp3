import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passWordTextController = TextEditingController();
  final TextEditingController _nombreTextController = TextEditingController();
  final TextEditingController _apellidoTextController = TextEditingController();
  static const String nombre = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Future<void> _register() async {
    try {
      // Registrar usuario con Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget._emailTextController.text,
        password: widget._passWordTextController.text,
      );

      // se asigna el user que surga de la creacion del correo y password
      // Puede aceptar un null
      User? user = userCredential.user;

      // Verifica que el usuario creado no haya llegado en null
      if (user != null) {
        // Crear instancia de Usuario
        Usuario newUser = Usuario(
            id: user.uid,
            email: widget._emailTextController.text,
            contrasenia: widget._passWordTextController.text,
            nombre: widget._nombreTextController.text,
            apellido: widget._apellidoTextController.text);

        // Crear documento en Firestore con el UID del usuario
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Utilizar user.uid directamente aquí
            .set(newUser.toFirestore());

        // Navegar a la pantalla de inicio (o a donde desees)
        context.goNamed(Login.name); // Asegúrate de que '/' es la ruta correcta
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'El correo electrónico ya está en uso por otra cuenta.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es demasiado débil.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'El correo electrónico es inválido.';
      } else {
        errorMessage = 'Error al registrar el usuario: ${e.message}';
      }

      print('Error al registrar el usuario: $errorMessage');

      // Muestra un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print('Error al registrar el usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar el usuario: $e')),
      );
    }
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
            const Icon(
              Icons.assignment_add,
              color: Colors.white,
              size: 150,
            ),

            const SizedBox(height: 20),

            //EMAIL
            TextField(
              style: TextStyle(color: Colors.white),
              controller: widget._emailTextController,
              style: const TextStyle(color: Colors.white),
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
              style: TextStyle(color: Colors.white),
              controller: widget._passWordTextController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Ingrese una clave',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            //NOMBRE
            TextField(
              style: TextStyle(color: Colors.white),
              controller: widget._nombreTextController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Nombre',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            //APELLIDO
            TextField(
              style: TextStyle(color: Colors.white),
              controller: widget._apellidoTextController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Apellido',
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
                onPressed: _register, // Llama a la función _register
                child: const Text('Crear'),
              ),
            ),

            SizedBox(height: 20.5),

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
                  context.goNamed(Login
                      .name); // Asegúrate de que `Login.nombre` es la ruta correcta
                },
                child: const Text('Cancelar'),
              ),
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
