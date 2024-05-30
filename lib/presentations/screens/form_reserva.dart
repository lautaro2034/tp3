import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:app_de_estacionamiento/Core/Entities/usuarioVehiculo.dart';
import 'package:app_de_estacionamiento/Core/Entities/vehiculo.dart';
import 'package:app_de_estacionamiento/Core/providers/user_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmReservationPage extends ConsumerWidget {
  const ConfirmReservationPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    // Obtener el estado actual del usuario
    final usuarioState = ref.watch(usuarioProvider);
    final db = FirebaseFirestore.instance;
    TextEditingController _marcaController = TextEditingController();
    TextEditingController _modeloController = TextEditingController();
    TextEditingController _patenteController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Confirmar Reserva'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //INPUT MODELO
              TextFormField(
                controller: _modeloController,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 55),

              //INPUT PATENTE
              TextFormField(
                controller: _patenteController,
                decoration: const InputDecoration(
                  labelText: 'Patente',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 50),

              //INPUT MARCA
              TextFormField(
                controller: _marcaController,
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () async {
                  String idDocVehiculo = db.collection('vehiculos').doc().id;

                  final nuevoVehiculo = Vehiculo(
                    patente: _patenteController.text,
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    idDuenio:
                        usuarioState.id, // Convertir a usuario de Firestore
                  );

                  final nuevoUsuarioVehiculo = usuarioVehiculo(
                    idUsuario: usuarioState.id,
                    idVehiculo: idDocVehiculo, // Usar el ID único del vehículo
                  );

                  await db
                      .collection('Vehiculos')
                      .doc(idDocVehiculo)
                      .set(nuevoVehiculo.toFireStore());

                  await db
                      .collection('UsuariosVehiculos')
                      .add(nuevoUsuarioVehiculo.toFirestore());

                  // Hacer lo que necesites con el ID del usuario
                  context.goNamed(BookingCalendarDemoApp.name);
                },
                child: const Center(child: Text('confirmar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
