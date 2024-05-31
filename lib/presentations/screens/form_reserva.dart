import 'package:app_de_estacionamiento/Core/Entities/usuario.dart';
import 'package:app_de_estacionamiento/Core/Entities/usuarioVehiculo.dart';
import 'package:app_de_estacionamiento/Core/Entities/vehiculo.dart';
import 'package:app_de_estacionamiento/Core/providers/user_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmReservationPage extends ConsumerStatefulWidget {
  const ConfirmReservationPage({Key? key}) : super(key: key);

  @override
  _ConfirmReservationPageState createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState
    extends ConsumerState<ConfirmReservationPage> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _patenteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _marcaController.addListener(_validateForm);
    _modeloController.addListener(_validateForm);
    _patenteController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _marcaController.text.isNotEmpty &&
          _modeloController.text.isNotEmpty &&
          _patenteController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _patenteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioState = ref.watch(usuarioProvider);
    final db = FirebaseFirestore.instance;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Confirmar Reserva'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _modeloController,
                          decoration: const InputDecoration(
                            labelText: 'Modelo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 55),
                        TextFormField(
                          controller: _patenteController,
                          decoration: const InputDecoration(
                            labelText: 'Patente',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: _marcaController,
                          decoration: const InputDecoration(
                            labelText: 'Marca',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: _isButtonEnabled
                              ? () async {
                                  String idDocVehiculo =
                                      db.collection('vehiculos').doc().id;

                                  final nuevoVehiculo = Vehiculo(
                                    patente: _patenteController.text,
                                    marca: _marcaController.text,
                                    modelo: _modeloController.text,
                                    idDuenio: usuarioState
                                        .id, // Convertir a usuario de Firestore
                                  );

                                  final nuevoUsuarioVehiculo = usuarioVehiculo(
                                    idUsuario: usuarioState.id,
                                    idVehiculo:
                                        idDocVehiculo, // Usar el ID único del vehículo
                                  );

                                  await db
                                      .collection('Vehiculos')
                                      .doc(idDocVehiculo)
                                      .set(nuevoVehiculo.toFireStore());

                                  await db
                                      .collection('UsuariosVehiculos')
                                      .add(nuevoUsuarioVehiculo.toFirestore());

                                  context.goNamed(BookingCalendarDemoApp.name);
                                }
                              : null,
                          child: const Center(
                            child: Text('Confirmar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
