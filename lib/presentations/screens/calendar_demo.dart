import 'package:app_de_estacionamiento/Core/Entities/usuarioVehiculo.dart';
import 'package:app_de_estacionamiento/Core/providers/user_provider.dart';
import 'package:app_de_estacionamiento/Core/providers/vehiculo_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
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
  int? fechaSeleccionada;
  int? _selectedLote;

  


  void _onLoteSelected(int index) {
    setState(() {
      _selectedLote = index;
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
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(kToday.year, kToday.month - 3, kToday.day),
          lastDate: DateTime(kToday.year, kToday.month + 3, kToday.day),
          //currentDate: DateTime(2024, 06, 09),
          onDateChanged: (DateTime value) {
            setState(() {
              fechaSeleccionada = value.day;
              _selectedLote = null;
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
                bool isSelected = reservasDelDia.any((reserva) => reserva.lote == nroLote) || _selectedLote == nroLote;
                

                return SizedBox(
                    
                    height: 80,
                    child: Lote(
                        id: nroLote,
                        isSelected: isSelected,
                        onSelected: () => _onLoteSelected(nroLote)

                        ));
              }),
            ),
          ),
        ),

        ElevatedButton(
            onPressed: () {
              if (fechaSeleccionada != null && _selectedLote != null) {
                Reserva reserva = algunasReservas[0];
                print(reserva.getDatos());
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
                context.goNamed(Home.name);
              },
              child: Text('Volver'))
        ],
      );
    
  }
}
