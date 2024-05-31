import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
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

    Reserva(fecha: "2024-05-31 00:00:00", lote: 1),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 2),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 3),
    Reserva(fecha: "2024-05-31 00:00:00", lote: 4),
    
  ];


  int? _selectedButtonIndex;
  String? fechaSeleccionada;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
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
          onDateChanged: (DateTime value) { 
            setState(() {
              fechaSeleccionada = value.toString();
            });
           },
        ),


        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0, // Espacio horizontal entre los elementos
              runSpacing: 8.0, // Espacio vertical entre las filas
              children: List.generate(10, (index) {
                bool isSelected = false;
                for (var reserva in algunasReservas) {
                  if (reserva.lote == index) {
                    isSelected = true;
                    break;
                  }
                }

                return SizedBox(
                  height: 80,
                  child: LoteButton(
                    identificador: 'P$index', 
                    isSelected: isSelected,
                    onPressed: () => _onButtonPressed(index),
                    ));
              }),
            ),
          ),
        ),

        ElevatedButton(onPressed: () {
         Reserva reserva = Reserva(fecha: fechaSeleccionada!, lote: _selectedButtonIndex!);
          print(reserva.getData());
        }, 
        child: const Text('Reservar'))
        
      ],
    );
  }
}