/*import 'dart:async';

import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/Core/Entities/Vehiculo.dart';
import 'package:app_de_estacionamiento/Core/providers/vehiculo_provider.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart'; // Importa el archivo 'lote.dart'

class BookingCalendarDemoApp extends ConsumerStatefulWidget {
  static const String name = 'calendarioReserva';
  const BookingCalendarDemoApp({Key? key}) : super(key: key);

  @override
  _BookingCalendarDemoAppState createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState
    extends ConsumerState<BookingCalendarDemoApp> {
  //Future<void> instanciarArray() async {}

  final lasReservas = [];

  /*.then(snapshot) {
      for (var doc in snapshot.doc){
        /// data
      }
    };
*/

  final elNuevoVehiculo = Vehiculo(
      patente: 'fgh123',
      marca: 'Ferrari',
      modelo: 'modelo',
      idDuenio: "RIWofZj3xzRRHeMRg73YUZCG89m2");

  DateTime? fechaSeleccionada;
  List<LoteData> listaLotes =
      List<LoteData>.generate(11, (index) => LoteData(index, false));
  //Future<QuerySnapshot<Map<String, dynamic>>> reservasDelDia = null!;
  int? _indiceBotonSeleccionado;

  final algunasReservas = [
    Reserva(
        fecha: DateTime.now().day,
        lote: 1,
        elvehiculo: Vehiculo(
            patente: 'fgh123',
            marca: 'Ferrari',
            modelo: 'modelo',
            idDuenio: "RIWofZj3xzRRHeMRg73YUZCG89m2")),
    //Reserva(fecha: 15, lote: 2),
    //Reserva(fecha: 6, lote: 3),
    //Reserva(fecha: 10, lote: 4),
  ];

  void _onDaySelected(DateTime diaSeleccionado, DateTime diaEnfocado) {
    setState(() {
      fechaSeleccionada = diaSeleccionado;
      // Reiniciar las reservas para la nueva fecha
      listaLotes = List.generate(11, (index) {
        
      });
      _indiceBotonSeleccionado = null;
      _filtrarReservasPorFecha(diaSeleccionado.day);
    });
  }

  void _reservarPosicion(int indice) {
    setState(() {
      // Prevenir modificar reservas ya confirmadas
      if (listaLotes[indice].estaConfirmado) return;

      // Deseleccionar cualquier botón previamente seleccionado
      for (var lote in listaLotes) {
        if (!lote.estaConfirmado) {
          lote.estaReservado = false;
        }
      }

      // Reservar el botón recién seleccionado
      listaLotes[indice].estaReservado = true;
      _indiceBotonSeleccionado = indice;
    });
  }

  bool _tieneReserva() {
    return listaLotes.any((lote) => lote.estaReservado);
  }

  bool prueba(int diaReserva, int dia) => diaReserva == dia;

  var listaReservas = [];

  Future<void> _filtrarReservasPorFecha(int dia) async {
    setState(() {
      FirebaseFirestore.instance.collection("cities").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            listaReservas.add(docSnapshot);
            print('${{docSnapshot.id}} => ${{docSnapshot.data()}}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );

      /*   FirebaseFirestore.instance.collection('Reservas').where((reserva) => reserva.fecha == dia).get()
         .then(snapshot){
          for (var reserva in reservasDelDia) {
           if (reserva.lote < listaLotes.length) {
             listaLotes[reserva.lote].estaReservado = true;
              listaLotes[reserva.lote].estaConfirmado = true;
        }
         }
      
      };  */
    });
  }

  void _confirmarReserva() {
    if (fechaSeleccionada != null && _indiceBotonSeleccionado != null) {
      setState(() {
        listaLotes[_indiceBotonSeleccionado!].estaConfirmado = true;
      });
      Reserva reserva = Reserva(
          fecha: fechaSeleccionada!.day,
          lote: _indiceBotonSeleccionado!,
          elvehiculo: elNuevoVehiculo);
      print(reserva.getData());
      context.goNamed(Home.name);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Reservas confirmadas!"),
      ));
    } else {
      print('Seleccione una fecha y un lote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2101),
              focusedDay: fechaSeleccionada ?? DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(fechaSeleccionada, day);
              },
              onDaySelected: _onDaySelected,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            if (fechaSeleccionada != null) ...[
              // Si 'fechaSeleccionada' no es nulo, insertar widgets en la lista de hijos
              const SizedBox(height: 10),
              Text(
                "Fecha seleccionada: ${fechaSeleccionada!.toLocal()}"
                    .split(' ')[0],
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2, // Hacer botones rectangulares
                  ),
                  itemCount: listaLotes.length,
                  itemBuilder: (context, index) {
                    final elLote = Lote(loteData: listaLotes[index]);
                    final elvehiculo = ref.read(vehiculoProvider);

                    final laReserva = Reserva(
                        fecha: fechaSeleccionada!.day,
                        lote: elLote.loteData.id,
                        elvehiculo: elvehiculo);

                    return Lote(
                        loteData: listaLotes[index],
                        onTap: () {
                          print(laReserva);
                          print(fechaSeleccionada.toString());
                          print(elLote.loteData.id);
                          _reservarPosicion(index);

                          FirebaseFirestore.instance
                              .collection('Reservas')
                              .add(laReserva.toFirestore());
                        });
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: (fechaSeleccionada != null && _tieneReserva())
          ? FloatingActionButton(
              onPressed: _confirmarReserva,
              tooltip: 'Reservar',
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}*/
