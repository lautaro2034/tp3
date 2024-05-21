import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class pantallaPrincipal extends StatelessWidget {
  static const String name = 'pantallaPrincipal';
  const pantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Esto elimina la etiqueta de "debug".
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('EGarage (EG)')),
        ),
        body: Center(
          child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('lugares')
                  .doc('idDelDocumento')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                /*   if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                   snapshot.data!.data() as Map<String, dynamic>;*/
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Todavía hay',
                      style: TextStyle(fontSize: 24),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                      ),
                      /* child: Center(
                        child: Text(
                          '${data['lugaresLibres']}', // Aquí se muestra el número de lugares libres de tu base de datos.
                          style: const TextStyle(
                              fontSize: 48, color: Colors.white),
                        ),
                      ),*/
                    ),
                    const Text(
                      'lugares',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                );
              }

              //return const CircularProgressIndicator();
              ),
        ),
      ),
    );
  }
}
