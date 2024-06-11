import 'package:app_de_estacionamiento/Core/Entities/usuarioVehiculo.dart';
import 'package:app_de_estacionamiento/Core/providers/user_provider.dart';
import 'package:app_de_estacionamiento/Core/providers/vehiculo_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/Core/Entities/Vehiculo.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';
import 'package:app_de_estacionamiento/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CalendarDemo extends ConsumerStatefulWidget {
  static final String name = 'CalendarDemo';

  const CalendarDemo({super.key});

  @override
  _CalendarDemoState createState() => _CalendarDemoState();
}

class _CalendarDemoState extends ConsumerState<CalendarDemo> {
  final List<Reserva> algunasReservas = [
    Reserva(
      fecha: 3,
      lote: 1,
      elvehiculo: Vehiculo(
        patente: 'fgh123',
        marca: 'Ferrari',
        modelo: 'modelo',
        idDuenio: "RIWofZj3xzRRHeMRg73YUZCG89m2",
      ),
    ),
  ];

  List<Reserva> reservasDelDia = [];
  int? _selectedButtonIndex;
  int? fechaSeleccionada;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  void _filtrarReservasPorFecha(int dia) {
    setState(() {
      reservasDelDia =
          algunasReservas.where((reserva) => reserva.fecha == dia).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioState = ref.watch(usuarioProvider);
    final vehiculoState = ref.watch(vehiculoProvider);
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Reserva'),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(kToday.year, kToday.month - 3, kToday.day),
            lastDate: DateTime(kToday.year, kToday.month + 3, kToday.day),
            onDateChanged: (DateTime value) {
              setState(() {
                fechaSeleccionada = value.day;
                _selectedButtonIndex = null;
              });
              _filtrarReservasPorFecha(fechaSeleccionada!);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0, // Espacio horizontal entre los elementos
                runSpacing: 8.0, // Espacio vertical entre las filas
                children: List.generate(10, (nroLote) {
                  bool isReserved =
                      reservasDelDia.any((reserva) => reserva.lote == nroLote);

                  return SizedBox(
                    height: 80,
                    child: Lote(
                      loteData: LoteData(
                        id: nroLote,
                        estaReservado: isReserved,
                      ),
                      onTap: () {
                        print(nroLote);
                        print(fechaSeleccionada);
                        print(vehiculoState.idDuenio);
                        _onButtonPressed(nroLote);
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (fechaSeleccionada != null && _selectedButtonIndex != null) {
                final nuevoUsuarioVehiculo = usuarioVehiculo(
                  idUsuario: usuarioState.id,
                  idVehiculo: vehiculoState.patente,
                );

                await db
                    .collection('Vehiculos')
                    .doc(vehiculoState.patente)
                    .set(vehiculoState.toFireStore());

                await db
                    .collection('UsuariosVehiculos')
                    .add(nuevoUsuarioVehiculo.toFirestore());

                final nuevaReserva = Reserva(
                  fecha: fechaSeleccionada!,
                  lote: _selectedButtonIndex!,
                  elvehiculo: vehiculoState,
                );

                await db.collection('Reservas').add(nuevaReserva.toFirestore());

                // Aquí agregarías la lógica para guardar la nueva reserva

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Reserva realizada para el lote ${nuevaReserva.lote}')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccione una fecha y un lote')),
                );
              }
            },
            child: const Text('Reservar'),
          ),
          ElevatedButton(
              onPressed: () {
                context.goNamed(Login.name);
              },
              child: Text('Volver'))
        ],
      ),
    );
  }
}
