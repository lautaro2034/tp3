/*import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/presentations/widgets/lote.dart';
import 'package:flutter/material.dart';
import 'package:app_de_estacionamiento/utils.dart';

class Calendar_demo extends StatefulWidget {
  const Calendar_demo({super.key});

  @override
  State<Calendar_demo> createState() => _Calendar_demoState();
}

class _Calendar_demoState extends State<Calendar_demo> {

final algunasReservas = [

    Reserva(fecha: 7, lote: 1),
    Reserva(fecha: 15, lote: 2),
    Reserva(fecha: 6, lote: 3),
    Reserva(fecha: 10, lote: 4),
    
  ];

  List<Reserva> reservasDelDia = [];
  int? _selectedButtonIndex;
  int? fechaSeleccionada;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });
  }

  void _filtrarReservasPorFecha(int dia){
    setState(() {
      reservasDelDia = algunasReservas.where((reserva) => reserva.fecha == dia).toList();
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
                bool isSelected = false;
                for (var reserva in reservasDelDia) {
                  if (reserva.lote == nroLote) {
                    isSelected = true;
                    break;
                  }
                }

                return SizedBox(
                  height: 80,

                  child: LoteButton(
                    identificador: 'P$nroLote', 
                    isSelected: _selectedButtonIndex == nroLote || isSelected,
                    onPressed: () => _onButtonPressed(nroLote)
                    ));
              }),
            ),
          ),
        ),

        ElevatedButton(onPressed: () {
          if ( fechaSeleccionada != null && _selectedButtonIndex != null ){
            Reserva reserva = Reserva(fecha: fechaSeleccionada!, lote: _selectedButtonIndex!);
            print(reserva.getData());
          } else {
            print('Seleccione una fecha y un lote');
          }
        }, 
        child: const Text('Reservar'))
        
      ],
    );
  }
}*/