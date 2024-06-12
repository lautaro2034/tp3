import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/Core/Entities/Vehiculo.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';
import 'package:flutter/material.dart';
import 'package:app_de_estacionamiento/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Calendar_demo extends ConsumerStatefulWidget {
  static const String name = 'calendarDemo';

  const Calendar_demo({super.key});

  @override
  _Calendar_demoState createState() => _Calendar_demoState();
}

class _Calendar_demoState extends ConsumerState<Calendar_demo> {
  final algunasReservas = [
    Reserva(
        fecha: 7,
        lote: 1,
        elvehiculo: Vehiculo(
            patente: 'fgh123',
            marca: 'Ferrari',
            modelo: 'modelo',
            idDuenio: "RIWofZj3xzRRHeMRg73YUZCG89m2")),
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
                print(reserva.toString());
              } else {
                print('Seleccione una fecha y un lote');
              }
            },
            child: const Text('Reservar'))

        

        
      ],
    );
  }
}
