import 'package:app_de_estacionamiento/Core/Entities/Reserva.dart';
import 'package:app_de_estacionamiento/presentations/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  static const String name = 'calendarioReserva';
  const BookingCalendarDemoApp({super.key});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class ButtonData {
  final int id;
  bool isReserved;
  bool isConfirmed;

  ButtonData(this.id, this.isReserved, {this.isConfirmed = false});
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  DateTime? selectedDate;
  List<ButtonData> buttonDataList =
      List<ButtonData>.generate(11, (index) => ButtonData(index, false));
  List<Reserva> reservasDelDia = [];
  int? _selectedButtonIndex;

  final algunasReservas = [
    Reserva(fecha: 7, lote: 1),
    Reserva(fecha: 15, lote: 2),
    Reserva(fecha: 6, lote: 3),
    Reserva(fecha: 10, lote: 4),
  ];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
      // Reset the reservations for the new date
      buttonDataList =
          List<ButtonData>.generate(11, (index) => ButtonData(index, false));
      _selectedButtonIndex = null;
      _filtrarReservasPorFecha(selectedDay.day);
    });
  }

  void _reservePosition(int index) {
    setState(() {
      // Prevent modifying already confirmed reservations
      if (buttonDataList[index].isConfirmed) return;

      // Deselect any previously selected button
      for (var button in buttonDataList) {
        if (!button.isConfirmed) {
          button.isReserved = false;
        }
      }

      // Reserve the newly selected button
      buttonDataList[index].isReserved = true;
      _selectedButtonIndex = index;
    });
  }

  bool _hasReservation() {
    return buttonDataList.any((button) => button.isReserved);
  }

  void _filtrarReservasPorFecha(int dia) {
    setState(() {
      reservasDelDia =
          algunasReservas.where((reserva) => reserva.fecha == dia).toList();
      for (var reserva in reservasDelDia) {
        if (reserva.lote < buttonDataList.length) {
          buttonDataList[reserva.lote].isReserved = true;
          buttonDataList[reserva.lote].isConfirmed = true;
        }
      }
    });
  }

  void _confirmReservation() {
    if (selectedDate != null && _selectedButtonIndex != null) {
      setState(() {
        buttonDataList[_selectedButtonIndex!].isConfirmed = true;
      });
      Reserva reserva =
          Reserva(fecha: selectedDate!.day, lote: _selectedButtonIndex!);
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
              focusedDay: selectedDate ?? DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: _onDaySelected,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            if (selectedDate != null) ...[
              const SizedBox(height: 10),
              Text(
                "Fecha seleccionada: ${selectedDate!.toLocal()}".split(' ')[0],
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2, // Make buttons rectangular
                  ),
                  itemCount: buttonDataList.length,
                  itemBuilder: (context, index) {
                    Color buttonColor;
                    if (buttonDataList[index].isConfirmed) {
                      buttonColor = Colors.red;
                    } else if (buttonDataList[index].isReserved) {
                      buttonColor = Colors.yellow;
                    } else {
                      buttonColor = Colors.blue;
                    }

                    return GestureDetector(
                      onTap: buttonDataList[index].isConfirmed
                          ? null
                          : () => _reservePosition(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "p${buttonDataList[index].id}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: (selectedDate != null && _hasReservation())
          ? FloatingActionButton(
              onPressed: _confirmReservation,
              tooltip: 'Reservar',
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}
